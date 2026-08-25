package com.taning.app

import android.appwidget.AppWidgetManager
import android.content.Context

class WidgetBridge {
    companion object {
        fun updateWidgets(context: Context) {
            try {
                TaningWidget.updateWidgets(context)
            } catch (e: Exception) {
                // Handle error
            }
        }
    }
}