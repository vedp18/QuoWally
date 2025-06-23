package com.vpx.quowally.wallpaper

import android.app.WallpaperManager
import android.content.Context
import android.graphics.BitmapFactory
import androidx.work.Worker
import androidx.work.WorkerParameters
import java.io.File

class WallpaperWorker(ctx: Context, params: WorkerParameters) : Worker(ctx, params) {
    override fun doWork(): Result {
        val filePath = inputData.getString("filePath") ?: return Result.failure()
        val which    = inputData.getInt("which", 3)

        return if (setWallpaper(filePath, which)) Result.success()
               else Result.failure()
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
