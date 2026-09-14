package com.taning.taning

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Color
import android.net.Uri
import android.util.Log
import android.view.View
import android.widget.RemoteViews
import org.json.JSONArray
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
        val action = intent.action ?: return
        if (action == "com.taning.taning.WIDGET_UPDATE" ||
            action == AppWidgetManager.ACTION_APPWIDGET_UPDATE) {
            val appWidgetManager = AppWidgetManager.getInstance(context)
            val componentName = ComponentName(context, TaningWidget::class.java)
            val appWidgetIds = appWidgetManager.getAppWidgetIds(componentName)
            onUpdate(context, appWidgetManager, appWidgetIds)
        }
    }

    companion object {
        private const val TAG = "TaningWidget"

        private val ROW_IDS = intArrayOf(
            R.id.row_1, R.id.row_2, R.id.row_3,
            R.id.row_4, R.id.row_5, R.id.row_6
        )
        private val ROW_ICON_IDS = intArrayOf(
            R.id.row_1_icon, R.id.row_2_icon, R.id.row_3_icon,
            R.id.row_4_icon, R.id.row_5_icon, R.id.row_6_icon
        )
        private val ROW_TITLE_IDS = intArrayOf(
            R.id.row_1_title, R.id.row_2_title, R.id.row_3_title,
            R.id.row_4_title, R.id.row_5_title, R.id.row_6_title
        )
        private val ROW_COUNTDOWN_IDS = intArrayOf(
            R.id.row_1_countdown, R.id.row_2_countdown, R.id.row_3_countdown,
            R.id.row_4_countdown, R.id.row_5_countdown, R.id.row_6_countdown
        )
        private val ROW_DATE_IDS = intArrayOf(
            R.id.row_1_date, R.id.row_2_date, R.id.row_3_date,
            R.id.row_4_date, R.id.row_5_date, R.id.row_6_date
        )

        fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int
        ) {
            try {
                val views = RemoteViews(context.packageName, R.layout.taning_widget_layout)

                // Determine widget size
                val options = appWidgetManager.getAppWidgetOptions(appWidgetId)
                val minHeight = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_HEIGHT)

                val maxItems = when {
                    minHeight < 130 -> 1
                    minHeight < 250 -> 4
                    else -> 6
                }

                // Load data from SharedPreferences
                val prefs: SharedPreferences = context.getSharedPreferences(
                    "FlutterSharedPreferences",
                    Context.MODE_PRIVATE
                )
                val jsonString = prefs.getString("flutter.widget_data", null)

                var taningList: JSONArray? = null
                try {
                    if (jsonString != null) {
                        val json = JSONObject(jsonString)
                        taningList = json.optJSONArray("tanings")
                    }
                } catch (e: Exception) {
                    Log.e(TAG, "Error parsing widget data", e)
                }

                // Handle empty state
                if (taningList == null || taningList.length() == 0) {
                    views.setViewVisibility(R.id.empty_state, View.VISIBLE)
                    for (rowId in ROW_IDS) {
                        views.setViewVisibility(rowId, View.GONE)
                    }
                    views.setViewVisibility(R.id.widget_header, View.VISIBLE)
                } else {
                    views.setViewVisibility(R.id.empty_state, View.GONE)
                    views.setViewVisibility(R.id.widget_header, View.VISIBLE)

                    val itemCount = minOf(taningList.length(), maxItems)

                    for (i in 0 until 6) {
                        if (i < itemCount) {
                            val taning = taningList.getJSONObject(i)
                            showRow(context, views, i, taning)
                        } else {
                            views.setViewVisibility(ROW_IDS[i], View.GONE)
                        }
                    }
                }

                // Whole widget tap → open app home
                val homeIntent = Intent(context, MainActivity::class.java)
                val homePendingIntent = PendingIntent.getActivity(
                    context,
                    0,
                    homeIntent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )
                views.setOnClickPendingIntent(R.id.widget_header, homePendingIntent)

                appWidgetManager.updateAppWidget(appWidgetId, views)
            } catch (e: Exception) {
                Log.e(TAG, "Error updating widget $appWidgetId", e)
            }
        }

        private fun showRow(
            context: Context,
            views: RemoteViews,
            index: Int,
            taning: JSONObject
        ) {
            val rowId = ROW_IDS[index]
            val iconId = ROW_ICON_IDS[index]
            val titleId = ROW_TITLE_IDS[index]
            val countdownId = ROW_COUNTDOWN_IDS[index]
            val dateId = ROW_DATE_IDS[index]

            views.setViewVisibility(rowId, View.VISIBLE)

            // Icon
            val icon = taning.optString("icon", "⏳")
            views.setTextViewText(iconId, icon)

            // Title
            val title = taning.optString("title", "Untitled")
            val isPinned = taning.optBoolean("isPinned", false)
            val displayTitle = if (isPinned) "📌 $title" else title
            views.setTextViewText(titleId, displayTitle)

            // Countdown
            val countdown = taning.optString("countdown", "—")
            views.setTextViewText(countdownId, countdown)

            // Date
            val date = taning.optString("date", "")
            if (date.isNotEmpty()) {
                views.setTextViewText(dateId, date)
                views.setViewVisibility(dateId, View.VISIBLE)
            } else {
                views.setViewVisibility(dateId, View.GONE)
            }

            // Color — guarded against invalid ranges
            try {
                var red = taning.optDouble("red", 0.31).toFloat()
                var green = taning.optDouble("green", 0.27).toFloat()
                var blue = taning.optDouble("blue", 0.9).toFloat()

                // Guard against NaN/Infinity/out-of-range
                if (red.isNaN() || red.isInfinite()) red = 0.31f
                if (green.isNaN() || green.isInfinite()) green = 0.27f
                if (blue.isNaN() || blue.isInfinite()) blue = 0.9f

                red = red.coerceIn(0f, 1f)
                green = green.coerceIn(0f, 1f)
                blue = blue.coerceIn(0f, 1f)

                val color = Color.rgb(
                    (red * 255).toInt(),
                    (green * 255).toInt(),
                    (blue * 255).toInt()
                )
                views.setTextColor(countdownId, color)
            } catch (e: Exception) {
                Log.w(TAG, "Invalid color for row $index", e)
                views.setTextColor(countdownId, Color.WHITE)
            }

            // Per-row tap → open specific Taning
            val taningId = taning.optString("id", "")
            val detailIntent = Intent(context, MainActivity::class.java).apply {
                action = Intent.ACTION_VIEW
                data = Uri.parse("taning://detail/$taningId")
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
            }
            val detailPendingIntent = PendingIntent.getActivity(
                context,
                index + 100,
                detailIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(rowId, detailPendingIntent)
        }
    }
}