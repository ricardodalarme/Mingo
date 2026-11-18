package dev.dalarme.mingo.widgets.core

import androidx.compose.ui.graphics.Color
import androidx.glance.color.ColorProvider

/** The colors a widget paints with: the person's theme plus the fixed ones every theme shares. */
data class MingoPalette(
    val soft: Color,
    val highlight: Color,
    val label: Color,
    val border: Color,
    val tintStart: Color,
    val tintMiddle: Color,
    val tintEnd: Color,
    val mist: Color,
    val ink: Color,
) {
    companion object {
        fun of(theme: MingoTheme): MingoPalette = when (theme) {
            MingoTheme.Rose -> MingoPalette(
                soft = Color(0xFFFBE3E9), highlight = Color(0xFFE8577A), label = Color(0xFFC93A60),
                border = Color(0xFFF0E4E7), tintStart = Color(0xFFFFD3DE), tintMiddle = Color(0xFFFFC9B3),
                tintEnd = Color(0xFFFFB9A6), mist = Color(0xFFFFD6E0), ink = Color(0xFF6E2C3C),
            )
            MingoTheme.Blue -> MingoPalette(
                soft = Color(0xFFE1EDFB), highlight = Color(0xFF3C86DA), label = Color(0xFF2470C2),
                border = Color(0xFFE2EAF3), tintStart = Color(0xFFCFE2FA), tintMiddle = Color(0xFFBDD5F6),
                tintEnd = Color(0xFFA9C8F2), mist = Color(0xFFD4E5FB), ink = Color(0xFF1F3F66),
            )
            MingoTheme.Neutral -> MingoPalette(
                soft = Color(0xFFE2F0E7), highlight = Color(0xFF3A8E68), label = Color(0xFF287752),
                border = Color(0xFFE8E7E1), tintStart = Color(0xFFD6ECDE), tintMiddle = Color(0xFFC6E3D2),
                tintEnd = Color(0xFFB7DCC6), mist = Color(0xFFD9EEE0), ink = Color(0xFF24473A),
            )
        }

        val White = Color.White
        val Peach = Color(0xFFFFE3C4)
        val Cream = Color(0xFFFFF1E3)
        val Charcoal = Color(0xFF2B2828)
        val Plum = Color(0xFF5A2C40)
        val Paper = Color(0xFFFFF3D2)
        val PaperInk = Color(0xFF5B3A1E)
        val PaperLine = Color(0x2EB48C3C)
        val NightStart = Color(0xFF2D2F57)
        val NightMiddle = Color(0xFF6A5389)
        val NightEnd = Color(0xFFB88AA8)
        val DayStart = Color(0xFFFFB66B)
        val DayEnd = Color(0xFFFF7E6B)
        val NightHalfEnd = Color(0xFF5B4B88)
        val Sky = Color(0xFFE8F1FF)
        val SkyInk = Color(0xFF2B2D4E)
        val ConfettiYellow = Color(0xFFFFC25C)
        val ConfettiBlue = Color(0xFF7FB8F0)

        /** Surfaces and text that follow the system appearance. */
        val Surface = ColorProvider(day = Color.White, night = Color(0xFF1F1D1E))
        val TextPrimary = ColorProvider(day = Color(0xFF2B2828), night = Color(0xFFF4F1F2))
        val TextSecondary = ColorProvider(day = Color(0xFF736D70), night = Color(0xFFA9A3A6))
    }
}
