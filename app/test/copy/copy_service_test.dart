import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robokru/src/copy/cancellation_token.dart';
import 'package:robokru/src/copy/copy_event.dart';
import 'package:robokru/src/copy/copy_service.dart';

void main() {
  group('CopyService', () {
    final CopyService copyService = CopyService();

    test('should copy no files from empty source to dest', () async {
      final sourceFs = MemoryFileSystem();
      final destFs = MemoryFileSystem();

      final sourceDir = sourceFs.directory('test/copy/source');
      await sourceDir.create(recursive: true);
      final destDir = destFs.directory('test/copy/dest');
      await destDir.create(recursive: true);
      final token = CancellationToken();

      final stream =
          copyService.copyDirectory(sourceDir, destDir, token: token);

      expect(
          stream,
          emitsInOrder([
            const CopyEvent.copyStarted(),
            const CopyEvent.copyProgress(
              totalBytes: 0,
              bytesCopied: 0,
              totalFiles: 0,
              filesCopied: 0,
            ),
          ]));
    });

    test('should copy some files from source to dest', () async {
      final sourceFs = MemoryFileSystem();
      final destFs = MemoryFileSystem();

      final sourceDir = sourceFs.directory('test/copy/source');
      await sourceDir.create(recursive: true);

      final file1 = sourceDir.childFile('file1.txt');
      await file1.writeAsString('file1');

      final destDir = destFs.directory('test/copy/dest');
      await destDir.create(recursive: true);
      final token = CancellationToken();

      final stream =
          copyService.copyDirectory(sourceDir, destDir, token: token);

      final lastProgress = await stream.last;

      final files = await destDir
          .list()
          .fold([], (previous, element) => previous + [element]);
      expect(files, hasLength(1));
      expect(files[0].path, 'test/copy/dest/file1.txt');

      expect(
          lastProgress,
          const CopyEvent.copyProgress(
              totalBytes: 5, bytesCopied: 5, totalFiles: 1, filesCopied: 1));
    });
  });
}
