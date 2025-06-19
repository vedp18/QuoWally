package com.vpx.quowally

import android.app.WallpaperManager
import android.graphics.BitmapFactory
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.IOException

class MainActivity : FlutterActivity() {
    private val CHANNEL = "wallpaper_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // MethodChannel for communication with Flutter
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call,
                result ->
            if (call.method == "setWallpaper") {
                val filePath = call.argument<String>("filePath")
                val which = call.argument<Int>("which") ?: 3
                Log.d("WallpaperDebug", "$which")

                if (filePath != null) {
                    val success = setWallpaper(filePath, which)
                    if (success) {
                        result.success("Wallpaper Set Successfully")
                    } else {
                        result.error("ERROR", "Failed to set wallpaper", null)
                    }
                } else {
                    result.error("INVALID_ARGUMENT", "File path is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    /** Function to set an image file as wallpaper. */
    private fun setWallpaper(filePath: String, which: Int): Boolean {
        return try {
            val file = File(filePath)
            if (!file.exists()) {
                return false
            }

            // Convert file to bitmap
            val bitmap = BitmapFactory.decodeFile(filePath)

            // Get WallpaperManager instance and set wallpaper
            val wallpaperManager = WallpaperManager.getInstance(applicationContext)

            if (which == 1) {
                wallpaperManager.setBitmap(bitmap, null, true, WallpaperManager.FLAG_LOCK)
            } else if (which == 2) {
                wallpaperManager.setBitmap(bitmap, null, true, WallpaperManager.FLAG_SYSTEM)
            } else {
                wallpaperManager.setBitmap(bitmap)
            }

            true // Success
        } catch (e: IOException) {
            e.printStackTrace()
            false // Failure
        }
    }
}
