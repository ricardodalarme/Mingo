package dev.dalarme.mingo.widgets

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import dev.dalarme.mingo.R

class MingoPartnerNoteWidgetProvider : AppWidgetProvider() {
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
            val label = if (payload.showNames && !payload.partnerName.isNullOrBlank()) {
                context.getString(R.string.mingo_widget_note_from_named, payload.partnerName.uppercase())
            } else {
                context.getString(R.string.mingo_widget_note_from_default)
            }
            if (payload.allowPartnerNotes && !payload.partnerNote.isNullOrBlank()) {
                MingoWidgetPayload.renderCard(
                    context = context,
                    appWidgetManager = appWidgetManager,
                    appWidgetId = appWidgetId,
                    label = label,
                    title = payload.partnerNote,
                    subtitle = context.getString(R.string.mingo_widget_note_reply_hint),
                    deepLink = "mingo://today?homeWidget=1",
                )
            } else {
                MingoWidgetPayload.renderCard(
                    context = context,
                    appWidgetManager = appWidgetManager,
                    appWidgetId = appWidgetId,
                    label = label,
                    title = context.getString(R.string.mingo_widget_note_empty),
                    subtitle = "",
                    deepLink = "mingo://today?homeWidget=1",
                )
            }
        }
    }
}
