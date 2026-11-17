package dev.dalarme.mingo.widgets

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import dev.dalarme.mingo.R

class MingoLongingWidgetProvider : AppWidgetProvider() {
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
            val receivedAt = payload.partnerMissedAt
            MingoWidgetPayload.renderCard(
                context = context,
                appWidgetManager = appWidgetManager,
                appWidgetId = appWidgetId,
                label = context.getString(R.string.mingo_widget_longing_label),
                title = context.getString(
                    if (receivedAt.isNullOrBlank()) R.string.mingo_widget_longing_action
                    else R.string.mingo_widget_longing_received,
                ),
                subtitle = if (receivedAt.isNullOrBlank()) {
                    context.getString(R.string.mingo_widget_longing_hint)
                } else {
                    MingoWidgetPayload.relativeTime(context, receivedAt)
                },
                deepLink = "mingo://today?homeWidget=1",
            )
        }
    }
}
