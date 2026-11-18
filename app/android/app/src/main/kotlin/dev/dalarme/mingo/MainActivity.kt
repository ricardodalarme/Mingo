package dev.dalarme.mingo

import android.os.Bundle
import androidx.lifecycle.lifecycleScope
import dev.dalarme.mingo.widgets.MingoWidgetPreviews
import io.flutter.embedding.android.FlutterFragmentActivity
import kotlinx.coroutines.launch

class MainActivity : FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        lifecycleScope.launch { runCatching { MingoWidgetPreviews.publish(applicationContext) }.onFailure { android.util.Log.w("MingoPreviews", it) } }
    }
}
