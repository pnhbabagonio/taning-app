package com.taning.app

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import androidx.glance.appwidget.updateAll

class WidgetBridge {
    companion object {
        fun updateWidgets(context: Context) {
            try {
                TaningWidget().updateAll(context)
            } catch (e: Exception) {
                // Handle error
            }
        }
    }
}