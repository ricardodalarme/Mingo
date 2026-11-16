import 'package:design_system/design_system.dart';
import 'package:design_system/design_system_l10n.dart';

const double _cardGap = 12;
const double _dotsGap = 12;
const double _peek = 20;
const double _minCardHeight = 178;
const double _viewportSideInset = 90;
const int _maxPages = 5;

/// A horizontal pager of cards with page dots below.
///
/// The next card peeks 20 points past the edge, every page takes the height of the tallest
/// card and a single page renders full width with no dots and no swiping. The component never
/// advances by itself and accepts at most five pages. Each child is built twice, once hidden to
/// measure the tallest page, so a child must not hold a `GlobalKey`.
class const BaseCarousel({
  /// The cards; the feature owns their order and content.
  required final List<Widget> children,

  /// Called when the settled page changes.
  final ValueChanged<int>? onPageChanged,

  /// The page shown first and restored after a rebuild.
  final int initialPage = 0,

  /// The least height of the pages.
  final double minCardHeight = _minCardHeight,
  super.key,
}) extends StatefulWidget {
  @override
  State<BaseCarousel> createState() => _BaseCarouselState();
}

class _BaseCarouselState() extends State<BaseCarousel> {
  late int _index = widget.initialPage.clamp(0, widget.children.length - 1);
  PageController? _controller;
  double? _fraction;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  PageController _controllerFor(double fraction) {
    if (_controller == null || _fraction != fraction) {
      _controller?.dispose();
      _fraction = fraction;
      _controller = PageController(initialPage: _index, viewportFraction: fraction);
    }

    return _controller!;
  }

  @override
  Widget build(BuildContext context) {
    final children = widget.children;
    assert(children.length <= _maxPages, 'A carousel holds at most five pages');
    if (children.isEmpty) return const SizedBox.shrink();

    final l10n = context.designSystemL10nOrBase.navigation;

    if (children.length == 1) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.screenMargin),
        child: children.first,
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        final cardWidth = width - _viewportSideInset;
        final controller = _controllerFor((cardWidth + _cardGap) / (width - _peek));

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: _peek),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: widget.minCardHeight),
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      for (final child in children)
                        Visibility(
                          visible: false,
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: Padding(
                            padding: const EdgeInsets.only(right: _cardGap),
                            child: SizedBox(width: cardWidth, child: child),
                          ),
                        ),
                      Positioned.fill(
                        child: PageView.builder(
                          controller: controller,
                          padEnds: false,
                          clipBehavior: Clip.none,
                          itemCount: children.length,
                          onPageChanged: (page) {
                            setState(() => _index = page);
                            AppHaptics.selection();
                            widget.onPageChanged?.call(page);
                          },
                          itemBuilder: (context, page) => Padding(
                            padding: const EdgeInsets.only(right: _cardGap),
                            child: Semantics(
                              container: true,
                              label: l10n.cardOf(current: page + 1, total: children.length),
                              child: children[page],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: _dotsGap),
            BasePageDots(count: children.length, index: _index),
          ],
        );
      },
    );
  }
}
