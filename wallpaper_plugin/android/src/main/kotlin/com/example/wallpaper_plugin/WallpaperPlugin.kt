package com.example.wallpaper_plugin

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import androidx.work.*
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class WallpaperPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "wallpaper_channel")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "startNativeWallpaperWorker") {
            val filePath = call.argument<String>("filePath") ?: return result.error("NO_FILE", null, null)
            val which = call.argument<Int>("which") ?: 3

            val request = OneTimeWorkRequestBuilder<WallpaperWorker>()
                .setInputData(workDataOf("filePath" to filePath, "which" to which))
                .build()

            WorkManager.getInstance(context).enqueue(request)
            result.success("Worker scheduled")
        } else {
            result.notImplemented()
        }
    }
}
