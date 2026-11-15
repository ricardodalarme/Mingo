package dev.dalarme.mingo.widgets

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import dev.dalarme.mingo.R

class MingoCoupleCounterWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        val payload = MingoWidgetPayload.load(context)
        for (appWidgetId in appWidgetIds) {
            if (payload.renderGuardState(context, appWidgetManager, appWidgetId, requirePaired = true)) {
                continue
            }
            val days = payload.daysTogether()
            val title = if (days != null) {
                context.getString(R.string.mingo_widget_days_count, days.toInt())
            } else {
                context.getString(R.string.mingo_widget_counter_unset)
            }
            val subtitle = (if (payload.showNames) payload.partnerName else null)
                ?: context.getString(R.string.mingo_widget_counter_default_subtitle)
            MingoWidgetPayload.renderCard(
                context = context,
                appWidgetManager = appWidgetManager,
                appWidgetId = appWidgetId,
                label = context.getString(R.string.mingo_widget_counter_label),
                title = title,
                subtitle = subtitle,
                deepLink = "mingo://together?homeWidget=1",
            )
        }
    }
}
