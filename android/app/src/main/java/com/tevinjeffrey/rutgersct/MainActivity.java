package com.tevinjeffrey.rutgersct;

import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import com.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
  }
}
