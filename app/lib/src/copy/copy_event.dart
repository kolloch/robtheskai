import 'package:freezed_annotation/freezed_annotation.dart';

part 'copy_event.freezed.dart';

@freezed
abstract class CopyEvent with _$CopyEvent {
  const factory CopyEvent.copyStarted() = _CopyStarted;
  const factory CopyEvent.scanningFiles({required int numberOfFiles}) =
      _ScanningFiles;
  const factory CopyEvent.copyProgress({
    required int totalBytes,
    required int bytesCopied,
    required int totalFiles,
    required int filesCopied,
  }) = _CopyProgress;
}
