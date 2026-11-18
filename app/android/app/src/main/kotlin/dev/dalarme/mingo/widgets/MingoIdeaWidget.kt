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

/** The idea of the day. */
class MingoIdeaWidget : MingoWidget() {
    @Composable
    override fun Content(scene: MingoScene) {
        val palette = MingoPalette.of(scene.payload.theme)
        MingoShell(MingoLink.Today, MingoFill.Picture(MingoBitmaps.linear(listOf(MingoPalette.Cream, palette.soft), angle = 90f)), padding = 16.dp) {
            Row(GlanceModifier.fillMaxSize(), verticalAlignment = Alignment.CenterVertically) {
                MingoDisc(Color.White, 70.dp) { MingoIcon(R.drawable.ic_mingo_lightbulb, palette.highlight, 36.dp) }
                Spacer(GlanceModifier.width(14.dp))
                Column(GlanceModifier.defaultWeight()) {
                    MingoEyebrow(scene.context.getString(R.string.idea_eyebrow), palette.ink)
                    MingoGap(5.dp)
                    MingoText(scene.payload.dailyIdeaTitle ?: scene.context.getString(R.string.idea_empty), 18.sp, fixed(palette.ink), weight = FontWeight.Medium, maxLines = 3)
                    MingoGap(3.dp)
                    MingoText(scene.context.getString(R.string.idea_hint), 12.5.sp, fixed(palette.ink.copy(alpha = 0.8f)), maxLines = 1)
                }
            }
        }
    }
}

class MingoIdeaWidgetReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = MingoIdeaWidget()
}
