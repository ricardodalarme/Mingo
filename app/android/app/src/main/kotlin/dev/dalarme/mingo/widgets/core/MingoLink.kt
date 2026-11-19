package dev.dalarme.mingo.widgets.core

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.glance.action.Action
import androidx.glance.appwidget.action.actionStartActivity
import dev.dalarme.mingo.MainActivity

/** A page of the app a widget opens when tapped. */
enum class MingoLink(private val host: String) {
    Today("today"),
    Together("together"),
    Capture("capture"),
    Rituals("rituals"),
    Dates("dates"),
    Card("card"),
    Slips("slips"),
    Invite("invite"),
    Distance("distance"),
    SignIn("sign-in");

    fun action(context: Context): Action = actionStartActivity(
        Intent("es.antonborri.home_widget.action.LAUNCH", Uri.parse("mingo://$host?src=widget"))
            .setComponent(ComponentName(context, MainActivity::class.java)),
    )
}
