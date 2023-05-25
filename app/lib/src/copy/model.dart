import 'package:file/file.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glob/glob.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'cancellation_token.dart';

part 'model.freezed.dart';

@freezed
sealed class CopyEvent with _$CopyEvent {
  const CopyEvent._();

  const factory CopyEvent.copyStarted() = CopyStarted;
  const factory CopyEvent.copyCancelled(CopyProgress lastEvent) = CopyCancelled;
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
        CopyCancelled _ => true,
        _ => false,
      };

  bool get isUnfinished => !isFinished;
}

@freezed
class CopyFiles with _$CopyFiles {
  const factory CopyFiles(
      {required Directory srcVolume,
      required Directory dstVolume,
      required CopyRule rule,
      required CancellationToken token,
      @Default(AsyncValue.loading()) AsyncValue<CopyEvent> lastEvent,
      CopyFiles? followUp}) = _CopyFiles;
}

@freezed
class CopyRule with _$CopyRule {
  const factory CopyRule({
    required final Glob srcGlob,
    final String? dstSubPath,
    @Default(false) final bool flatten,
    @Default(false) final bool byDate,
  }) = _CopyRule;
}
