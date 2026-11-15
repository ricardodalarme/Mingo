package dev.dalarme.mingo.widgets

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import dev.dalarme.mingo.R

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
            if (payload.dailyIdeaTitle.isNullOrBlank() && payload.slipsCount > 0) {
                MingoWidgetPayload.renderCard(
                    context = context,
                    appWidgetManager = appWidgetManager,
                    appWidgetId = appWidgetId,
                    label = context.getString(R.string.mingo_widget_jar_label),
                    title = context.getString(R.string.mingo_widget_jar_saved_count, payload.slipsCount),
                    subtitle = context.getString(R.string.mingo_widget_jar_subtitle),
                    deepLink = "mingo://jar?homeWidget=1",
                )
            } else {
                MingoWidgetPayload.renderCard(
                    context = context,
                    appWidgetManager = appWidgetManager,
                    appWidgetId = appWidgetId,
                    label = context.getString(R.string.mingo_widget_idea_label),
                    title = payload.dailyIdeaTitle
                        ?: context.getString(R.string.mingo_widget_idea_default),
                    subtitle = context.getString(R.string.mingo_widget_idea_subtitle),
                    deepLink = "mingo://today?homeWidget=1",
                )
            }
        }
    }
}
