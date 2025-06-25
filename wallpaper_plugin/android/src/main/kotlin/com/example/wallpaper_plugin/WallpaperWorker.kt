package com.example.wallpaper_plugin

import android.app.WallpaperManager
import android.content.Context
import android.graphics.BitmapFactory
import androidx.work.Worker
import androidx.work.WorkerParameters
import java.io.File

import android.content.Intent
import android.util.Log



class WallpaperWorker(ctx: Context, params: WorkerParameters) : Worker(ctx, params) {
    override fun doWork(): Result {
        val filePath = inputData.getString("filePath") ?: return Result.failure()
        val which    = inputData.getInt("which", 3)

        if (setWallpaper(filePath, which)){
            val intent = Intent("com.vpx.quowally.WALLPAPER_UPDATED")
            applicationContext.sendBroadcast(intent)
            Log.d("WallpaperWorker", "📤 Broadcast sent to notify wallpaper change.")

            // sendMessageToFlutter()
            return Result.success()
        }
        else{

            return Result.failure()
        } 
    }


    private fun setWallpaper(path: String, which: Int): Boolean {
        return try {
            val bmp = BitmapFactory.decodeFile(path) ?: return false
            val wm  = WallpaperManager.getInstance(applicationContext)
            when (which) {
                1 -> wm.setBitmap(bmp, null, true, WallpaperManager.FLAG_LOCK)
                2 -> wm.setBitmap(bmp, null, true, WallpaperManager.FLAG_SYSTEM)
                else -> wm.setBitmap(bmp)
            }
            true
        } catch (e: Exception) {
            e.printStackTrace()
            false
        }
    }

    // for telling dart or app about new wallpaper or new quote so that can update too
    // private fun sendMessageToFlutter() {
    //     // try {
    //         val flutterEngine = FlutterEngine(applicationContext)

    //         flutterEngine.dartExecutor.executeDartEntrypoint(
    //             DartExecutor.DartEntrypoint.createDefault()
    //         )

    //         val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "wallpaper_channel")

    //         channel.invokeMethod("onWallpaperChanged", null)

    //         Log.d("WallpaperWorker", "📢 Sent onWallpaperChanged to Dart.")

    //     // } catch (e: Exception) {
    //     //     Log.e("WallpaperWorker", "❌ Failed to notify Dart or App is terminated: ${e.message}")
    //     // }
    // }
    
    // private fun setWallpaper(path: String, which: Int): Boolean 
    // return try {
    //     val bmp = BitmapFactory.decodeFile(path) ?: return false
    //     val wm  = WallpaperManager.getInstance(applicationContext)
    //     when (which) {
    //         1 -> wm.setBitmap(bmp, null, true, WallpaperManager.FLAG_LOCK)
    //         2 -> wm.setBitmap(bmp, null, true, WallpaperManager.FLAG_SYSTEM)
    //         else -> wm.setBitmap(bmp)
    //     }
    //     true
    // } catch (e: Exception) { false }
}
