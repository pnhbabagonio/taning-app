package com.taning.app

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.net.Uri
import android.widget.RemoteViews
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.GlanceAppWidgetReceiver
import androidx.glance.appwidget.state.GlanceAppWidgetState
import androidx.glance.appwidget.state.PreferencesGlanceStateDefinition
import androidx.glance.appwidget.updateAll
import androidx.glance.currentState
import androidx.glance.background
import androidx.glance.layout.Column
import androidx.glance.layout.Row
import androidx.glance.layout.Spacer
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.height
import androidx.glance.layout.padding
import androidx.glance.layout.size
import androidx.glance.layout.width
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextAlign
import androidx.glance.text.TextStyle
import androidx.glance.unit.ColorProvider
import androidx.glance.unit.Dp
import androidx.glance.unit.dp
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import org.json.JSONObject
import android.content.SharedPreferences

class TaningWidget : GlanceAppWidget() {
    override suspend fun provideGlance(
        context: Context,
        id: GlanceAppWidgetId
    ) {
        // Load widget data from shared preferences
        val prefs = context.getSharedPreferences("taning_widget", Context.MODE_PRIVATE)
        val jsonData = prefs.getString("widget_data", null)
        
        val widgetData = if (jsonData != null) {
            try {
                val json = JSONObject(jsonData)
                WidgetData(
                    title = json.optString("title", "Vacation"),
                    days = json.optInt("days", 14),
                    hours = json.optInt("hours", 6),
                    minutes = json.optInt("minutes", 42),
                    color = json.optInt("color", 0xFF4F46E5),
                    progress = json.optDouble("progress", 0.0),
                    icon = json.optString("icon", "✈️"),
                    isComplete = json.optBoolean("isComplete", false),
                )
            } catch (e: Exception) {
                WidgetData.defaultData()
            }
        } else {
            WidgetData.defaultData()
        }

        provideContent {
            TaningWidgetContent(data = widgetData)
        }
    }
}

data class WidgetData(
    val title: String,
    val days: Int,
    val hours: Int,
    val minutes: Int,
    val color: Int,
    val progress: Double,
    val icon: String,
    val isComplete: Boolean,
) {
    companion object {
        fun defaultData() = WidgetData(
            title = "Taning",
            days = 0,
            hours = 0,
            minutes = 0,
            color = 0xFF4F46E5,
            progress = 0.0,
            icon = "⏳",
            isComplete = false
        )
    }
}

@Composable
fun TaningWidgetContent(data: WidgetData) {
    val color = Color(data.color)
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(color)
            .padding(12.dp)
    ) {
        // Top row: Icon and Title
        Row(
            modifier = Modifier.fillMaxWidth()
        ) {
            Text(
                text = data.icon,
                style = TextStyle(fontSize = 16.dp)
            )
            Spacer(modifier = Modifier.width(8.dp))
            Text(
                text = data.title,
                style = TextStyle(
                    color = ColorProvider(Color.WHITE),
                    fontSize = 12.dp,
                    fontWeight = FontWeight.Medium,
                ),
                maxLines = 1
            )
        }
        
        Spacer(modifier = Modifier.weight(1f))
        
        // Countdown display
        if (data.isComplete) {
            Text(
                text = "✅ Done!",
                style = TextStyle(
                    color = ColorProvider(Color.WHITE),
                    fontSize = 24.dp,
                    fontWeight = FontWeight.Bold,
                )
            )
        } else if (data.days > 0) {
            Column {
                Text(
                    text = "${data.days}d",
                    style = TextStyle(
                        color = ColorProvider(Color.WHITE),
                        fontSize = 32.dp,
                        fontWeight = FontWeight.Bold,
                    )
                )
                Text(
                    text = "${data.hours}h ${data.minutes}m",
                    style = TextStyle(
                        color = ColorProvider(Color.WHITE.copy(alpha = 0.7f)),
                        fontSize = 12.dp,
                    )
                )
            }
        } else if (data.hours > 0) {
            Text(
                text = "${data.hours}h ${data.minutes}m",
                style = TextStyle(
                    color = ColorProvider(Color.WHITE),
                    fontSize = 24.dp,
                    fontWeight = FontWeight.Bold,
                )
            )
        } else {
            Text(
                text = "${data.minutes}m",
                style = TextStyle(
                    color = ColorProvider(Color.WHITE),
                    fontSize = 24.dp,
                    fontWeight = FontWeight.Bold,
                )
            )
        }
        
        Spacer(modifier = Modifier.weight(1f))
        
        // Progress bar
        if (data.progress > 0 && data.progress < 1) {
            androidx.glance.background(
                Modifier
                    .fillMaxWidth()
                    .height(4.dp)
                    .background(ColorProvider(Color.WHITE.copy(alpha = 0.2f)))
            ) {
                androidx.glance.background(
                    Modifier
                        .fillMaxWidth(data.progress.toFloat())
                        .height(4.dp)
                        .background(ColorProvider(Color.WHITE))
                )
            }
        }
    }
}

// Widget Receiver
class TaningWidgetReceiver : GlanceAppWidgetReceiver() {
    override val glanceAppWidget: GlanceAppWidget = TaningWidget()
    
    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action == "UPDATE_WIDGET") {
            TaningWidget().updateAll(context)
        }
    }
}