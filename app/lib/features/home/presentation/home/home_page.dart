import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';

const int _captureIndex = 2;

/// How far the incoming tab lifts into place, as a fraction of its height.
const double _tabRiseFraction = .012;

/// Fades the incoming tab in from the page background and lifts it into place.
///
/// Reduced motion swaps the tab with no movement.
Widget homeTabTransition(BuildContext context, Widget child, Animation<double> animation) {
  if (context.reduceMotion) return child;

  return FadeTransition(
    opacity: animation,
    child: SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, _tabRiseFraction),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    ),
  );
}

/// Tab icons in display order, with the capture action in the middle.
const List<IconData> homeTabIcons = [
  AppIcons.home,
  AppIcons.note,
  AppIcons.plus,
  AppIcons.message,
  AppIcons.rings,
];

@RoutePage()
class const HomePage({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.tabs;

    return BaseView(
      appBar: null,
      hasSafeArea: false,
      body: AutoTabsRouter(
        duration: AppMotion.base,
        curve: AppMotion.fastCurve,
        transitionBuilder: homeTabTransition,
        routes: const [TodayRoute(), SlipsRoute(), ChatTabRoute(), CoupleRoute()],
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          final activeIndex = tabsRouter.activeIndex;

          return Column(
            children: [
              Expanded(
                // The outer BaseView owns keyboard insets and the tab bar owns
                // the bottom safe area; tab pages must not add either twice.
                child: MediaQuery.removePadding(
                  context: context,
                  removeBottom: true,
                  child: Builder(
                    builder: (context) => MediaQuery.removeViewInsets(
                      context: context,
                      removeBottom: true,
                      child: child,
                    ),
                  ),
                ),
              ),
              BaseTabBar(
                currentIndex: activeIndex < _captureIndex ? activeIndex : activeIndex + 1,
                onSelected: (index) {
                  if (index == _captureIndex) {
                    context.router.root.push(const QuickSlipRoute());
                    return;
                  }
                  tabsRouter.setActiveIndex(index < _captureIndex ? index : index - 1);
                },
                menuItems: [
                  BaseMenuItem(
                    id: 'slip',
                    icon: AppIcons.pencil,
                    label: l10n.plusSlip,
                    isPrimary: true,
                  ),
                  BaseMenuItem(id: 'need', icon: AppIcons.heart, label: l10n.plusNeed),
                  BaseMenuItem(id: 'note', icon: AppIcons.send, label: l10n.plusNote),
                ],
                onMenuSelected: (item) {
                  context.router.root.push(switch (item.id) {
                    'need' => const NeedRoute(),
                    'note' => const ComposeRoute(),
                    _ => const QuickSlipRoute(),
                  });
                },
                items: [
                  BaseTabBarItem(icon: homeTabIcons[0], label: l10n.today),
                  BaseTabBarItem(icon: homeTabIcons[1], label: l10n.slips),
                  BaseTabBarItem(icon: homeTabIcons[2], label: l10n.capture, isPrimaryAction: true),
                  BaseTabBarItem(icon: homeTabIcons[3], label: l10n.chat),
                  BaseTabBarItem(icon: homeTabIcons[4], label: l10n.couple),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
