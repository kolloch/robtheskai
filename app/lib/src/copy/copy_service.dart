import 'dart:async';
import 'package:file/chroot.dart';
import 'package:file/file.dart';
import 'package:glob/glob.dart';
import 'package:robokru/src/copy/copy_event.dart';

import 'cancellation_token.dart';

class CopyService {
  Stream<CopyEvent> copyDirectory(Directory sourceDir, Directory destDir,
      {Glob? glob, CancellationToken? token}) async* {
    if (!await sourceDir.exists()) {
      throw Exception("Source directory does not exist: ${sourceDir.path}");
    }

    if (!await destDir.exists()) {
      throw Exception("Destination directory does not exist: ${destDir.path}");
    }

    final sourceFs = ChrootFileSystem(sourceDir.fileSystem,
        sourceDir.fileSystem.path.canonicalize(sourceDir.path));
    final destFs = ChrootFileSystem(
        destDir.fileSystem, destDir.fileSystem.path.canonicalize(destDir.path));

    yield const CopyEvent.copyStarted();
    if (token?.isCancellationRequested == true) {
      return;
    }

    final sourceFiles = (glob ?? Glob("**/*")).listFileSystem(sourceFs);
    int totalBytes = 0;
    int totalFiles = 0;
    List<File> filesToCopy = [];
    await for (var element in sourceFiles) {
      // ignore hidden files
      if (element.basename.startsWith(".")) {
        continue;
      }

      if (element.path.contains("/.")) {
        continue;
      }

      if (element.basename.endsWith(".tmp") ||
          element.basename == ".DS_Store" ||
          element.basename == "Thumbs.db" ||
          element.basename == "desktop.ini") {
        continue;
      }

      print("Scanning ${element.path}");

      if (token?.isCancellationRequested == true) {
        return;
      }
      FileStat fileStat = await element.stat();

      if (fileStat.type == FileSystemEntityType.file) {
        final existingFile = destFs.file(element.path);
        if (await existingFile.exists() &&
            (await existingFile.lastModified()) == fileStat.changed) {
          print("Skipping ${element.path} because it already exists");
          continue;
        }

        filesToCopy.add(sourceFs.file(element));
        totalBytes += fileStat.size;
        totalFiles++;
      }
      yield CopyEvent.scanningFiles(numberOfFiles: totalFiles);
    }

    int copiedBytes = 0;
    int copiedFiles = 0;
    for (var file in filesToCopy) {
      var tmpFile = destFs.file("${file.path}.tmp");
      await tmpFile.create(recursive: true);
      final IOSink outputFile = tmpFile.openWrite();
      var finished = false;
      try {
        await for (var data in file.openRead()) {
          if (token?.isCancellationRequested == true) {
            return;
          }
          outputFile.add(data);
          await outputFile.flush();
          copiedBytes += data.length;
          yield CopyEvent.copyProgress(
            totalBytes: totalBytes,
            bytesCopied: copiedBytes,
            totalFiles: totalFiles,
            filesCopied: copiedFiles,
          );
          if (token?.isCancellationRequested == true) {
            return;
          }
        }

        finished = true;
      } finally {
        await outputFile.close();

        if (!finished) {
          await tmpFile.delete();
        }
      }
      await tmpFile.rename(file.path);
      destFs.file(file.path).setLastModified(await file.lastModified());
      copiedFiles++;
      yield CopyEvent.copyProgress(
        totalBytes: totalBytes,
        bytesCopied: copiedBytes,
        totalFiles: totalFiles,
        filesCopied: copiedFiles,
      );
    }
    yield CopyEvent.copyProgress(
      totalBytes: totalBytes,
      bytesCopied: copiedBytes,
      totalFiles: totalFiles,
      filesCopied: copiedFiles,
    );
  }
}
