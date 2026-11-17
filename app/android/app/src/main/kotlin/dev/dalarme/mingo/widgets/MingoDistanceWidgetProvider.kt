package dev.dalarme.mingo.widgets

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import dev.dalarme.mingo.R

class MingoDistanceWidgetProvider : AppWidgetProvider() {
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
            val ownZone = payload.ownZone
            val partnerZone = payload.partnerZone
            if (ownZone.isNullOrBlank() || partnerZone.isNullOrBlank() || ownZone == partnerZone) {
                MingoWidgetPayload.renderCard(
                    context = context,
                    appWidgetManager = appWidgetManager,
                    appWidgetId = appWidgetId,
                    label = context.getString(R.string.mingo_widget_distance_label),
                    title = context.getString(R.string.mingo_widget_distance_missing),
                    subtitle = "",
                    deepLink = "mingo://together?homeWidget=1",
                )
            } else {
                val clocks = context.getString(
                    R.string.mingo_widget_distance_line,
                    payload.ownLocalTime.orEmpty(),
                    MingoWidgetPayload.distanceCity(ownZone),
                    payload.partnerLocalTime.orEmpty(),
                    MingoWidgetPayload.distanceCity(partnerZone),
                )
                val days = payload.reunionDays
                MingoWidgetPayload.renderCard(
                    context = context,
                    appWidgetManager = appWidgetManager,
                    appWidgetId = appWidgetId,
                    label = context.getString(R.string.mingo_widget_distance_label),
                    title = if (days != null) {
                        context.getString(R.string.mingo_widget_distance_days, days)
                    } else {
                        context.getString(R.string.mingo_widget_distance_no_reunion)
                    },
                    subtitle = clocks,
                    deepLink = "mingo://together?homeWidget=1",
                )
            }
        }
    }
}
