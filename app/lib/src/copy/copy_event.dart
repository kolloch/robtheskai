import 'package:freezed_annotation/freezed_annotation.dart';

part 'copy_event.freezed.dart';

@freezed
sealed class CopyEvent with _$CopyEvent {
  const CopyEvent._();

  const factory CopyEvent.copyStarted() = CopyStarted;
  const factory CopyEvent.scanningFiles({required int numberOfFiles}) =
      ScanningFiles;
  const factory CopyEvent.copyProgress({
    required int totalBytes,
    required int bytesCopied,
    required int totalFiles,
    required int filesCopied,
  }) = CopyProgress;

  bool get isFinished => switch (this) {
        CopyProgress p => p.bytesCopied == p.totalBytes,
        _ => false,
      };

  bool get isUnfinished => !isFinished;
}
