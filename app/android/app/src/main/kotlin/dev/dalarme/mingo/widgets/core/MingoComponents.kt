package dev.dalarme.mingo.widgets.core

import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.TextUnit
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.ColorFilter
import androidx.glance.GlanceModifier
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.LocalContext
import androidx.glance.action.clickable
import androidx.glance.appwidget.cornerRadius
import androidx.glance.background
import androidx.glance.unit.ColorProvider
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.Column
import androidx.glance.layout.ContentScale
import androidx.glance.layout.Row
import androidx.glance.layout.Spacer
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.height
import androidx.glance.layout.padding
import androidx.glance.layout.size
import androidx.glance.layout.width
import androidx.glance.text.FontFamily
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextAlign
import androidx.glance.text.TextStyle
import dev.dalarme.mingo.R

/** What fills the back of a widget. */
sealed interface MingoFill {
    data class Solid(val color: ColorProvider) : MingoFill
    data class Picture(val image: ImageProvider) : MingoFill
}

/** The frame every widget shares: its background, a tap target and the page it opens. */
@Composable
fun MingoShell(
    link: MingoLink,
    fill: MingoFill,
    padding: Dp = 16.dp,
    backdrop: @Composable () -> Unit = {},
    content: @Composable () -> Unit,
) {
    val context = LocalContext.current
    Box(
        modifier = GlanceModifier
            .fillMaxSize()
            .cornerRadius(28.dp)
            .clickable(link.action(context)),
    ) {
        when (fill) {
            is MingoFill.Solid -> Box(GlanceModifier.fillMaxSize().background(fill.color)) {}
            is MingoFill.Picture -> Image(
                provider = fill.image,
                contentDescription = null,
                contentScale = ContentScale.FillBounds,
                modifier = GlanceModifier.fillMaxSize(),
            )
        }
        backdrop()
        Box(modifier = GlanceModifier.fillMaxSize().padding(padding)) { content() }
    }
}

/** A line of text at an exact size. */
@Composable
fun MingoText(
    text: String,
    size: TextUnit,
    color: ColorProvider,
    modifier: GlanceModifier = GlanceModifier,
    weight: FontWeight = FontWeight.Normal,
    maxLines: Int = 2,
    hand: Boolean = false,
    align: TextAlign? = null,
) {
    Text(
        text = text,
        modifier = modifier,
        maxLines = maxLines,
        style = TextStyle(
            color = color,
            fontSize = size,
            fontWeight = weight,
            fontFamily = if (hand) FontFamily.Cursive else null,
            textAlign = align,
        ),
    )
}

fun fixed(color: Color): ColorProvider = ColorProvider(color)

/** The small uppercase label at the top of a widget. */
@Composable
fun MingoEyebrow(text: String, color: Color) {
    MingoText(
        text = text.uppercase(),
        size = 11.5.sp,
        color = fixed(color.copy(alpha = 0.78f)),
        weight = FontWeight.Medium,
        maxLines = 1,
    )
}

/** A drawable tinted to [color]. */
@Composable
fun MingoIcon(res: Int, color: Color, size: Dp, modifier: GlanceModifier = GlanceModifier) {
    Image(
        provider = ImageProvider(res),
        contentDescription = null,
        colorFilter = ColorFilter.tint(ColorProvider(color)),
        modifier = modifier.size(size),
    )
}

/** Two overlapping initials for the two people, each with a white ring. */
@Composable
fun MingoInitials(own: String?, partner: String?, ownColor: Color, ownBackground: Color, size: Dp = 26.dp) {
    val ownInitial = initial(own)
    val partnerInitial = initial(partner)
    Box {
        ownInitial?.let { MingoInitial(it, ownColor, ownBackground, size) }
        partnerInitial?.let {
            val shift = if (ownInitial != null) size * 0.7f else 0.dp
            Box(GlanceModifier.padding(start = shift)) {
                MingoInitial(it, Color.White, MingoPalette.Charcoal, size)
            }
        }
    }
}

@Composable
private fun MingoInitial(letter: String, color: Color, background: Color, size: Dp) {
    Box(
        modifier = GlanceModifier.size(size).cornerRadius(size / 2).background(Color.White).padding(2.dp),
    ) {
        Box(
            modifier = GlanceModifier.fillMaxSize().cornerRadius(size / 2).background(background),
            contentAlignment = Alignment.Center,
        ) {
            MingoText(letter, 10.sp, fixed(color), weight = FontWeight.Medium, maxLines = 1)
        }
    }
}

private fun initial(name: String?): String? = name?.firstOrNull()?.uppercaseChar()?.toString()

/** A circle of [fill] with [content] centered in it. */
@Composable
fun MingoDisc(fill: Color, size: Dp, content: @Composable () -> Unit) {
    Box(modifier = GlanceModifier.size(size), contentAlignment = Alignment.Center) {
        Image(
            provider = MingoBitmaps.circle(fill),
            contentDescription = null,
            modifier = GlanceModifier.fillMaxSize(),
        )
        content()
    }
}

@Composable
fun MingoGap(height: Dp) = Spacer(GlanceModifier.height(height))

val MingoMood.face: Int
    get() = when (this) {
        MingoMood.Happy -> R.drawable.ic_mingo_face_happy
        MingoMood.Tired -> R.drawable.ic_mingo_face_tired
        MingoMood.Sad -> R.drawable.ic_mingo_face_sad
        MingoMood.Stressed -> R.drawable.ic_mingo_face_stressed
        MingoMood.Loving -> R.drawable.ic_mingo_face_loving
        MingoMood.Playful -> R.drawable.ic_mingo_face_playful
    }

val MingoMood.nameRes: Int
    get() = when (this) {
        MingoMood.Happy -> R.string.mood_happy
        MingoMood.Tired -> R.string.mood_tired
        MingoMood.Sad -> R.string.mood_sad
        MingoMood.Stressed -> R.string.mood_stressed
        MingoMood.Loving -> R.string.mood_loving
        MingoMood.Playful -> R.string.mood_playful
    }

fun Context.string(res: Int, vararg args: Any): String = getString(res, *args)
