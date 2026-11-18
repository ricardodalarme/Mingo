package dev.dalarme.mingo.widgets

import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.GlanceModifier
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.appwidget.GlanceAppWidgetReceiver
import androidx.glance.appwidget.cornerRadius
import androidx.glance.background
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.Column
import androidx.glance.layout.ContentScale
import androidx.glance.layout.Row
import androidx.glance.layout.Spacer
import androidx.glance.layout.fillMaxHeight
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.height
import androidx.glance.layout.padding
import androidx.glance.layout.size
import androidx.glance.layout.width
import androidx.glance.text.FontWeight
import androidx.glance.text.TextAlign
import dev.dalarme.mingo.R
import dev.dalarme.mingo.widgets.core.*

/** The person's own week: a bar for each weekday that holds slips. */
class MingoWeekWidget : MingoWidget() {
    @Composable
    override fun Content(scene: MingoScene) {
        val payload = scene.payload
        val palette = MingoPalette.of(payload.theme)
        val perDay = payload.slipWeekdays.groupingBy { it }.eachCount()
        MingoShell(MingoLink.Slips, MingoFill.Solid(MingoPalette.Surface), padding = 16.dp) {
            Column(GlanceModifier.fillMaxSize()) {
                Row(GlanceModifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                    MingoEyebrow(scene.context.getString(R.string.week_eyebrow), palette.label)
                    Spacer(GlanceModifier.defaultWeight())
                    MingoText(scene.context.resources.getQuantityString(R.plurals.week_count, payload.slipsThisWeek, payload.slipsThisWeek), 13.sp, MingoPalette.TextSecondary, maxLines = 1)
                }
                Spacer(GlanceModifier.defaultWeight())
                Row(GlanceModifier.fillMaxWidth(), verticalAlignment = Alignment.Bottom) {
                    for (day in java.time.DayOfWeek.values()) {
                        val count = perDay[day.value] ?: 0
                        Column(GlanceModifier.defaultWeight().padding(horizontal = 3.dp), horizontalAlignment = Alignment.CenterHorizontally) {
                            val bar = if (count > 0) MingoBitmaps.linear(listOf(palette.tintEnd, palette.highlight), angle = 180f) else MingoBitmaps.linear(listOf(palette.soft, palette.soft))
                            Image(bar, null, GlanceModifier.fillMaxWidth().height(if (count > 0) (16 + 10 * minOf(count, 3)).dp else 12.dp).cornerRadius(8.dp), contentScale = ContentScale.FillBounds)
                            MingoGap(5.dp)
                            MingoText(
                                scene.format.weekdayShort(day), 11.5.sp,
                                if (count > 0) fixed(palette.label) else MingoPalette.TextSecondary,
                                weight = if (count > 0) FontWeight.Medium else FontWeight.Normal, maxLines = 1, align = TextAlign.Center,
                            )
                        }
                    }
                }
            }
        }
    }
}

class MingoWeekWidgetReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = MingoWeekWidget()
}
