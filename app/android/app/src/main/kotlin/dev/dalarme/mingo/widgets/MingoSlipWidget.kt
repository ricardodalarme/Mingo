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

/** The one-tap shortcut to log a slip. */
class MingoSlipWidget : MingoWidget() {
    @Composable
    override fun Content(scene: MingoScene) {
        val palette = MingoPalette.of(scene.payload.theme)
        val fill = MingoBitmaps.linear(listOf(MingoPalette.Charcoal, MingoPalette.Plum), angle = 160f)
        MingoShell(MingoLink.Capture, MingoFill.Picture(fill)) {
            Column(GlanceModifier.fillMaxSize()) {
                MingoText(scene.context.getString(R.string.slip_prompt), 24.sp, fixed(Color.White.copy(alpha = 0.95f)), hand = true)
                Spacer(GlanceModifier.defaultWeight())
                Row(verticalAlignment = Alignment.CenterVertically) {
                    MingoDisc(palette.highlight, 50.dp) { MingoIcon(R.drawable.ic_mingo_plus, Color.White, 22.dp) }
                    Spacer(GlanceModifier.width(12.dp))
                    MingoText(scene.context.getString(R.string.slip_action), 13.sp, fixed(Color.White.copy(alpha = 0.8f)))
                }
            }
        }
    }
}

class MingoSlipWidgetReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = MingoSlipWidget()
}
