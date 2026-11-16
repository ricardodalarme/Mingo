import 'dart:math' as math;

import 'package:design_system/design_system.dart';
import 'package:design_system/design_system_l10n.dart';

/// What a [BaseVoiceRecorder] is doing.
enum BaseVoiceStatus() {
  /// Flat bars and 00:00, waiting to record.
  idle,

  /// The bars follow the mic level and the timer counts.
  recording,

  /// A take exists; Record becomes Send and Cancel becomes Re-record.
  recorded,

  /// The take is being sent.
  uploading,

  /// Sending failed; the take is kept.
  failed,
}

const double _barWidth = 5;
const double _barGap = 6;
const double _bandHeight = 90;
const double _minBar = 20;
const double _maxBar = 70;
const int _idleBars = 24;

/// A framed recorder card with a live waveform, a timer and an action bar.
///
/// It only draws and reports: recording, permission and upload belong to the feature, which feeds
/// [status], [elapsed] and [levels] (0 to 1 per bar). Nothing is sent until the person taps Send. Under
/// reduced motion the bars draw a static level meter. [maxDuration] is shown as the limit in the
/// semantics value and the feature stops at it. The timer is announced every ten seconds while recording.
class const BaseVoiceRecorder({
  required final BaseVoiceStatus status,
  required final Duration elapsed,
  required final Duration maxDuration,
  final List<double> levels = const [],
  final String? errorText,
  final VoidCallback? onRecord,
  final VoidCallback? onStop,
  final VoidCallback? onCancel,
  final VoidCallback? onSend,
  final VoidCallback? onRerecord,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.designSystemL10nOrBase;

    final first = switch (status) {
      .idle || .recording => BaseButton.secondary(
        text: l10n.common.cancel,
        onPressed: onCancel,
        isFullWidth: true,
      ),
      .recorded || .uploading || .failed => BaseButton.secondary(
        text: l10n.media.reRecord,
        onPressed: status == .uploading ? null : onRerecord,
        isFullWidth: true,
      ),
    };
    final second = switch (status) {
      .idle => BaseButton.primary(text: l10n.media.record, onPressed: onRecord),
      .recording => BaseButton.primary(text: l10n.media.stop, onPressed: onStop),
      .recorded || .failed => BaseButton.primary(text: l10n.common.send, onPressed: onSend),
      .uploading => BaseButton.primary(text: l10n.common.send, isLoading: true, onPressed: onSend),
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          container: true,
          liveRegion: status == .recording && elapsed.inSeconds % 10 == 0,
          label: _timer(elapsed),
          child: ExcludeSemantics(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colors.bgSurface,
                borderRadius: BorderRadius.circular(AppRadius.card),
                border: AppBorders.hair(colors.borderDefault),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: AppSpace.s20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppSpace.s20,
                  children: [
                    SizedBox(
                      height: _bandHeight,
                      child: _Waveform(
                        levels: status == .idle ? const [] : levels,
                        color: colors.accentHighlight.withValues(alpha: .55),
                      ),
                    ),
                    Text(
                      _timer(elapsed),
                      style: context.text.display.copyWith(
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: AppSpace.s12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppSpace.s6,
              children: [
                const AppIcon(icon: AppIcons.warning, size: 16, color: AppPalette.errorInk),
                Flexible(
                  child: Text(
                    errorText!,
                    textAlign: TextAlign.center,
                    style: context.text.caption.copyWith(color: AppPalette.errorInk),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: AppSpace.s20),
        Row(
          spacing: AppSpace.s10,
          children: [
            Expanded(child: first),
            Expanded(child: second),
          ],
        ),
      ],
    );
  }
}

String _timer(Duration value) {
  final minutes = value.inMinutes.toString().padLeft(2, '0');
  final seconds = (value.inSeconds % 60).toString().padLeft(2, '0');

  return '$minutes:$seconds';
}

class const _Waveform({required final List<double> levels, required final Color color})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final values = levels.isEmpty ? List<double>.filled(_idleBars, 0) : levels;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: _barGap,
      children: [
        for (final level in values)
          Container(
            width: _barWidth,
            height: _minBar + (_maxBar - _minBar) * math.min(math.max(level, 0), 1),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
          ),
      ],
    );
  }
}

/// The compact player row: a play button, a waveform with progress and the duration.
///
/// The waveform exposes a slider for the position so it can be adjusted without dragging: [onSeek]
/// receives the new fraction. Playback pauses on a call or when leaving the screen: that is the
/// feature's job.
class const BaseVoicePlayer({
  required final Duration duration,
  required final bool isPlaying,
  required final VoidCallback onToggle,
  final double progress = 0,
  final List<double> levels = const [],
  final ValueChanged<double>? onSeek,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.designSystemL10nOrBase.media;
    final bars = levels.isEmpty
        ? List<double>.generate(28, (index) => .2 + .6 * ((index * 7) % 5) / 4)
        : levels;
    final played = (progress.clamp(0.0, 1.0) * bars.length).round();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: AppSpace.s10),
      decoration: BoxDecoration(
        color: colors.bgSurface,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        border: AppBorders.hair(colors.borderDefault),
      ),
      child: Row(
        spacing: AppSpace.s12,
        children: [
          AppPressable(
            onTap: onToggle,
            semanticLabel: isPlaying ? l10n.pause : l10n.play,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            enforceMinTapTarget: true,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: colors.actionPrimary, shape: BoxShape.circle),
              child: Center(
                child: AppIcon(
                  icon: isPlaying ? AppIcons.pause : AppIcons.play,
                  color: colors.textOnAction,
                ),
              ),
            ),
          ),
          Expanded(
            child: Semantics(
              slider: true,
              value: '${(progress * 100).round()}%',
              increasedValue: '${((progress + .1).clamp(0.0, 1.0) * 100).round()}%',
              decreasedValue: '${((progress - .1).clamp(0.0, 1.0) * 100).round()}%',
              onIncrease: onSeek == null ? null : () => onSeek!((progress + .1).clamp(0.0, 1.0)),
              onDecrease: onSeek == null ? null : () => onSeek!((progress - .1).clamp(0.0, 1.0)),
              child: ExcludeSemantics(
                child: SizedBox(
                  height: 28,
                  child: Row(
                    spacing: 3,
                    children: [
                      for (var index = 0; index < bars.length; index++)
                        Expanded(
                          child: Center(
                            child: Container(
                              height: 6 + 22 * bars[index].clamp(0.0, 1.0),
                              decoration: BoxDecoration(
                                color: index < played
                                    ? colors.accentHighlight
                                    : AppPalette.neutral200,
                                borderRadius: BorderRadius.circular(1.5),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ExcludeSemantics(
            child: Text(
              '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
              style: context.text.caption.copyWith(
                color: colors.textSecondary,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
