package dev.dalarme.mingo.widgets.core

import org.json.JSONObject
import java.time.DayOfWeek
import java.time.Instant
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.LocalTime
import java.time.Period
import java.time.ZoneId
import java.time.ZonedDateTime
import java.time.temporal.ChronoUnit
import java.time.temporal.TemporalAdjusters

enum class MingoTheme { Rose, Blue, Neutral }

enum class MingoCardState { None, Ready, Sent }

enum class MingoMood { Happy, Tired, Sad, Stressed, Loving, Playful }

data class MingoMilestone(val title: String, val on: LocalDate?)

/**
 * The facts the app writes for the widgets: dates, zones and enum names, never display text.
 *
 * Unknown keys and values fall back to safe defaults so an older widget keeps working against a
 * newer app.
 */
data class MingoPayload(
    val isSignedIn: Boolean = false,
    val isPaired: Boolean = false,
    val theme: MingoTheme = MingoTheme.Rose,
    val ownName: String? = null,
    val partnerName: String? = null,
    val togetherSince: LocalDate? = null,
    val milestones: List<MingoMilestone> = emptyList(),
    val nextDateTitle: String? = null,
    val nextDateOn: LocalDate? = null,
    val cardState: MingoCardState = MingoCardState.None,
    val cardSendDay: Int? = null,
    val cardSendHour: Int? = null,
    val partnerNote: String? = null,
    val partnerNoteAt: Instant? = null,
    val partnerMood: MingoMood? = null,
    val partnerMoodAt: Instant? = null,
    val partnerMissedAt: Instant? = null,
    val ritualTitle: String? = null,
    val ritualWeekday: Int? = null,
    val ritualTime: LocalTime? = null,
    val dailyIdeaTitle: String? = null,
    val slipsThisWeek: Int = 0,
    val slipDays: List<LocalDate> = emptyList(),
    val ownZone: ZoneId? = null,
    val partnerZone: ZoneId? = null,
    val reunionOn: LocalDate? = null,
) {
    /** Whole days together at local midnight of [today], or null when no date is set. */
    fun daysTogether(today: LocalDate): Long? =
        togetherSince?.let { maxOf(0L, ChronoUnit.DAYS.between(it, today)) }

    /** Years, months and days together, or null when no date is set. */
    fun durationTogether(today: LocalDate): Period? =
        togetherSince?.takeIf { !it.isAfter(today) }?.let { Period.between(it, today) }

    fun daysUntilNextDate(today: LocalDate): Long? = daysUntil(nextDateOn, today)

    fun daysUntilReunion(today: LocalDate): Long? = daysUntil(reunionOn, today)

    /** The next time the weekly ritual happens, from [now]. */
    fun nextRitual(now: ZonedDateTime): ZonedDateTime? {
        val weekday = ritualWeekday ?: return null
        val time = ritualTime ?: return null
        return nextWeekly(DayOfWeek.of(weekday), time, now)
    }

    /** The next time the Sunday card goes out, from [now]; day 0 is Sunday. */
    fun nextCardSend(now: ZonedDateTime): ZonedDateTime? {
        val day = cardSendDay ?: return null
        val hour = cardSendHour ?: return null
        return nextWeekly(DayOfWeek.of(if (day == 0) 7 else day), LocalTime.of(hour, 0), now)
    }

    private fun nextWeekly(day: DayOfWeek, time: LocalTime, now: ZonedDateTime): ZonedDateTime {
        val sameDay = now.with(TemporalAdjusters.nextOrSame(day)).with(time)
        return if (sameDay.isBefore(now.minusMinutes(1))) sameDay.plusWeeks(1) else sameDay
    }

    private fun daysUntil(target: LocalDate?, today: LocalDate): Long? =
        target?.let { ChronoUnit.DAYS.between(today, it) }?.takeIf { it >= 0 }

    companion object {
        fun fromJson(raw: String): MingoPayload {
            val json = JSONObject(raw)
            return MingoPayload(
                isSignedIn = json.optBoolean("isSignedIn"),
                isPaired = json.optBoolean("isPaired"),
                theme = enumOf<MingoTheme>(json.text("theme")) ?: MingoTheme.Rose,
                ownName = json.text("ownName"),
                partnerName = json.text("partnerName"),
                togetherSince = json.date("togetherSince"),
                milestones = json.optJSONArray("milestones")?.let { array ->
                    (0 until array.length()).mapNotNull { index ->
                        val item = array.optJSONObject(index) ?: return@mapNotNull null
                        item.text("title")?.let { MingoMilestone(it, item.date("on")) }
                    }
                }.orEmpty(),
                nextDateTitle = json.text("nextDateTitle"),
                nextDateOn = json.date("nextDateOn"),
                cardState = enumOf<MingoCardState>(json.text("cardState")) ?: MingoCardState.None,
                cardSendDay = json.int("cardSendDay"),
                cardSendHour = json.int("cardSendHour"),
                partnerNote = json.text("partnerNote"),
                partnerNoteAt = json.instant("partnerNoteAt"),
                partnerMood = enumOf<MingoMood>(json.text("partnerMood")),
                partnerMoodAt = json.instant("partnerMoodAt"),
                partnerMissedAt = json.instant("partnerMissedAt"),
                ritualTitle = json.text("ritualTitle"),
                ritualWeekday = json.int("ritualWeekday"),
                ritualTime = json.text("ritualTime")?.let { runCatching { LocalTime.parse(it) }.getOrNull() },
                dailyIdeaTitle = json.text("dailyIdeaTitle"),
                slipsThisWeek = json.optInt("slipsThisWeek"),
                slipDays = json.optJSONArray("slipDays")?.let { array ->
                    (0 until array.length()).mapNotNull { index -> array.optString(index).toDate() }
                }.orEmpty(),
                ownZone = json.text("ownZone")?.let { runCatching { ZoneId.of(it) }.getOrNull() },
                partnerZone = json.text("partnerZone")?.let { runCatching { ZoneId.of(it) }.getOrNull() },
                reunionOn = json.date("reunionOn"),
            )
        }

        private inline fun <reified T : Enum<T>> enumOf(raw: String?): T? =
            raw?.let { name -> enumValues<T>().firstOrNull { it.name.equals(name, ignoreCase = true) } }

        private fun JSONObject.text(key: String): String? =
            if (isNull(key)) null else optString(key).trim().ifEmpty { null }

        private fun JSONObject.int(key: String): Int? = if (has(key) && !isNull(key)) optInt(key) else null

        private fun JSONObject.date(key: String): LocalDate? = text(key)?.toDate()

        private fun JSONObject.instant(key: String): Instant? =
            text(key)?.let { runCatching { Instant.parse(it) }.getOrNull() }

        private fun String.toDate(): LocalDate? = runCatching { LocalDate.parse(take(10)) }.getOrNull()
    }
}

/** The ISO weekday (1 = Monday ... 7 = Sunday) of each of this week's slips. */
val MingoPayload.slipWeekdays: List<Int> get() = slipDays.map { it.dayOfWeek.value }

/** Local time of [now] in [zone], without dropping the date. */
fun ZonedDateTime.inZone(zone: ZoneId): LocalDateTime = withZoneSameInstant(zone).toLocalDateTime()
