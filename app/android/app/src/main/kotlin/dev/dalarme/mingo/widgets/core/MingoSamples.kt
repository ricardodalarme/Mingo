package dev.dalarme.mingo.widgets.core

import android.content.Context
import dev.dalarme.mingo.R
import java.time.Instant
import java.time.LocalDate
import java.time.LocalTime
import java.time.ZoneId

/** Sample content for the widget picker preview, never shown on a person's home screen. */
object MingoSamples {
    fun payload(context: Context): MingoPayload {
        val today = LocalDate.now()
        val now = Instant.now()
        return MingoPayload(
            isSignedIn = true,
            isPaired = true,
            ownName = "Alex",
            partnerName = "Sam",
            togetherSince = today.minusDays(969),
            milestones = listOf(
                MingoMilestone(context.getString(R.string.sample_milestone_first), today.minusDays(700)),
                MingoMilestone(context.getString(R.string.sample_milestone_second), today.minusDays(300)),
            ),
            nextDateTitle = context.getString(R.string.sample_date),
            nextDateOn = today.plusDays(12),
            cardState = MingoCardState.Ready,
            cardSendDay = 0,
            cardSendHour = 18,
            partnerNote = context.getString(R.string.sample_note),
            partnerNoteAt = now.minusSeconds(3_600),
            partnerMood = MingoMood.Loving,
            partnerMoodAt = now.minusSeconds(7_200),
            ritualTitle = context.getString(R.string.sample_ritual),
            ritualWeekday = 7,
            ritualTime = LocalTime.of(22, 0),
            dailyIdeaTitle = context.getString(R.string.sample_idea),
            slipsThisWeek = 3,
            slipDays = listOf(today, today.minusDays(2), today.minusDays(3)),
            ownZone = ZoneId.of("America/Sao_Paulo"),
            partnerZone = ZoneId.of("Europe/Lisbon"),
            reunionOn = today.plusDays(42),
        )
    }
}
