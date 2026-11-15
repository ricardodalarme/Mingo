package dev.dalarme.mingo.widgets

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import dev.dalarme.mingo.R

class MingoCouplePhotosWidgetProvider : AppWidgetProvider() {
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
            if (!payload.hasPlus) {
                MingoWidgetPayload.renderCard(
                    context = context,
                    appWidgetManager = appWidgetManager,
                    appWidgetId = appWidgetId,
                    label = context.getString(R.string.mingo_widget_photo_label),
                    title = context.getString(R.string.mingo_widget_photo_plus_only),
                    subtitle = "",
                    deepLink = "mingo://memories?homeWidget=1",
                )
            } else {
                val days = payload.daysTogether()
                val fallbackTitle = if (days != null) {
                    context.getString(R.string.mingo_widget_photo_days_together, days.toInt())
                } else {
                    context.getString(R.string.mingo_widget_photo_fallback_title)
                }
                val hasCachedPhoto = !payload.cachedPhotoPath.isNullOrBlank()
                MingoWidgetPayload.renderCard(
                    context = context,
                    appWidgetManager = appWidgetManager,
                    appWidgetId = appWidgetId,
                    label = context.getString(R.string.mingo_widget_photo_label),
                    title = if (hasCachedPhoto) {
                        context.getString(R.string.mingo_widget_photo_cached_title)
                    } else {
                        fallbackTitle
                    },
                    subtitle = if (hasCachedPhoto) {
                        ""
                    } else {
                        context.getString(R.string.mingo_widget_photo_no_photo)
                    },
                    deepLink = "mingo://memories?homeWidget=1",
                    imagePath = payload.cachedPhotoPath,
                )
            }
        }
    }
}
