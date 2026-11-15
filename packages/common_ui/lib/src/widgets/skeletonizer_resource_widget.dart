import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/design_system_l10n.dart';

typedef SuccessBuilder<T> = Widget Function(T value);
typedef FailureBuilder = Widget Function(LocalizedException exception);

class const SkeletonizerResourceWidget<T>(
  final Resource<T> resource, {
  required final T fakeValue,
  required final SuccessBuilder<T> successBuilder,
  required final FailureBuilder failureBuilder,
  super.key,
}) extends StatefulWidget {
  @override
  State<SkeletonizerResourceWidget<T>> createState() => _SkeletonizerResourceWidgetState<T>();
}

class _SkeletonizerResourceWidgetState<T>()
    extends State<SkeletonizerResourceWidget<T>>
    with SingleTickerProviderStateMixin {
  late final AnimationController _reveal = AnimationController(vsync: this, value: 1);
  late final CurvedAnimation _fade = CurvedAnimation(parent: _reveal, curve: AppMotion.fastCurve);
  late T _fakeData;

  @override
  void initState() {
    super.initState();
    _fakeData = widget.fakeValue;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reveal.duration = context.motionDuration(AppMotion.fast);
  }

  @override
  void didUpdateWidget(covariant SkeletonizerResourceWidget<T> oldWidget) {
    // Reuse the previous success value while loading new data so the screen
    // keeps its visual state.
    if (oldWidget.resource is Success<T> && widget.resource is Loading) {
      _fakeData = (oldWidget.resource as Success<T>).value;
    }

    if (oldWidget.resource.isLoading && widget.resource is Success<T>) _reveal.forward(from: 0);

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _fade.dispose();
    _reveal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // A successful null is a real value (for example "not visible"); only a
    // loading slot falls back to the fake.
    final value = switch (widget.resource) {
      Success<T>(:final value) => value,
      _ => _fakeData,
    };

    return switch (widget.resource) {
      Initial() => const SizedBox.shrink(),
      Failure(:final exception) => widget.failureBuilder(exception),
      Loading() || Success() => FadeTransition(
        opacity: _fade,
        child: Skeletonizer(
          enabled: widget.resource.isLoading,
          child: _buildContent(context, value),
        ),
      ),
    };
  }

  Widget _buildContent(BuildContext context, T value) {
    final content = widget.successBuilder(value);
    if (!widget.resource.isLoading) return content;

    return Semantics(
      liveRegion: true,
      label: context.designSystemL10nOrBase.common.loading,
      child: ExcludeSemantics(child: content),
    );
  }
}
