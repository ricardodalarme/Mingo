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


/** The mood the partner chose to share, or the honest note that none is shared. */
class MingoPartnerMoodWidget : MingoWidget(needsPartner = true) {
    @Composable
    override fun Content(scene: MingoScene) {
        val payload = scene.payload
        val palette = MingoPalette.of(payload.theme)
        val mood = payload.partnerMood
        val fill = MingoBitmaps.radial(listOf(palette.mist, palette.soft, Color.White), cx = 0.8f, cy = 0.2f, stops = floatArrayOf(0f, 0.55f, 1f))
        MingoShell(MingoLink.Today, MingoFill.Picture(fill), padding = 14.dp) {
            Column(GlanceModifier.fillMaxSize()) {
                val name = payload.partnerName
                MingoEyebrow(
                    if (mood != null && name != null) scene.context.getString(R.string.mood_now, name) else scene.context.getString(R.string.mood_now_anonymous),
                    palette.ink,
                )
                Spacer(GlanceModifier.defaultWeight())
                if (mood == null) {
                    MingoText(scene.context.getString(R.string.mood_hidden), 13.sp, fixed(palette.ink.copy(alpha = 0.85f)), maxLines = 4)
                } else {
                    MingoDisc(Color.White, 60.dp) { MingoIcon(mood.face, palette.highlight, 42.dp) }
                    Spacer(GlanceModifier.defaultWeight())
                    MingoText(scene.context.getString(mood.nameRes), 17.sp, fixed(palette.ink), weight = FontWeight.Medium, maxLines = 1)
                    payload.partnerMoodAt?.let {
                        MingoText(scene.format.ago(it, scene.now.toInstant()), 12.5.sp, fixed(palette.ink.copy(alpha = 0.75f)), maxLines = 1)
                    }
                }
            }
        }
    }
}

class MingoPartnerMoodWidgetReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = MingoPartnerMoodWidget()
}
