package dev.dalarme.mingo.widgets.core

import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.LinearGradient
import android.graphics.Paint
import android.graphics.RadialGradient
import android.graphics.RectF
import android.graphics.Shader
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.toArgb
import androidx.core.graphics.PathParser
import androidx.glance.ImageProvider

/**
 * Draws the gradients and shapes Glance has no primitive for.
 *
 * Widgets scale these with `FillBounds`, so a small bitmap is enough for a smooth gradient.
 */
object MingoBitmaps {
    private const val SIZE = 192

    /** A linear gradient running at [angle] degrees clockwise from the top (180 = top to bottom). */
    fun linear(colors: List<Color>, angle: Float = 160f, stops: FloatArray? = null): ImageProvider {
        val radians = Math.toRadians(angle.toDouble())
        val dx = Math.sin(radians).toFloat()
        val dy = -Math.cos(radians).toFloat()
        val half = SIZE / 2f
        val paint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            shader = LinearGradient(
                half - dx * half, half - dy * half, half + dx * half, half + dy * half,
                colors.map { it.toArgb() }.toIntArray(), stops, Shader.TileMode.CLAMP,
            )
        }
        return draw { it.drawRect(0f, 0f, SIZE.toFloat(), SIZE.toFloat(), paint) }
    }

    /** A radial gradient centered at ([cx], [cy]) as fractions of the bitmap. */
    fun radial(colors: List<Color>, cx: Float = 0.5f, cy: Float = 0.5f, stops: FloatArray? = null): ImageProvider {
        val paint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            shader = RadialGradient(
                cx * SIZE, cy * SIZE, SIZE * 0.85f,
                colors.map { it.toArgb() }.toIntArray(), stops, Shader.TileMode.CLAMP,
            )
        }
        return draw { it.drawRect(0f, 0f, SIZE.toFloat(), SIZE.toFloat(), paint) }
    }

    /** A filled circle. */
    fun circle(color: Color): ImageProvider {
        val paint = Paint(Paint.ANTI_ALIAS_FLAG).apply { this.color = color.toArgb() }
        return draw { it.drawOval(RectF(0f, 0f, SIZE.toFloat(), SIZE.toFloat()), paint) }
    }

    /** A circle outline, [stroke] as a fraction of the diameter. */
    fun ring(color: Color, stroke: Float): ImageProvider {
        val width = SIZE * stroke
        val paint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            this.color = color.toArgb()
            style = Paint.Style.STROKE
            strokeWidth = width
        }
        val inset = width / 2
        return draw { it.drawOval(RectF(inset, inset, SIZE - inset, SIZE - inset), paint) }
    }

    /** A progress ring: a [track] circle with [color] drawn over the first [progress] of it. */
    fun progressRing(track: Color, color: Color, progress: Float, stroke: Float): ImageProvider {
        val width = SIZE * stroke
        val inset = width / 2
        val oval = RectF(inset, inset, SIZE - inset, SIZE - inset)
        val base = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            style = Paint.Style.STROKE
            strokeWidth = width
            strokeCap = Paint.Cap.ROUND
        }
        return draw {
            it.drawOval(oval, base.apply { this.color = track.toArgb() })
            it.drawArc(oval, -90f, 360f * progress, false, base.apply { this.color = color.toArgb() })
        }
    }

    /** A vertical dotted line, [color] on a tall narrow bitmap. */
    fun dottedLine(color: Color): ImageProvider {
        val paint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            this.color = color.toArgb()
            strokeCap = Paint.Cap.ROUND
            strokeWidth = 6f
        }
        val bitmap = Bitmap.createBitmap(8, SIZE, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        var y = 4f
        while (y < SIZE) {
            canvas.drawPoint(4f, y, paint)
            y += 14f
        }
        return ImageProvider(bitmap)
    }

    /** Horizontal ruled lines like notebook paper. */
    fun ruledPaper(background: Color, line: Color): ImageProvider {
        val paint = Paint().apply {
            this.color = line.toArgb()
            strokeWidth = 2f
        }
        return draw {
            it.drawColor(background.toArgb())
            var y = 31f * SIZE / 169
            while (y < SIZE) {
                it.drawLine(0f, y, SIZE.toFloat(), y, paint)
                y += 32f * SIZE / 169
            }
        }
    }

    private fun draw(block: (Canvas) -> Unit): ImageProvider {
        val bitmap = Bitmap.createBitmap(SIZE, SIZE, Bitmap.Config.ARGB_8888)
        block(Canvas(bitmap))
        return ImageProvider(bitmap)
    }

    private const val HEART =
        "M12 20.5C5 15.5 3 12 3 8.8 3 6.2 5 4.5 7.3 4.5c1.9 0 3.5 1 4.7 2.9 1.2-1.9 2.8-2.9 4.7-2.9C19 4.5 21 6.2 21 8.8c0 3.2-2 6.7-9 11.7z"

    /** A large translucent heart rotated and bleeding off the bottom-right corner. */
    fun heartWatermark(color: Color): ImageProvider {
        val path = PathParser.createPathFromPathData(HEART)
        val paint = Paint(Paint.ANTI_ALIAS_FLAG).apply { this.color = color.toArgb() }
        return draw {
            val side = SIZE * 120f / 169f
            it.save()
            it.translate(SIZE * 0.52f, SIZE * 0.5f)
            it.rotate(14f, side / 2, side / 2)
            it.scale(side / 24f, side / 24f)
            it.drawPath(path, paint)
            it.restore()
        }
    }
}
