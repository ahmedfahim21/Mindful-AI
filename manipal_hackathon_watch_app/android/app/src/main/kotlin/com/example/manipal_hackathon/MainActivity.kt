package com.example.manipal_hackathon

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        intent.putExtra("background_mode", "transparent")
        super.onCreate(savedInstanceState)
    }
    // override fun onGenericMotionEvent(event: MotionEvent?): Boolean {
    //     return when {
    //         WearableRotaryPlugin.onGenericMotionEvent(event) -> true
    //         else -> super.onGenericMotionEvent(event)
    //     }
    // }
}
