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


/** The note the partner sent to the widget, on a taped sheet of ruled paper. */
class MingoPartnerNoteWidget : MingoWidget(needsPartner = true) {
    @Composable
    override fun Content(scene: MingoScene) {
        val payload = scene.payload
        val palette = MingoPalette.of(payload.theme)
        val medium = scene.size == MingoSize.Medium
        val fill = if (medium) MingoBitmaps.ruledPaper(MingoPalette.Paper, MingoPalette.PaperLine) else MingoBitmaps.linear(listOf(MingoPalette.Paper, MingoPalette.Paper))
        MingoShell(MingoLink.Today, MingoFill.Picture(fill), padding = if (medium) 20.dp else 16.dp) {
            Column(GlanceModifier.fillMaxSize()) {
                val note = payload.partnerNote
                if (note != null) {
                    MingoText(note, if (medium) 28.sp else 24.sp, fixed(MingoPalette.PaperInk), maxLines = 3, hand = true)
                } else {
                    MingoText(scene.context.getString(R.string.note_empty), 17.sp, fixed(MingoPalette.PaperInk), weight = FontWeight.Medium)
                }
                Spacer(GlanceModifier.defaultWeight())
                Row(GlanceModifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                    MingoText(footer(scene), 12.5.sp, fixed(MingoPalette.PaperInk.copy(alpha = 0.8f)), maxLines = 1, modifier = GlanceModifier.defaultWeight())
                    if (medium && note != null) MingoIcon(R.drawable.ic_mingo_heart, palette.highlight, 16.dp)
                }
            }
        }
    }

    private fun footer(scene: MingoScene): String {
        val payload = scene.payload
        if (payload.partnerNote == null) return scene.context.getString(R.string.note_empty_hint)
        val time = payload.partnerNoteAt?.let { scene.format.arrived(it, scene.now) }.orEmpty()
        val name = payload.partnerName
        return if (name != null) scene.context.getString(R.string.note_from, name, time) else scene.context.getString(R.string.note_from_partner, time)
    }
}

class MingoPartnerNoteWidgetReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget = MingoPartnerNoteWidget()
}
