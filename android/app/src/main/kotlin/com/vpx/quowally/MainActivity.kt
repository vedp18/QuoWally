// package com.vpx.quowally

// import io.flutter.embedding.android.FlutterActivity

// class MainActivity : FlutterActivity() 


// package com.vpx.quowally

// import android.content.BroadcastReceiver
// import android.content.Context
// import android.content.Intent
// import android.content.IntentFilter
// import android.os.Bundle
// import io.flutter.embedding.android.FlutterActivity
// import io.flutter.embedding.engine.FlutterEngine
// import io.flutter.plugin.common.MethodChannel

// class MainActivity : FlutterActivity() {
//     private val CHANNEL = "wallpaper_channel"
//     private var methodChannel: MethodChannel? = null

//     override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//         super.configureFlutterEngine(flutterEngine)

//         methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

//         val filter = IntentFilter("com.vpx.quowally.WALLPAPER_UPDATED")
//         registerReceiver(broadcastReceiver, filter)
//     }

//     private val broadcastReceiver = object : BroadcastReceiver() {
//         override fun onReceive(context: Context?, intent: Intent?) {
//             if (intent?.action == "com.vpx.quowally.WALLPAPER_UPDATED") {
//                 methodChannel?.invokeMethod("onWallpaperChanged", null)
//             }
//         }
//     }

//     override fun onDestroy() {
//         unregisterReceiver(broadcastReceiver)
//         super.onDestroy()
//     }
// }

package com.vpx.quowally

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "wallpaper_channel"
    private var methodChannel: MethodChannel? = null
    private var isReceiverRegistered = false

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        val filter = IntentFilter("com.vpx.quowally.WALLPAPER_UPDATED")
        try {
            registerReceiver(broadcastReceiver, filter)
            isReceiverRegistered = true
            Log.d("MainActivity", "✅ BroadcastReceiver registered.")
        } catch (e: Exception) {
            Log.e("MainActivity", "❌ Failed to register receiver: ${e.message}")
        }
    }

    private val broadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            if (intent?.action == "com.vpx.quowally.WALLPAPER_UPDATED") {
                Log.d("MainActivity", "📡 Broadcast received.")
                try {
                    methodChannel?.invokeMethod("onWallpaperChanged", null)
                    Log.d("MainActivity", "✅ Dart method invoked.")
                } catch (e: Exception) {
                    Log.e("MainActivity", "❌ Error invoking Dart method: ${e.message}")
                }
            }
        }
    }

    override fun onDestroy() {
        if (isReceiverRegistered) {
            try {
                unregisterReceiver(broadcastReceiver)
                Log.d("MainActivity", "✅ BroadcastReceiver unregistered.")
            } catch (e: IllegalArgumentException) {
                Log.w("MainActivity", "⚠️ BroadcastReceiver already unregistered.")
            }
        }
        super.onDestroy()
    }
}
