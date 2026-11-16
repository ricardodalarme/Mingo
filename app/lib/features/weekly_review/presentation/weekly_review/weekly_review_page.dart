import 'package:app/features/weekly_review/data/models/weekly_review.dart';
import 'package:app/features/weekly_review/presentation/weekly_review/cubit/weekly_review_cubit.dart';
import 'package:app/features/weekly_review/presentation/weekly_review/widgets/weekly_review_body.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class const WeeklyReviewPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<WeeklyReviewCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.weeklyReview;
    final review = context.select((WeeklyReviewCubit cubit) => cubit.state.review);

    return BaseView(
      appBar: BaseAppBar(onClose: () => context.router.maybePop()),
      body: SkeletonizerResourceWidget<WeeklyReview>(
        review,
        fakeValue: WeeklyReview.fake(),
        successBuilder: (value) => WeeklyReviewBody(review: value),
        failureBuilder: (failure) => BaseEmptyState(
          title: l10n.errorTitle,
          text: l10n.errors.selectOrFallback(failure.l10nKey),
          actionText: context.l10n.common.retry,
          onAction: context.read<WeeklyReviewCubit>().load,
        ),
      ),
    );
  }
}
