package dev.dalarme.mingo.widgets

import android.content.Context
import androidx.glance.appwidget.GlanceAppWidgetManager
import androidx.glance.appwidget.GlanceAppWidgetReceiver
import kotlin.reflect.KClass

/**
 * Publishes generated previews so the system widget picker shows each widget with sample content.
 *
 * The system rate-limits this call, so each widget is published once per installed build and the ones
 * that were refused are retried on the next launch.
 */
object MingoWidgetPreviews {
    private const val PREFERENCES = "mingo_widget_previews"

    private val receivers: List<KClass<out GlanceAppWidgetReceiver>> = listOf(
        MingoCounterWidgetReceiver::class,
        MingoPartnerMoodWidgetReceiver::class,
        MingoLongingWidgetReceiver::class,
        MingoRitualWidgetReceiver::class,
        MingoPartnerNoteWidgetReceiver::class,
        MingoSlipWidgetReceiver::class,
        MingoNextDateWidgetReceiver::class,
        MingoCardWidgetReceiver::class,
        MingoWeekWidgetReceiver::class,
        MingoIdeaWidgetReceiver::class,
        MingoDistanceWidgetReceiver::class,
    )

    suspend fun publish(context: Context) {
        val build = context.packageManager.getPackageInfo(context.packageName, 0).lastUpdateTime
        val published = context.getSharedPreferences(PREFERENCES, Context.MODE_PRIVATE)
        val manager = GlanceAppWidgetManager(context)
        for (receiver in receivers) {
            val key = "${receiver.qualifiedName}:$build"
            if (published.getBoolean(key, false)) continue
            if (manager.setWidgetPreviews(receiver) > 0) published.edit().putBoolean(key, true).apply()
        }
    }
}
