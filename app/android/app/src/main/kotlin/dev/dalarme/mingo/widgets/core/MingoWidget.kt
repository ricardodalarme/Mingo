package dev.dalarme.mingo.widgets.core

import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.DpSize
import androidx.compose.ui.unit.dp
import androidx.glance.GlanceId
import androidx.glance.GlanceTheme
import androidx.glance.LocalContext
import androidx.glance.LocalSize
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.SizeMode
import androidx.glance.appwidget.provideContent
import androidx.glance.layout.Alignment
import androidx.glance.layout.Column
import androidx.glance.layout.fillMaxWidth
import androidx.glance.GlanceModifier
import androidx.glance.text.FontWeight
import androidx.compose.ui.unit.sp
import dev.dalarme.mingo.R
import java.time.ZonedDateTime

/** The two shapes a widget is laid out for. */
enum class MingoSize {
    Small,
    Medium;

    companion object {
        val Sizes = setOf(DpSize(110.dp, 110.dp), DpSize(250.dp, 110.dp))

        fun of(size: DpSize): MingoSize = if (size.width >= 200.dp) Medium else Small
    }
}

/** What a widget needs to draw itself once. */
class MingoScene(
    val payload: MingoPayload,
    val size: MingoSize,
    val now: ZonedDateTime,
    val format: MingoFormat,
    val context: Context,
)

/**
 * The base of every widget: reads the payload the app wrote, draws the signed-out and invite
 * states, and leaves the rest to [Content].
 */
abstract class MingoWidget(private val needsPartner: Boolean = false) : GlanceAppWidget() {
    override val sizeMode: SizeMode = SizeMode.Responsive(MingoSize.Sizes)

    @Composable
    protected abstract fun Content(scene: MingoScene)

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        val payload = MingoPayloadStore.load(context)
        provideContent { Scene(context, payload) }
    }

    override suspend fun providePreview(context: Context, widgetCategory: Int) {
        val payload = MingoSamples.payload(context)
        provideContent { Scene(context, payload) }
    }

    @Composable
    private fun Scene(context: Context, payload: MingoPayload) {
        val scene = MingoScene(
            payload = payload,
            size = MingoSize.of(LocalSize.current),
            now = ZonedDateTime.now(),
            format = MingoFormat(context),
            context = context,
        )
        GlanceTheme {
            when {
                !payload.isSignedIn -> SignedOut(scene)
                needsPartner && !payload.isPaired -> Invite(scene)
                else -> Content(scene)
            }
        }
    }
}

@Composable
private fun SignedOut(scene: MingoScene) {
    MingoShell(MingoLink.SignIn, MingoFill.Solid(MingoPalette.Surface)) {
        Column(GlanceModifier.fillMaxWidth()) {
            MingoText(scene.context.getString(R.string.signed_out_label).uppercase(), 11.5.sp, MingoPalette.TextSecondary, maxLines = 1)
            MingoGap(6.dp)
            MingoText(scene.context.getString(R.string.signed_out_title), 15.sp, MingoPalette.TextPrimary, weight = FontWeight.Medium, maxLines = 3)
        }
    }
}

@Composable
private fun Invite(scene: MingoScene) {
    val palette = MingoPalette.of(scene.payload.theme)
    val context = LocalContext.current
    MingoShell(MingoLink.Invite, MingoFill.Solid(MingoPalette.Surface)) {
        Column(GlanceModifier.fillMaxWidth(), verticalAlignment = Alignment.Bottom) {
            MingoIcon(R.drawable.ic_mingo_heart, palette.highlight, 20.dp)
            MingoGap(8.dp)
            MingoText(context.getString(R.string.invite_title), 15.sp, MingoPalette.TextPrimary, weight = FontWeight.Medium, maxLines = 3)
            MingoGap(3.dp)
            MingoText(context.getString(R.string.invite_action), 12.5.sp, fixed(palette.label), maxLines = 1)
        }
    }
}
