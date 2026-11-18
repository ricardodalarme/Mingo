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


/** Days together, with the two initials and, when medium, the story timeline. */
class MingoCounterWidget : MingoWidget() {
    @Composable
    override fun Content(scene: MingoScene) {
        val payload = scene.payload
        val palette = MingoPalette.of(payload.theme)
        val medium = scene.size == MingoSize.Medium
        val fill = if (medium) {
            MingoBitmaps.linear(listOf(palette.tintStart, palette.tintMiddle, MingoPalette.Peach), angle = 90f)
        } else {
            MingoBitmaps.linear(listOf(palette.tintStart, palette.tintEnd), angle = 135f)
        }
        MingoShell(
            MingoLink.Together,
            MingoFill.Picture(fill),
            backdrop = {
                if (!medium) {
                    Image(
                        provider = MingoBitmaps.heartWatermark(Color.White.copy(alpha = 0.28f)),
                        contentDescription = null,
                        contentScale = ContentScale.FillBounds,
                        modifier = GlanceModifier.fillMaxSize(),
                    )
                }
            },
        ) {
            val days = payload.daysTogether(scene.now.toLocalDate())
            if (days == null) {
                Column(GlanceModifier.fillMaxSize()) {
                    MingoEyebrow(scene.context.getString(R.string.counter_eyebrow), palette.ink)
                    Spacer(GlanceModifier.defaultWeight())
                    MingoText(scene.context.getString(R.string.counter_need_date), 17.sp, fixed(palette.ink), weight = FontWeight.Medium)
                }
            } else {
                Row(GlanceModifier.fillMaxSize()) {
                    Column(GlanceModifier.defaultWeight().fillMaxHeight()) {
                        MingoEyebrow(scene.context.getString(R.string.counter_eyebrow), palette.ink)
                        Spacer(GlanceModifier.defaultWeight())
                        MingoText(days.toString(), if (medium) 54.sp else 48.sp, fixed(palette.ink), weight = FontWeight.Medium, maxLines = 1)
                        val duration = if (medium) payload.durationTogether(scene.now.toLocalDate())?.let(scene.format::duration) else null
                        MingoText(
                            duration ?: scene.context.resources.getQuantityString(R.plurals.counter_unit, days.toInt()),
                            14.sp, fixed(palette.ink), maxLines = 1,
                        )
                        Spacer(GlanceModifier.defaultWeight())
                        MingoInitials(payload.ownName, payload.partnerName, palette.label, Color.White)
                    }
                    if (medium) Timeline(scene, palette)
                }
            }
        }
    }

    @Composable
    private fun Timeline(scene: MingoScene, palette: MingoPalette) {
        val items = buildList {
            val recent = scene.payload.milestones.takeLast(2).map { it.title }
            if (recent.isEmpty()) scene.payload.togetherSince?.let { add(scene.format.date(it)) } else addAll(recent)
        }
        Row(GlanceModifier.width(130.dp).fillMaxHeight()) {
            Image(
                provider = MingoBitmaps.dottedLine(palette.ink.copy(alpha = 0.4f)),
                contentDescription = null,
                contentScale = ContentScale.FillBounds,
                modifier = GlanceModifier.width(4.dp).fillMaxHeight().padding(vertical = 8.dp),
            )
            Spacer(GlanceModifier.width(10.dp))
            Column(GlanceModifier.fillMaxHeight()) {
                items.forEach {
                    MingoText(it, 12.5.sp, fixed(palette.ink), maxLines = 1)
                    Spacer(GlanceModifier.defaultWeight())
                }
                MingoText(scene.context.getString(R.string.counter_today), 12.5.sp, fixed(palette.ink), weight = FontWeight.Medium, maxLines = 1)
            }
        }
    }
}

class MingoCounterWidgetReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = MingoCounterWidget()
}
