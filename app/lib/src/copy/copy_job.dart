import 'dart:io';
import 'dart:async';
import 'package:robokru/src/copy/copy_event.dart';

import 'cancellation_token.dart';

class CopyService {
  Stream<CopyEvent> copyDirectory(Directory sourceDir, Directory destDir,
      [CancellationToken? token]) async* {
    if (!await sourceDir.exists()) {
      throw Exception("Source directory does not exist: ${sourceDir.path}");
    }

    if (!await destDir.exists()) {
      throw Exception("Destination directory does not exist: ${destDir.path}");
    }

    yield const CopyEvent.copyStarted();
    if (token?.isCancellationRequested == true) {
      return;
    }

    final sourceFiles = sourceDir.list(recursive: true);
    int totalBytes = 0;
    int totalFiles = 0;
    List<File> filesToCopy = [];
    await for (var element in sourceFiles) {
      if (element is File) {
        filesToCopy.add(element);
        totalBytes += element.lengthSync();
        totalFiles++;
      }
      yield CopyEvent.scanningFiles(numberOfFiles: totalFiles);
      if (token?.isCancellationRequested == true) {
        return;
      }
    }

    int copiedBytes = 0;
    int copiedFiles = 0;
    for (var file in filesToCopy) {
      final newPath = file.path.replaceFirst(sourceDir.path, destDir.path);
      final outputFile = File(newPath).openWrite();
      await for (var data in file.openRead()) {
        outputFile.add(data);
        copiedBytes += data.length;
        yield CopyEvent.copyProgress(
          totalBytes: totalBytes,
          bytesCopied: copiedBytes,
          totalFiles: totalFiles,
          filesCopied: copiedFiles,
        );
        if (token?.isCancellationRequested == true) {
          await outputFile.close();
          return;
        }
        await outputFile.close();
        copiedFiles++;
        yield CopyEvent.copyProgress(
          totalBytes: totalBytes,
          bytesCopied: copiedBytes,
          totalFiles: totalFiles,
          filesCopied: copiedFiles,
        );
      }
    }
  }
}
