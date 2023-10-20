package com.crypto.wallet

import io.flutter.embedding.android.FlutterFragmentActivity
//import android.view.WindowManager.LayoutParams
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterFragmentActivity () {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        //window.addFlags(LayoutParams.FLAG_SECURE)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        super.configureFlutterEngine(flutterEngine)
    }
}
