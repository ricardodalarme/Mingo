package dev.dalarme.mingo.widgets

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import dev.dalarme.mingo.R

class MingoPartnerMoodWidgetProvider : AppWidgetProvider() {
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
            val mood = payload.partnerMood
            if (mood.isNullOrBlank()) {
                MingoWidgetPayload.renderCard(
                    context = context,
                    appWidgetManager = appWidgetManager,
                    appWidgetId = appWidgetId,
                    label = context.getString(R.string.mingo_widget_partner_mood_label),
                    title = context.getString(R.string.mingo_widget_partner_mood_hidden),
                    subtitle = "",
                    deepLink = "mingo://today?homeWidget=1",
                )
            } else {
                val label = if (payload.showNames && !payload.partnerName.isNullOrBlank()) {
                    context.getString(
                        R.string.mingo_widget_partner_mood_now,
                        payload.partnerName,
                    )
                } else {
                    context.getString(R.string.mingo_widget_partner_mood_now_anonymous)
                }
                MingoWidgetPayload.renderCard(
                    context = context,
                    appWidgetManager = appWidgetManager,
                    appWidgetId = appWidgetId,
                    label = label,
                    title = context.getString(moodLabel(context, mood)),
                    subtitle = MingoWidgetPayload.relativeTime(context, payload.partnerMoodAt),
                    deepLink = "mingo://today?homeWidget=1",
                )
            }
        }
    }

    private fun moodLabel(context: Context, mood: String): Int = when (mood) {
        "happy" -> R.string.mingo_widget_mood_happy
        "tired" -> R.string.mingo_widget_mood_tired
        "sad" -> R.string.mingo_widget_mood_sad
        "stressed" -> R.string.mingo_widget_mood_stressed
        "loving" -> R.string.mingo_widget_mood_loving
        "playful" -> R.string.mingo_widget_mood_playful
        else -> R.string.mingo_widget_partner_mood_hidden
    }
}
