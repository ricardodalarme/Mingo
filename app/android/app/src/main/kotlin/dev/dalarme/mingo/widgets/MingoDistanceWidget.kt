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

/** Both clocks of a long-distance couple and the days until they meet. */
class MingoDistanceWidget : MingoWidget(needsPartner = true) {
    @Composable
    override fun Content(scene: MingoScene) {
        val payload = scene.payload
        val own = payload.ownZone
        val partner = payload.partnerZone
        if (own == null || partner == null) {
            MingoShell(MingoLink.Together, MingoFill.Solid(MingoPalette.Surface), padding = 18.dp) {
                Column(GlanceModifier.fillMaxSize(), verticalAlignment = Alignment.Bottom) {
                    MingoText(scene.context.getString(R.string.distance_missing), 15.sp, MingoPalette.TextPrimary, weight = FontWeight.Medium, maxLines = 3)
                }
            }
            return
        }
        MingoShell(MingoLink.Distance, MingoFill.Solid(fixed(Color.Transparent)), padding = 0.dp) {
            Box(GlanceModifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                Row(GlanceModifier.fillMaxSize()) {
                    Half(scene, own, scene.context.getString(R.string.distance_you, scene.format.city(own)), listOf(MingoPalette.DayStart, MingoPalette.DayEnd), Alignment.Start, GlanceModifier.defaultWeight())
                    val partnerLabel = payload.partnerName?.let { scene.context.getString(R.string.distance_partner, scene.format.city(partner), it) }
                        ?: scene.context.getString(R.string.distance_city, scene.format.city(partner))
                    Half(scene, partner, partnerLabel, listOf(MingoPalette.NightStart, MingoPalette.NightHalfEnd), Alignment.End, GlanceModifier.defaultWeight())
                }
                Pill(scene)
            }
        }
    }

    @Composable
    private fun Half(scene: MingoScene, zone: java.time.ZoneId, label: String, colors: List<Color>, side: Alignment.Horizontal, modifier: GlanceModifier) {
        val local = scene.now.inZone(zone)
        val night = local.hour < 6 || local.hour >= 18
        Box(modifier.fillMaxHeight()) {
            Image(MingoBitmaps.linear(colors, angle = 160f), null, GlanceModifier.fillMaxSize(), contentScale = ContentScale.FillBounds)
            Column(GlanceModifier.fillMaxSize().padding(16.dp), horizontalAlignment = side) {
                MingoIcon(if (night) R.drawable.ic_mingo_moon else R.drawable.ic_mingo_sun, Color.White, 22.dp)
                Spacer(GlanceModifier.defaultWeight())
                MingoText(scene.format.clock(local), 24.sp, fixed(Color.White), weight = FontWeight.Medium, maxLines = 1)
                MingoText(label, 12.5.sp, fixed(Color.White.copy(alpha = 0.9f)), maxLines = 1)
            }
        }
    }

    @Composable
    private fun Pill(scene: MingoScene) {
        val days = scene.payload.daysUntilReunion(scene.now.toLocalDate())
        Column(
            GlanceModifier.cornerRadius(22.dp).background(Color.White).padding(horizontal = 16.dp, vertical = 8.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
        ) {
            if (days == null) {
                MingoText(scene.context.getString(R.string.distance_no_reunion), 12.sp, fixed(MingoPalette.Charcoal), align = TextAlign.Center)
            } else {
                MingoText(days.toString(), 26.sp, fixed(MingoPalette.Charcoal), weight = FontWeight.Medium, maxLines = 1)
                MingoText(scene.context.resources.getQuantityString(R.plurals.distance_until, days.toInt()), 11.5.sp, fixed(Color(0xFF736D70)), maxLines = 1)
            }
        }
    }
}

class MingoDistanceWidgetReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = MingoDistanceWidget()
}
