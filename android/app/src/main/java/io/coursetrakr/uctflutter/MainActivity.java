package io.coursetrakr.uctflutter;

import android.content.Intent;
import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
  }

  public void onBackPressed() {
    if(getFlutterView() != null) {
      startActivity(new Intent(this, BasicActivity.class));
    } else {
      super.onBackPressed();
    }
  }
}
