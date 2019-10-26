package ru.sberbank.pineapple.winmap;

import android.os.Bundle;
import android.os.Build;

import java.util.*;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import android.util.Log;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.wifi.WifiManager;
import android.net.wifi.ScanResult;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "flutter.native/channel";
    private static final Gson gson = new GsonBuilder().create();
    private static List<String> networksList = new ArrayList<>();
    private static String deviceProperties = "{}";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        Context context = getApplicationContext();
        MethodChannel.Result channel;

        WifiManager wifiManager = (WifiManager) context.getSystemService(Context.WIFI_SERVICE);
        BroadcastReceiver wifiScanReceiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context c, Intent intent) {
                boolean success = intent.getBooleanExtra(WifiManager.EXTRA_RESULTS_UPDATED, false);
                if (success) {
                    List<String> networks = new ArrayList<>();
                    List<ScanResult> scanResults = wifiManager.getScanResults();
                    for (ScanResult scanResult : scanResults) {
                        Map<String, String> network = new HashMap<>();
                        network.put("ssid", scanResult.SSID);
                        network.put("bssid", scanResult.BSSID);
                        network.put("capabilities", scanResult.capabilities);
                        network.put("centerFreq0", String.valueOf(scanResult.centerFreq0));
                        network.put("centerFreq1", String.valueOf(scanResult.centerFreq1));
                        network.put("channelWidth", String.valueOf(scanResult.channelWidth));
                        network.put("frequency", String.valueOf(scanResult.frequency));
                        network.put("level", String.valueOf(scanResult.level));
                        networks.add(gson.toJson(network));
                    }
                    networksList = networks;
                }
            }
        };

        deviceProperties = getDeviceInformation();

        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction(WifiManager.SCAN_RESULTS_AVAILABLE_ACTION);
        context.registerReceiver(wifiScanReceiver, intentFilter);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                        if (call.method.equals("getDeviceProperties")) {
                            result.success(deviceProperties);
                        } else if (call.method.equals("getNetworksList")) {
                            result.success(networksList);
                        }
                    }
                });

        ScheduledExecutorService scheduler =
                Executors.newSingleThreadScheduledExecutor();

        scheduler.scheduleAtFixedRate
                (new Runnable() {
                    public void run() {
                        wifiManager.startScan();
                    }
                }, 0, 30, TimeUnit.SECONDS);
    }

    private String getDeviceInformation() {
        Map<String, String> deviceInformation = new HashMap<>();
        String supportedAbis32 = "";
        String supportedAbis64 = "";
        String supportedAbis = "";
        for (String item : Build.SUPPORTED_32_BIT_ABIS) {
            if (supportedAbis32.isEmpty()) {
                supportedAbis32 = item;
            } else {
                supportedAbis32 = supportedAbis32 + ", " + item;
            }
        }
        for (String item : Build.SUPPORTED_64_BIT_ABIS) {
            if (supportedAbis64.isEmpty()) {
                supportedAbis64 = item;
            } else {
                supportedAbis64 = supportedAbis64 + ", " + item;
            }
        }
        for (String item : Build.SUPPORTED_ABIS) {
            if (supportedAbis.isEmpty()) {
                supportedAbis = item;
            } else {
                supportedAbis = supportedAbis + ", " + item;
            }
        }
        deviceInformation.put("versionCodename", Build.VERSION.CODENAME);
        deviceInformation.put("versionIncremental", Build.VERSION.INCREMENTAL);
        deviceInformation.put("versionPreviewSdkInt", String.valueOf(Build.VERSION.PREVIEW_SDK_INT));
        deviceInformation.put("versionRelease", Build.VERSION.RELEASE);
        deviceInformation.put("versionSdkInt", String.valueOf(Build.VERSION.SDK_INT));
        deviceInformation.put("versionSecurityPatch", Build.VERSION.SECURITY_PATCH);
        deviceInformation.put("board", Build.BOARD);
        deviceInformation.put("bootloader", Build.BOOTLOADER);
        deviceInformation.put("brand", Build.BRAND);
        deviceInformation.put("device", Build.DEVICE);
        deviceInformation.put("display", Build.DISPLAY);
        deviceInformation.put("fingerprint", Build.FINGERPRINT);
        deviceInformation.put("hardware", Build.HARDWARE);
        deviceInformation.put("host", Build.HOST);
        deviceInformation.put("id", Build.ID);
        deviceInformation.put("manufacturer", Build.MANUFACTURER);
        deviceInformation.put("model", Build.MODEL);
        deviceInformation.put("product", Build.PRODUCT);
        deviceInformation.put("supportedAbis32", supportedAbis32.toString());
        deviceInformation.put("supportedAbis64", supportedAbis64.toString());
        deviceInformation.put("supportedAbis", supportedAbis.toString());
        deviceInformation.put("tags", Build.TAGS);
        deviceInformation.put("time", String.valueOf(Build.TIME));
        deviceInformation.put("type", Build.TYPE);
        deviceInformation.put("user", Build.USER);
        Properties system = System.getProperties();
        for (String key : system.stringPropertyNames())
            deviceInformation.put(key, system.getProperty(key));
        return gson.toJson(deviceInformation);
    }

}