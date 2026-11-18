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

/** The Sunday card when small; the card and the next date as a ticket when medium. */
class MingoCardWidget : MingoWidget() {
    @Composable
    override fun Content(scene: MingoScene) {
        val palette = MingoPalette.of(scene.payload.theme)
        if (scene.size == MingoSize.Medium) Ticket(scene, palette) else Small(scene, palette)
    }

    private fun cardLine(scene: MingoScene): String {
        val context = scene.context
        return when (scene.payload.cardState) {
            MingoCardState.Ready -> context.getString(R.string.card_ready)
            MingoCardState.Sent -> context.getString(R.string.card_sent)
            MingoCardState.None -> scene.payload.nextCardSend(scene.now)
                ?.let { context.getString(R.string.card_sends, scene.format.whenText(it, scene.now)) }
                ?: context.getString(R.string.card_title)
        }
    }

    @Composable
    private fun Small(scene: MingoScene, palette: MingoPalette) {
        val count = scene.payload.slipsThisWeek
        MingoShell(MingoLink.Card, MingoFill.Picture(MingoBitmaps.linear(listOf(palette.soft, MingoPalette.Cream), angle = 160f))) {
            Box(GlanceModifier.fillMaxSize()) {
                Box(GlanceModifier.fillMaxSize().padding(top = 14.dp), contentAlignment = Alignment.TopEnd) {
                    Box(GlanceModifier.size(width = 76.dp, height = 92.dp).cornerRadius(12.dp).background(Color.White.copy(alpha = 0.7f))) {}
                }
                Box(GlanceModifier.fillMaxSize().padding(top = 2.dp, end = 14.dp), contentAlignment = Alignment.TopEnd) {
                    Box(GlanceModifier.size(width = 76.dp, height = 92.dp).cornerRadius(12.dp).background(Color.White).padding(8.dp)) {
                        if (count > 0) {
                            MingoText(
                                scene.context.resources.getQuantityString(R.plurals.card_good_things, count, count),
                                16.sp, fixed(palette.label), hand = true, maxLines = 3,
                            )
                        } else {
                            MingoIcon(R.drawable.ic_mingo_heart, palette.highlight, 22.dp)
                        }
                    }
                }
                Column(GlanceModifier.fillMaxSize(), verticalAlignment = Alignment.Bottom) {
                    MingoText(scene.context.getString(R.string.card_title), 15.sp, fixed(palette.ink), weight = FontWeight.Medium)
                    MingoGap(3.dp)
                    MingoText(cardLine(scene), 12.5.sp, fixed(palette.ink.copy(alpha = 0.8f)), maxLines = 1)
                }
            }
        }
    }

    @Composable
    private fun Ticket(scene: MingoScene, palette: MingoPalette) {
        val payload = scene.payload
        val date = payload.nextDateOn?.takeIf { payload.daysUntilNextDate(scene.now.toLocalDate()) != null }
        MingoShell(if (date == null) MingoLink.Card else MingoLink.Dates, MingoFill.Solid(MingoPalette.Surface), padding = 0.dp) {
            Row(GlanceModifier.fillMaxSize()) {
                Box(
                    GlanceModifier.width(92.dp).fillMaxHeight(),
                    contentAlignment = Alignment.Center,
                ) {
                    Image(MingoBitmaps.linear(listOf(palette.highlight, palette.tintEnd), angle = 160f), null, GlanceModifier.fillMaxSize(), contentScale = ContentScale.FillBounds)
                    if (date == null) {
                        MingoIcon(R.drawable.ic_mingo_calendar, Color.White, 34.dp)
                    } else {
                        Column(horizontalAlignment = Alignment.CenterHorizontally) {
                            MingoText(scene.format.weekdayShort(date.dayOfWeek).uppercase(), 12.sp, fixed(Color.White), weight = FontWeight.Medium, maxLines = 1)
                            MingoText(date.dayOfMonth.toString(), 44.sp, fixed(Color.White), weight = FontWeight.Medium, maxLines = 1)
                            MingoText(scene.format.monthShort(date), 12.sp, fixed(Color.White), maxLines = 1)
                        }
                    }
                }
                Image(MingoBitmaps.dottedLine(Color(0xFFE4D6DA)), null, GlanceModifier.width(4.dp).fillMaxHeight().padding(vertical = 10.dp), contentScale = ContentScale.FillBounds)
                Column(GlanceModifier.defaultWeight().fillMaxHeight().padding(16.dp)) {
                    MingoEyebrow(scene.context.getString(R.string.card_encounter), palette.label)
                    MingoGap(6.dp)
                    MingoText(payload.nextDateTitle ?: scene.context.getString(R.string.card_encounter_empty), 19.sp, MingoPalette.TextPrimary, weight = FontWeight.Medium, maxLines = 3)
                    Spacer(GlanceModifier.defaultWeight())
                    Row(GlanceModifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                        MingoText(cardLine(scene), 12.5.sp, MingoPalette.TextSecondary, maxLines = 1, modifier = GlanceModifier.defaultWeight())
                        MingoInitials(payload.ownName, payload.partnerName, palette.label, palette.soft, 24.dp)
                    }
                }
            }
        }
    }
}

class MingoCardWidgetReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = MingoCardWidget()
}
