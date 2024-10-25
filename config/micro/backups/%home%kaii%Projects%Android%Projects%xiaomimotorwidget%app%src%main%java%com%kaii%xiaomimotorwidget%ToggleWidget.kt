package com.kaii.xiaomimotorwidget

import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.unit.dp
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.booleanPreferencesKey
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.GlanceTheme
import androidx.glance.action.ActionParameters
import androidx.glance.action.clickable
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.GlanceAppWidgetReceiver
import androidx.glance.appwidget.action.ActionCallback
import androidx.glance.appwidget.action.actionRunCallback
import androidx.glance.appwidget.cornerRadius
import androidx.glance.appwidget.provideContent
import androidx.glance.appwidget.state.updateAppWidgetState
import androidx.glance.background
import androidx.glance.currentState
import androidx.glance.layout.Alignment
import androidx.glance.layout.Column
import androidx.glance.layout.fillMaxSize
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextStyle
import androidx.glance.unit.ColorProvider
import java.io.File
import java.util.concurrent.TimeUnit

object ToggleWidget : GlanceAppWidget() {
    val cameraRaised = booleanPreferencesKey("cameraRaised")

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        provideContent {
            GlanceTheme {
                Content()
            }
        }
    }

    @Composable
    private fun Content() {
        val prefs = currentState<Preferences>()
        val raised = prefs[booleanPreferencesKey("cameraRaised")] ?: true

        val color: ColorProvider
        val foregroundColor: ColorProvider
        val text: String

        if (raised) {
            color = GlanceTheme.colors.primary
            foregroundColor = GlanceTheme.colors.onPrimary
            text = "UP!"
        } else {
            color = GlanceTheme.colors.widgetBackground
            foregroundColor = GlanceTheme.colors.onBackground
            text = "DOWN!"
        }

        Column(
            modifier = GlanceModifier
                .background(color)
                .cornerRadius(1000.dp)
                .clickable(actionRunCallback(ToggleCameraPosition::class.java))
                .fillMaxSize(),
            verticalAlignment = Alignment.CenterVertically,
            horizontalAlignment = Alignment.CenterHorizontally,
        ) {GlanceTheme.colors.widgetBackground
            Text(
                text = text,
                style = TextStyle(fontWeight = FontWeight.Bold, color = foregroundColor),
                modifier = GlanceModifier
                    .background(color)
            )
        }
    }
}

class ToggleWidgetReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget: GlanceAppWidget = ToggleWidget
}

class ToggleCameraPosition : ActionCallback {
    override suspend fun onAction(
        context: Context,
        glanceId: GlanceId,
        parameters: ActionParameters
    ) {
        updateAppWidgetState(context, glanceId) {prefs ->
            val raised = prefs[ToggleWidget.cameraRaised]

            if (raised == true) {
                prefs[ToggleWidget.cameraRaised] = false

				try {
                	"su && xiaomi-motor takeback 1".runCommand(File("/"))	
                }
                catch (e: Exception) {
                	println("setting camera position lower failed miserably")
                }
            }
            else {
                prefs[ToggleWidget.cameraRaised] = true
                try {
                	"su && xiaomi-motor popup 1".runCommand(File("/"))	
                }
                catch (e: Exception) {
                	println("setting camera position upper failed miserably")
                }
            }
        }

        ToggleWidget.update(context, glanceId)
    }
}

fun String.runCommand(workingDirectory: File) {
    ProcessBuilder(*split(" ").toTypedArray())
        .directory(workingDirectory)
        .redirectOutput(ProcessBuilder.Redirect.INHERIT)
        .redirectInput(ProcessBuilder.Redirect.INHERIT)
        .start()
        .waitFor(60, TimeUnit.SECONDS)
}
