import 'dart:math' as math;

import 'package:design_system/src/components/navigation/base_app_bar.dart';
import 'package:design_system/src/theme/app_theme.dart';
import 'package:design_system/src/tokens/tokens.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter/widgets.dart';
import 'package:material_ui/material_ui.dart' show Brightness, Scaffold, ThemeData;

/// The page shell: scaffold, theme background, safe area and the slots of a screen.
///
/// From the top: [appBar], a [notice] (one top notice or banner that pushes the body down, never covers
/// it), the [body] (the only scroll area) and a sticky [footer] (the tab bar or the actions, 20 from the
/// sides and 34 from the bottom edge). The body shrinks above the keyboard so a focused field and the
/// footer stay visible.
class const BaseView({
  required final Widget body,
  final Widget? appBar = const BaseAppBar(),
  final Widget? notice,
  final Widget? footer,
  final bool hasSafeArea = true,
  final bool resizeToAvoidBottomInset = true,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBar = this.appBar;
    final safeBottom = hasSafeArea ? MediaQuery.paddingOf(context).bottom : 0.0;
    final background = context.colors.bgScreen;
    final backgroundBrightness = ThemeData.estimateBrightnessForColor(background);
    final iconBrightness = backgroundBrightness == Brightness.dark
        ? Brightness.light
        : Brightness.dark;
    final content = Column(
      children: [
        if (appBar != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpace.screenMargin,
              AppSpace.screenTop,
              AppSpace.screenMargin,
              AppSpace.s8,
            ),
            child: appBar,
          ),
        if (notice != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpace.screenMargin,
              0,
              AppSpace.screenMargin,
              AppSpace.s12,
            ),
            child: notice,
          ),
        Expanded(child: body),
        if (footer != null)
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpace.screenMargin,
              AppSpace.s12,
              AppSpace.screenMargin,
              math.max(AppSpace.s12, AppSpace.footerBottom - safeBottom),
            ),
            child: footer,
          ),
      ],
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: background,
        statusBarIconBrightness: iconBrightness,
        statusBarBrightness: backgroundBrightness,
        systemNavigationBarColor: background,
        systemNavigationBarIconBrightness: iconBrightness,
      ),
      child: Scaffold(
        backgroundColor: background,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: hasSafeArea ? SafeArea(child: content) : content,
      ),
    );
  }
}
