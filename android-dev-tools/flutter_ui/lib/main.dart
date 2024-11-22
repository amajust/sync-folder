import 'package:flutter/material.dart';
import 'dart:js' as js;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Android SDK Manager'),
        ),
        body: const SDKManagerUI(),
      ),
    );
  }
}

class SDKManagerUI extends StatefulWidget {
  const SDKManagerUI({super.key});

  @override
  SDKManagerUIState createState() => SDKManagerUIState();
}

class SDKManagerUIState extends State<SDKManagerUI> {
  String status = "Click to download Android SDK";



void downloadSdk() {
  setState(() {
    status = "Downloading...";
  });

  // Call Tauri backend via the JavaScript bridge
  js.context.callMethod('invoke', ['download_sdk']).then((result) {
    setState(() {
      status = result;
    });
  }).catchError((error) {
    setState(() {
      status = "Error: $error";
    });
  });
}


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(status),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: downloadSdk,
            child: const Text('Download SDK'),
          ),
        ],
      ),
    );
  }
}

