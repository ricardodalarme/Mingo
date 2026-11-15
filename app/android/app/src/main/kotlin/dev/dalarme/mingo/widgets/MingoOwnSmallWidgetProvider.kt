package dev.dalarme.mingo.widgets

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import dev.dalarme.mingo.R

class MingoOwnSmallWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        val payload = MingoWidgetPayload.load(context)
        for (appWidgetId in appWidgetIds) {
            if (payload.renderGuardState(context, appWidgetManager, appWidgetId, requirePaired = false)) {
                continue
            }
            val days = payload.daysUntilNextDate()
            when {
                days != null && !payload.nextDateTitle.isNullOrBlank() -> MingoWidgetPayload.renderCard(
                    context = context,
                    appWidgetManager = appWidgetManager,
                    appWidgetId = appWidgetId,
                    label = context.getString(R.string.mingo_widget_next_date_label),
                    title = context.getString(R.string.mingo_widget_days_count, days.toInt()),
                    subtitle = payload.nextDateTitle,
                    deepLink = "mingo://dates?homeWidget=1",
                )
                !payload.ritualTitle.isNullOrBlank() -> MingoWidgetPayload.renderCard(
                    context = context,
                    appWidgetManager = appWidgetManager,
                    appWidgetId = appWidgetId,
                    label = context.getString(R.string.mingo_widget_ritual_label),
                    title = payload.ritualTitle,
                    subtitle = payload.ritualSchedule
                        ?: context.getString(R.string.mingo_widget_ritual_default_schedule),
                    deepLink = "mingo://rituals?homeWidget=1",
                )
                !payload.myMood.isNullOrBlank() -> MingoWidgetPayload.renderCard(
                    context = context,
                    appWidgetManager = appWidgetManager,
                    appWidgetId = appWidgetId,
                    label = context.getString(R.string.mingo_widget_mood_label),
                    title = payload.myMood,
                    subtitle = context.getString(R.string.mingo_widget_mood_subtitle),
                    deepLink = "mingo://mood?homeWidget=1",
                )
                else -> MingoWidgetPayload.renderCard(
                    context = context,
                    appWidgetManager = appWidgetManager,
                    appWidgetId = appWidgetId,
                    label = context.getString(R.string.mingo_widget_slip_label),
                    title = context.getString(R.string.mingo_widget_slip_title),
                    subtitle = context.getString(R.string.mingo_widget_slip_subtitle),
                    deepLink = "mingo://capture?homeWidget=1",
                )
            }
        }
    }
}
