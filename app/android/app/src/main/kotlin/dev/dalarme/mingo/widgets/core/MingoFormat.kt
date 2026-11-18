package dev.dalarme.mingo.widgets.core

import android.content.Context
import android.icu.text.MeasureFormat
import android.icu.util.Measure
import android.icu.util.MeasureUnit
import android.text.format.DateUtils
import dev.dalarme.mingo.R
import java.time.Instant
import java.time.LocalDate
import java.time.Period
import java.time.ZoneId
import java.time.ZonedDateTime
import java.time.format.DateTimeFormatter
import java.time.format.FormatStyle
import java.time.format.TextStyle
import java.util.Locale

/** Formats what the widgets show in the system language, with the system formatters. */
class MingoFormat(private val context: Context) {
    private val locale: Locale = context.resources.configuration.locales[0]

    /** "2 hours ago", relative to [now]. */
    fun ago(then: Instant, now: Instant): String =
        DateUtils.getRelativeTimeSpanString(
            minOf(then, now).toEpochMilli(),
            now.toEpochMilli(),
            DateUtils.MINUTE_IN_MILLIS,
        ).toString()

    /** "2 years, 7 months and 25 days", leaving out the units that are zero. */
    fun duration(period: Period): String? {
        val parts = buildList {
            if (period.years > 0) add(Measure(period.years, MeasureUnit.YEAR))
            if (period.months > 0) add(Measure(period.months, MeasureUnit.MONTH))
            if (period.days > 0) add(Measure(period.days, MeasureUnit.DAY))
        }
        if (parts.isEmpty()) return null
        return MeasureFormat.getInstance(locale, MeasureFormat.FormatWidth.WIDE).formatMeasures(*parts.toTypedArray())
    }

    /** The abbreviated weekday, such as "mon" or "seg", without the period some languages add. */
    fun weekdayShort(day: java.time.DayOfWeek): String =
        day.getDisplayName(TextStyle.SHORT, locale).replace(".", "")

    /** The abbreviated month, such as "nov", without the period some languages add. */
    fun monthShort(date: LocalDate): String = date.month.getDisplayName(TextStyle.SHORT, locale).replace(".", "")

    /** The time of day in the system's 12 or 24 hour style. */
    fun clock(time: java.time.temporal.TemporalAccessor): String =
        DateTimeFormatter.ofLocalizedTime(FormatStyle.SHORT).withLocale(locale).format(time)

    fun date(date: LocalDate): String =
        DateTimeFormatter.ofLocalizedDate(FormatStyle.MEDIUM).withLocale(locale).format(date)

    /** "today, 22:00", "tomorrow, 22:00" or "sun, 22:00" for the next time something happens. */
    fun whenText(target: ZonedDateTime, now: ZonedDateTime): String {
        val time = clock(target)
        return when (java.time.temporal.ChronoUnit.DAYS.between(now.toLocalDate(), target.toLocalDate())) {
            0L -> context.getString(R.string.when_today, time)
            1L -> context.getString(R.string.when_tomorrow, time)
            else -> context.getString(R.string.when_weekday, weekdayShort(target.dayOfWeek), time)
        }
    }

    /** The time a note arrived: the clock when it came today, the short date otherwise. */
    fun arrived(at: Instant, now: ZonedDateTime): String {
        val local = at.atZone(now.zone)
        if (local.toLocalDate() == now.toLocalDate()) return clock(local)
        return DateTimeFormatter.ofPattern("d MMM", locale).format(local).replace(".", "")
    }

    /** The city part of an IANA zone: `America/Sao_Paulo` becomes `Sao Paulo`. */
    fun city(zone: ZoneId): String = zone.id.substringAfterLast('/').replace('_', ' ')

    fun days(count: Long, plural: Int): String =
        context.resources.getQuantityString(plural, count.toInt())
}
