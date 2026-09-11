package com.taning.taning

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Color
import android.widget.RemoteViews
import org.json.JSONObject

class TaningWidget : AppWidgetProvider() {
    
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }
    
    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action == "com.taning.taning.WIDGET_UPDATE") {
            val appWidgetManager = AppWidgetManager.getInstance(context)
            val componentName = android.content.ComponentName(context, TaningWidget::class.java)
            val appWidgetIds = appWidgetManager.getAppWidgetIds(componentName)
            onUpdate(context, appWidgetManager, appWidgetIds)
        }
    }
    
    companion object {
        fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int
        ) {
            // Load data from SharedPreferences
            val prefs: SharedPreferences = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE
            )
            
            val jsonString = prefs.getString("flutter.widget_data", null)
            
            // Create RemoteViews
            val views = RemoteViews(context.packageName, R.layout.taning_widget_layout)
            
            if (jsonString != null) {
                try {
                    val json = JSONObject(jsonString)
                    
                    val title = json.optString("title", "Taning")
                    val days = json.optInt("days", 0)
                    val hours = json.optInt("hours", 0)
                    val minutes = json.optInt("minutes", 0)
                    val seconds = json.optInt("seconds", 0)
                    val icon = json.optString("icon", "⏳")
                    val progress = json.optDouble("progress", 0.0)
                    val isComplete = json.optBoolean("isComplete", false)
                    val red = json.optDouble("red", 0.31)
                    val green = json.optDouble("green", 0.27)
                    val blue = json.optDouble("blue", 0.9)
                    
                    // Set background color
                    val bgColor = Color.rgb(
                        (red * 255).toInt(),
                        (green * 255).toInt(),
                        (blue * 255).toInt()
                    )
                    views.setInt(R.id.widget_container, "setBackgroundColor", bgColor)
                    
                    // Set title
                    views.setTextViewText(R.id.widget_title, "$icon $title")
                    
                    // Set countdown text
                    val countdownText = when {
                        isComplete -> "✅ Done!"
                        days > 0 -> "${days}d ${hours}h"
                        hours > 0 -> "${hours}h ${minutes}m"
                        else -> "${minutes}m ${seconds}s"
                    }
                    views.setTextViewText(R.id.widget_countdown, countdownText)
                    
                    // Set progress
                    if (progress > 0.0 && progress < 1.0) {
                        views.setProgressBar(R.id.widget_progress, 100, (progress * 100).toInt(), false)
                        views.setViewVisibility(R.id.widget_progress, android.view.View.VISIBLE)
                    } else {
                        views.setViewVisibility(R.id.widget_progress, android.view.View.GONE)
                    }
                } catch (e: Exception) {
                    e.printStackTrace()
                    views.setTextViewText(R.id.widget_title, "Taning")
                    views.setTextViewText(R.id.widget_countdown, "No data")
                }
            } else {
                views.setTextViewText(R.id.widget_title, "Taning")
                views.setTextViewText(R.id.widget_countdown, "Open app")
            }
            
            // Set click intent to open the app
            val intent = Intent(context, MainActivity::class.java)
            val pendingIntent = PendingIntent.getActivity(
                context,
                0,
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(R.id.widget_container, pendingIntent)
            
            // Update the widget
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}