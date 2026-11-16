import 'package:design_system/design_system.dart';
import 'package:flutter/rendering.dart' show OverflowBoxFit;
import 'package:material_ui/material_ui.dart';

const double _barHeight = 40;
const double _touchOverflow = (AppIconSize.touch - _barHeight) / 2;
const double _scrolledSurfaceOpacity = .94;

/// The page app bar with leading, centre title and trailing slots.
///
/// The bar is 40 high; the round buttons keep a 44 point touch target by overflowing the bar by 2 points
/// on each side.
///
/// The flow and detail forms centre the [title] between a back or close button and [trailing]. The root
/// form ([isRoot]) is for the tab screens: a free [leading] slot (home passes an avatar pair), a left
/// aligned `titleXl` for sections and free [trailing] slots (home passes a chip). Only a root bar carries a
/// large title.
///
/// When [hasScrolled] it gains a translucent surface and a bottom hairline.
class const BaseAppBar({
  final Widget? leading,
  final bool isRoot = false,
  final String? title,
  final Widget? titleWidget,
  final String? subtitle,
  final VoidCallback? onBack,
  final VoidCallback? onClose,
  final Widget? trailing,
  final Widget? stepIndicator,
  final bool hasScrolled = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final localizations = Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);
    final defaultOnBack = onClose == null ? _pageBack(context) : null;
    final resolvedOnBack = onBack ?? defaultOnBack;

    final Widget resolvedLeading;
    if (leading != null) {
      resolvedLeading = leading!;
    } else if (isRoot) {
      resolvedLeading = const SizedBox.shrink();
    } else if (resolvedOnBack != null) {
      resolvedLeading = BaseRoundButton(
        icon: AppIcons.chevron_left,
        onPressed: resolvedOnBack,
        semanticLabel: localizations?.backButtonTooltip,
      );
    } else if (onClose != null) {
      resolvedLeading = BaseRoundButton(
        icon: AppIcons.close,
        onPressed: onClose,
        semanticLabel: localizations?.closeButtonTooltip,
      );
    } else {
      resolvedLeading = const SizedBox(width: AppIconSize.touch);
    }

    return HitSlop(
      slop: const EdgeInsets.only(top: _touchOverflow),
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpace.s8),
        child: HitSlop(
          slop: const EdgeInsets.only(bottom: _touchOverflow),
          child: AnimatedContainer(
            duration: context.motionDuration(AppMotion.base),
            constraints: const BoxConstraints(minHeight: _barHeight),
            decoration: BoxDecoration(
              color: hasScrolled
                  ? colors.bgScreen.withValues(alpha: _scrolledSurfaceOpacity)
                  : null,
              border: hasScrolled ? Border(bottom: BorderSide(color: colors.borderDefault)) : null,
            ),
            child: Row(
              children: [
                _slot(resolvedLeading),
                Expanded(
                  child: isRoot
                      ? _RootTitle(title: title, titleWidget: titleWidget)
                      : _Centre(
                          title: title,
                          titleWidget: titleWidget,
                          subtitle: subtitle,
                          stepIndicator: stepIndicator,
                        ),
                ),
                if (trailing != null)
                  _slot(trailing!)
                else if (!isRoot)
                  const SizedBox(width: AppIconSize.touch),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _slot(Widget child) {
    return SizedBox(
      height: _barHeight,
      child: OverflowBox(
        maxHeight: AppIconSize.touch,
        fit: OverflowBoxFit.deferToChild,
        child: child,
      ),
    );
  }

  VoidCallback? _pageBack(BuildContext context) {
    final route = ModalRoute.of(context);
    final navigator = Navigator.maybeOf(context);
    if (route == null || navigator == null) return null;
    if (route.canPop) return navigator.maybePop;

    final rootNavigator = Navigator.maybeOf(context, rootNavigator: true);
    if (rootNavigator != null && rootNavigator != navigator && rootNavigator.canPop()) {
      return rootNavigator.maybePop;
    }

    return null;
  }
}

class const _RootTitle({required final String? title, required final Widget? titleWidget})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.s4),
        child:
            titleWidget ??
            (title == null
                ? const SizedBox.shrink()
                : Semantics(
                    header: true,
                    child: Text(
                      title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.text.titleXl.copyWith(color: context.colors.textPrimary),
                    ),
                  )),
      ),
    );
  }
}

class const _Centre({
  required final String? title,
  required final Widget? titleWidget,
  required final String? subtitle,
  required final Widget? stepIndicator,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final heading = title;
    final headingWidget = titleWidget;
    final support = subtitle;
    final steps = stepIndicator;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (headingWidget != null)
            headingWidget
          else if (heading != null)
            Text(
              heading,
              style: context.text.titleXs.copyWith(color: colors.textPrimary),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          if (support != null)
            Text(
              support,
              style: context.text.bodySm.copyWith(color: colors.textSecondary),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          if (steps != null)
            Padding(
              padding: EdgeInsets.only(
                top: heading == null && headingWidget == null && support == null ? 0 : AppSpace.s6,
              ),
              child: steps,
            ),
        ],
      ),
    );
  }
}
