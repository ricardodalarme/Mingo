package dev.dalarme.mingo.widgets

import android.appwidget.AppWidgetManager
import android.content.Context
import android.graphics.BitmapFactory
import android.net.Uri
import android.view.View
import android.widget.RemoteViews
import dev.dalarme.mingo.MainActivity
import dev.dalarme.mingo.R
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import org.json.JSONObject
import java.io.File
import java.time.Duration
import java.time.Instant
import java.time.LocalDate
import java.time.temporal.ChronoUnit

data class MingoWidgetPayload(
    val isSignedIn: Boolean,
    val isPaired: Boolean,
    val hasPlus: Boolean,
    val showNames: Boolean,
    val allowPartnerNotes: Boolean,
    val togetherSince: String?,
    val partnerName: String?,
    val nextDateTitle: String?,
    val nextDateOn: String?,
    val unopenedCards: Int,
    val cardState: String,
    val partnerNote: String?,
    val partnerNoteAt: String?,
    val partnerMood: String?,
    val partnerMoodAt: String?,
    val partnerMissedAt: String?,
    val myMood: String?,
    val dailyIdeaTitle: String?,
    val ritualTitle: String?,
    val ritualSchedule: String?,
    val slipsCount: Int,
    val slipsThisWeek: Int,
    val slipDays: List<String>,
    val ownName: String?,
    val cardSendDay: Int?,
    val cardSendHour: Int?,
    val ownZone: String?,
    val partnerZone: String?,
    val ownLocalTime: String?,
    val partnerLocalTime: String?,
    val reunionTitle: String?,
    val reunionOn: String?,
    val reunionDays: Int?,
    val cachedPhotoPath: String?,
) {
    fun daysTogether(today: LocalDate = LocalDate.now()): Long? {
        if (!isSignedIn || togetherSince.isNullOrBlank()) return null
        return try {
            val start = LocalDate.parse(togetherSince.take(10))
            val days = ChronoUnit.DAYS.between(start, today)
            if (days < 0L) 0L else days
        } catch (_: Exception) {
            null
        }
    }

    fun daysUntilNextDate(today: LocalDate = LocalDate.now()): Long? {
        if (!isSignedIn || nextDateOn.isNullOrBlank()) return null
        return try {
            val target = LocalDate.parse(nextDateOn.take(10))
            val days = ChronoUnit.DAYS.between(today, target)
            if (days >= 0L) days else null
        } catch (_: Exception) {
            null
        }
    }

    fun renderGuardState(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
        requirePaired: Boolean,
    ): Boolean {
        if (!isSignedIn) {
            renderCard(
                context = context,
                appWidgetManager = appWidgetManager,
                appWidgetId = appWidgetId,
                label = context.getString(R.string.mingo_widget_signed_out_label),
                title = context.getString(R.string.mingo_widget_signed_out_title),
                subtitle = "",
                deepLink = "mingo://sign-in?homeWidget=1",
            )
            return true
        }
        if (requirePaired && !isPaired) {
            renderCard(
                context = context,
                appWidgetManager = appWidgetManager,
                appWidgetId = appWidgetId,
                label = context.getString(R.string.mingo_widget_unpaired_label),
                title = context.getString(R.string.mingo_widget_unpaired_title),
                subtitle = context.getString(R.string.mingo_widget_unpaired_action),
                deepLink = "mingo://invite?homeWidget=1",
            )
            return true
        }
        return false
    }

    companion object {
        private const val PREFS_NAME = "HomeWidgetPreferences"
        private const val PAYLOAD_KEY = "mingo_widget_payload"
        private const val CACHED_PHOTO_KEY = "mingo_widget_photo_path"

        fun load(context: Context): MingoWidgetPayload {
            val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
            val raw = prefs.getString(PAYLOAD_KEY, null) ?: return signedOut()
            return try {
                val json = JSONObject(raw)
                val isSignedIn = json.optBoolean("isSignedIn", false)
                val isPaired = json.optBoolean("isPaired", false)
                val hasPlus = json.optBoolean("hasPlus", false)
                val directPhotoPath = prefs.getString(CACHED_PHOTO_KEY, null)?.trim()?.ifEmpty { null }
                val resolvedPhotoPath = if (isSignedIn && isPaired && hasPlus) {
                    json.optNullableString("cachedPhotoPath") ?: directPhotoPath
                } else {
                    null
                }
                MingoWidgetPayload(
                    isSignedIn = isSignedIn,
                    isPaired = isPaired,
                    hasPlus = hasPlus,
                    showNames = json.optBoolean("showNames", false),
                    allowPartnerNotes = json.optBoolean("allowPartnerNotes", false),
                    togetherSince = json.optNullableString("togetherSince"),
                    partnerName = json.optNullableString("partnerName"),
                    nextDateTitle = json.optNullableString("nextDateTitle"),
                    nextDateOn = json.optNullableString("nextDateOn"),
                    unopenedCards = json.optInt("unopenedCards", 0),
                    cardState = json.optString("cardState", "none"),
                    partnerNote = json.optNullableString("partnerNote"),
                    partnerNoteAt = json.optNullableString("partnerNoteAt"),
                    partnerMood = json.optNullableString("partnerMood"),
                    partnerMoodAt = json.optNullableString("partnerMoodAt"),
                    partnerMissedAt = json.optNullableString("partnerMissedAt"),
                    myMood = json.optNullableString("myMood"),
                    dailyIdeaTitle = json.optNullableString("dailyIdeaTitle"),
                    ritualTitle = json.optNullableString("ritualTitle"),
                    ritualSchedule = json.optNullableString("ritualSchedule"),
                    slipsCount = json.optInt("slipsCount", 0),
                    slipsThisWeek = json.optInt("slipsThisWeek", 0),
                    slipDays = json.optStringList("slipDays"),
                    ownName = json.optNullableString("ownName"),
                    cardSendDay = json.optNullableInt("cardSendDay"),
                    cardSendHour = json.optNullableInt("cardSendHour"),
                    ownZone = json.optNullableString("ownZone"),
                    partnerZone = json.optNullableString("partnerZone"),
                    ownLocalTime = json.optNullableString("ownLocalTime"),
                    partnerLocalTime = json.optNullableString("partnerLocalTime"),
                    reunionTitle = json.optNullableString("reunionTitle"),
                    reunionOn = json.optNullableString("reunionOn"),
                    reunionDays = json.optNullableInt("reunionDays"),
                    cachedPhotoPath = resolvedPhotoPath,
                )
            } catch (_: Exception) {
                signedOut()
            }
        }

        fun signedOut() = MingoWidgetPayload(
            isSignedIn = false,
            isPaired = false,
            hasPlus = false,
            showNames = false,
            allowPartnerNotes = false,
            togetherSince = null,
            partnerName = null,
            nextDateTitle = null,
            nextDateOn = null,
            unopenedCards = 0,
            cardState = "none",
            partnerNote = null,
            partnerNoteAt = null,
            partnerMood = null,
            partnerMoodAt = null,
            partnerMissedAt = null,
            myMood = null,
            dailyIdeaTitle = null,
            ritualTitle = null,
            ritualSchedule = null,
            slipsCount = 0,
            slipsThisWeek = 0,
            slipDays = emptyList(),
            ownName = null,
            cardSendDay = null,
            cardSendHour = null,
            ownZone = null,
            partnerZone = null,
            ownLocalTime = null,
            partnerLocalTime = null,
            reunionTitle = null,
            reunionOn = null,
            reunionDays = null,
            cachedPhotoPath = null,
        )

        fun renderCard(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int,
            label: String,
            title: String,
            subtitle: String,
            deepLink: String,
            imagePath: String? = null,
        ) {
            val views = RemoteViews(context.packageName, R.layout.mingo_widget_card)
            views.setTextViewText(R.id.mingo_widget_label, label)
            views.setTextViewText(R.id.mingo_widget_title, title)
            views.setTextViewText(R.id.mingo_widget_subtitle, subtitle)
            views.setViewVisibility(
                R.id.mingo_widget_subtitle,
                if (subtitle.isBlank()) View.GONE else View.VISIBLE,
            )

            val bitmap = try {
                if (!imagePath.isNullOrBlank() && File(imagePath).exists()) {
                    BitmapFactory.decodeFile(imagePath)
                } else {
                    null
                }
            } catch (_: Exception) {
                null
            }
            if (bitmap != null) {
                views.setImageViewBitmap(R.id.mingo_widget_image, bitmap)
                views.setViewVisibility(R.id.mingo_widget_image, View.VISIBLE)
            } else {
                views.setViewVisibility(R.id.mingo_widget_image, View.GONE)
            }

            val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                context,
                MainActivity::class.java,
                Uri.parse(deepLink),
            )
            views.setOnClickPendingIntent(R.id.mingo_widget_root, pendingIntent)
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }

        private fun JSONObject.optNullableString(key: String): String? {
            if (isNull(key)) return null
            val v = optString(key, "").trim()
            return v.ifEmpty { null }
        }

        private fun JSONObject.optNullableInt(key: String): Int? {
            if (!has(key) || isNull(key)) return null
            return optInt(key)
        }

        private fun JSONObject.optStringList(key: String): List<String> {
            if (!has(key) || isNull(key)) return emptyList()
            val array = optJSONArray(key) ?: return emptyList()
            return buildList {
                for (index in 0 until array.length()) {
                    val value = array.optString(index, "").trim()
                    if (value.isNotEmpty()) add(value)
                }
            }
        }

        fun relativeTime(context: Context, iso: String?): String {
            if (iso.isNullOrBlank()) return ""
            val moment = try {
                Instant.parse(iso)
            } catch (_: Exception) {
                return ""
            }
            val minutes = Duration.between(moment, Instant.now()).toMinutes().coerceAtLeast(0)
            return when {
                minutes < 1 -> context.getString(R.string.mingo_widget_time_now)
                minutes < 60 -> context.getString(R.string.mingo_widget_time_minutes, minutes)
                minutes < 60 * 24 -> context.getString(R.string.mingo_widget_time_hours, minutes / 60)
                else -> context.getString(R.string.mingo_widget_time_days, minutes / (60 * 24))
            }
        }

        fun distanceCity(zone: String?): String {
            if (zone.isNullOrBlank()) return ""
            return zone.substringAfterLast('/').replace('_', ' ')
        }
    }
}
