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


/** The ritual the couple keeps, on a night sky, with when it comes next. */
class MingoRitualWidget : MingoWidget() {
    @Composable
    override fun Content(scene: MingoScene) {
        val payload = scene.payload
        val fill = MingoBitmaps.linear(
            listOf(MingoPalette.NightStart, MingoPalette.NightMiddle, MingoPalette.NightEnd),
            angle = 170f, stops = floatArrayOf(0f, 0.7f, 1f),
        )
        MingoShell(MingoLink.Rituals, MingoFill.Picture(fill)) {
            Box(GlanceModifier.fillMaxSize()) {
                Box(GlanceModifier.fillMaxSize(), contentAlignment = Alignment.TopEnd) {
                    MingoIcon(R.drawable.ic_mingo_moon, Color.White.copy(alpha = 0.9f), 44.dp)
                }
                Column(GlanceModifier.fillMaxSize()) {
                    MingoEyebrow(scene.context.getString(R.string.ritual_eyebrow), Color.White)
                    Spacer(GlanceModifier.defaultWeight())
                    val title = payload.ritualTitle
                    MingoText(title ?: scene.context.getString(R.string.ritual_empty_title), 21.sp, fixed(Color.White), weight = FontWeight.Medium, maxLines = 3)
                    val next = payload.nextRitual(scene.now)
                    MingoGap(6.dp)
                    MingoText(
                        if (title != null && next != null) scene.format.whenText(next, scene.now) else scene.context.getString(R.string.ritual_empty_hint),
                        12.5.sp, fixed(Color.White.copy(alpha = 0.8f)), maxLines = 1,
                    )
                }
            }
        }
    }
}

class MingoRitualWidgetReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = MingoRitualWidget()
}
