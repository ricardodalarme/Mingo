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

/** Days until the next important date, as a ring when small and a headline when medium. */
class MingoNextDateWidget : MingoWidget() {
    @Composable
    override fun Content(scene: MingoScene) {
        val payload = scene.payload
        val palette = MingoPalette.of(payload.theme)
        val days = payload.daysUntilNextDate(scene.now.toLocalDate())
        val unit = days?.let { scene.context.resources.getQuantityString(R.plurals.counter_unit, it.toInt()) }
        when {
            days == null -> MingoShell(MingoLink.Dates, MingoFill.Solid(MingoPalette.Surface)) {
                Column(GlanceModifier.fillMaxSize()) {
                    MingoEyebrow(scene.context.getString(R.string.next_date_eyebrow), palette.label)
                    Spacer(GlanceModifier.defaultWeight())
                    MingoText(scene.context.getString(R.string.next_date_empty), 17.sp, MingoPalette.TextPrimary, weight = FontWeight.Medium)
                }
            }
            scene.size == MingoSize.Medium -> MingoShell(
                MingoLink.Dates,
                MingoFill.Picture(MingoBitmaps.linear(listOf(MingoPalette.Sky, palette.soft), angle = 90f)),
                padding = 16.dp,
            ) {
                Row(GlanceModifier.fillMaxSize(), verticalAlignment = Alignment.CenterVertically) {
                    Column(GlanceModifier.defaultWeight()) {
                        MingoEyebrow(scene.context.getString(R.string.next_date_eyebrow), MingoPalette.SkyInk)
                        Row(verticalAlignment = Alignment.Bottom) {
                            MingoText(days.toString(), 48.sp, fixed(MingoPalette.SkyInk), weight = FontWeight.Medium, maxLines = 1)
                            Spacer(GlanceModifier.width(6.dp))
                            MingoText(unit.orEmpty(), 20.sp, fixed(MingoPalette.SkyInk), maxLines = 1)
                        }
                        payload.nextDateTitle?.let { MingoText(it, 13.sp, fixed(MingoPalette.SkyInk.copy(alpha = 0.8f)), maxLines = 1) }
                    }
                    MingoIcon(R.drawable.ic_mingo_calendar, palette.highlight, 52.dp)
                }
            }
            else -> MingoShell(MingoLink.Dates, MingoFill.Solid(MingoPalette.Surface), padding = 12.dp) {
                Column(GlanceModifier.fillMaxSize(), horizontalAlignment = Alignment.CenterHorizontally, verticalAlignment = Alignment.CenterVertically) {
                    Box(GlanceModifier.size(92.dp), contentAlignment = Alignment.Center) {
                        Image(
                            MingoBitmaps.progressRing(palette.soft, palette.highlight, (1f - days / 30f).coerceIn(0.06f, 1f), 0.09f),
                            null, GlanceModifier.fillMaxSize(),
                        )
                        Column(horizontalAlignment = Alignment.CenterHorizontally) {
                            MingoText(days.toString(), 32.sp, MingoPalette.TextPrimary, weight = FontWeight.Medium, maxLines = 1)
                            MingoText(unit.orEmpty(), 12.sp, MingoPalette.TextSecondary, maxLines = 1)
                        }
                    }
                    payload.nextDateTitle?.let {
                        MingoGap(4.dp)
                        MingoText(it, 12.5.sp, MingoPalette.TextPrimary, weight = FontWeight.Medium, maxLines = 1)
                    }
                }
            }
        }
    }
}

class MingoNextDateWidgetReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = MingoNextDateWidget()
}
