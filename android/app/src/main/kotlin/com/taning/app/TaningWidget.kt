package com.taning.app

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.widget.RemoteViews
import com.taning.taning.R
import org.json.JSONObject

class TaningWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        updateWidgets(context, appWidgetManager, appWidgetIds)
    }

    companion object {
        fun updateWidgets(context: Context) {
            val manager = AppWidgetManager.getInstance(context)
            val component = ComponentName(context, TaningWidget::class.java)
            updateWidgets(context, manager, manager.getAppWidgetIds(component))
        }

        private fun updateWidgets(
            context: Context,
            manager: AppWidgetManager,
            ids: IntArray,
        ) {
            val prefs = context.getSharedPreferences(
                "FlutterSharedPreferences",
                Context.MODE_PRIVATE,
            )
            val rawData = prefs.getString("flutter.widget_data", null)
            val data = rawData?.let { parseData(it) } ?: WidgetData.defaultData()

            ids.forEach { id ->
                val views = RemoteViews(context.packageName, R.layout.taning_widget_layout)
                views.setTextViewText(R.id.widget_title, data.title)
                views.setTextViewText(
                    R.id.widget_countdown,
                    if (data.isComplete) "Done!" else "${data.days}d",
                )
                views.setTextViewText(
                    R.id.widget_subtext,
                    "${data.hours}h ${data.minutes}m",
                )
                views.setProgressBar(
                    R.id.widget_progress,
                    100,
                    (data.progress * 100).toInt().coerceIn(0, 100),
                    false,
                )
                manager.updateAppWidget(id, views)
            }
        }

        private fun parseData(rawData: String): WidgetData? = try {
            val json = JSONObject(rawData)
            WidgetData(
                title = json.optString("title", "Taning"),
                days = json.optInt("days", 0),
                hours = json.optInt("hours", 0),
                minutes = json.optInt("minutes", 0),
                progress = json.optDouble("progress", 0.0),
                isComplete = json.optBoolean("isComplete", false),
            )
        } catch (_: Exception) {
            null
        }
    }
}

data class WidgetData(
    val title: String,
    val days: Int,
    val hours: Int,
    val minutes: Int,
    val progress: Double,
    val isComplete: Boolean,
) {
    companion object {
        fun defaultData() = WidgetData("Taning", 0, 0, 0, 0.0, false)
    }
}
