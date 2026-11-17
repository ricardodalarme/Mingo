package dev.dalarme.mingo.widgets

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import dev.dalarme.mingo.R
import java.time.LocalDate

class MingoOwnMediumWidgetProvider : AppWidgetProvider() {
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
            when {
                payload.slipsThisWeek > 0 -> {
                    val activeDays = payload.slipDays.mapNotNull { raw ->
                        try {
                            LocalDate.parse(raw.take(10)).dayOfWeek.value
                        } catch (_: Exception) {
                            null
                        }
                    }.toSet()
                    val labels = context.resources.getStringArray(R.array.mingo_widget_weekdays)
                    val dayLine = labels.mapIndexedNotNull { index, label ->
                        if (activeDays.contains(index + 1)) label else null
                    }.joinToString(" · ")
                    MingoWidgetPayload.renderCard(
                        context = context,
                        appWidgetManager = appWidgetManager,
                        appWidgetId = appWidgetId,
                        label = context.getString(R.string.mingo_widget_week_label),
                        title = context.getString(
                            R.string.mingo_widget_week_count,
                            payload.slipsThisWeek,
                        ),
                        subtitle = dayLine,
                        deepLink = "mingo://slips?homeWidget=1",
                    )
                }
                !payload.dailyIdeaTitle.isNullOrBlank() -> MingoWidgetPayload.renderCard(
                    context = context,
                    appWidgetManager = appWidgetManager,
                    appWidgetId = appWidgetId,
                    label = context.getString(R.string.mingo_widget_idea_label),
                    title = payload.dailyIdeaTitle,
                    subtitle = context.getString(R.string.mingo_widget_idea_subtitle),
                    deepLink = "mingo://today?homeWidget=1",
                )
                else -> MingoWidgetPayload.renderCard(
                    context = context,
                    appWidgetManager = appWidgetManager,
                    appWidgetId = appWidgetId,
                    label = context.getString(R.string.mingo_widget_next_date_label),
                    title = payload.daysUntilNextDate()?.let {
                        context.getString(R.string.mingo_widget_days_count, it.toInt())
                    } ?: context.getString(R.string.mingo_widget_next_date_empty),
                    subtitle = payload.nextDateTitle.orEmpty(),
                    deepLink = payload.nextDateOn?.let { "mingo://dates?homeWidget=1" }
                        ?: "mingo://today?homeWidget=1",
                )
            }
        }
    }
}
