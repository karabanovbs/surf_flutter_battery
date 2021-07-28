package ru.karabanovbs.surf_flutter_battery

import android.content.*
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** SurfFlutterBatteryPlugin */
class SurfFlutterBatteryPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var binding: ActivityPluginBinding
    private lateinit var batteryLevelReceiver: BroadcastReceiver;

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "surf_flutter_battery")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        result.notImplemented();
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.binding = binding;
        this.batteryLevelReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                val rawlevel: Int = intent.getIntExtra("level", -1)
                val scale: Int = intent.getIntExtra("scale", -1)
                var level = -1
                if (rawlevel >= 0 && scale > 0) {
                    level = rawlevel * 100 / scale
                }
                channel.invokeMethod("getBatteryLevel", level.toFloat());
            }
        }

        IntentFilter(Intent.ACTION_BATTERY_CHANGED).let { ifilter ->
            binding.activity.registerReceiver(batteryLevelReceiver, ifilter)
        }

    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
        binding.activity.unregisterReceiver(batteryLevelReceiver);
    }
}
