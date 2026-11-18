package dev.dalarme.mingo.widgets.core

import android.content.Context

/** Reads the payload the app last wrote into the shared preferences the widgets use. */
object MingoPayloadStore {
    private const val PREFERENCES = "HomeWidgetPreferences"
    private const val KEY = "mingo_widget_payload"

    fun load(context: Context): MingoPayload {
        val raw = context.getSharedPreferences(PREFERENCES, Context.MODE_PRIVATE).getString(KEY, null)
            ?: return MingoPayload()
        return runCatching { MingoPayload.fromJson(raw) }.getOrDefault(MingoPayload())
    }
}
