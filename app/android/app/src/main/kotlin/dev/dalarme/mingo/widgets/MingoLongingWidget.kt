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


/** The one-tap "missing you" widget, or the missing the partner just sent. */
class MingoLongingWidget : MingoWidget(needsPartner = true) {
    @Composable
    override fun Content(scene: MingoScene) {
        val payload = scene.payload
        val palette = MingoPalette.of(payload.theme)
        val fill = MingoBitmaps.radial(listOf(palette.mist, palette.soft.copy(alpha = 0.7f), Color.White), stops = floatArrayOf(0f, 0.6f, 1f))
        MingoShell(MingoLink.Today, MingoFill.Picture(fill)) {
            Column(GlanceModifier.fillMaxSize(), horizontalAlignment = Alignment.CenterHorizontally, verticalAlignment = Alignment.CenterVertically) {
                Box(GlanceModifier.size(84.dp), contentAlignment = Alignment.Center) {
                    Image(MingoBitmaps.ring(palette.highlight.copy(alpha = 0.25f), 0.03f), null, GlanceModifier.fillMaxSize())
                    Image(MingoBitmaps.ring(palette.highlight.copy(alpha = 0.4f), 0.03f), null, GlanceModifier.size(58.dp))
                    MingoDisc(palette.highlight, 50.dp) { MingoIcon(R.drawable.ic_mingo_heart, Color.White, 26.dp) }
                }
                MingoGap(8.dp)
                val missed = payload.partnerMissedAt
                MingoText(
                    scene.context.getString(if (missed == null) R.string.longing_action else R.string.longing_received),
                    14.5.sp, fixed(palette.ink), weight = FontWeight.Medium, align = TextAlign.Center,
                )
                missed?.let { MingoText(scene.format.ago(it, scene.now.toInstant()), 12.sp, fixed(palette.ink.copy(alpha = 0.75f)), maxLines = 1) }
            }
        }
    }
}

class MingoLongingWidgetReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = MingoLongingWidget()
}
