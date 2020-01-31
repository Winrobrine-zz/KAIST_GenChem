import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gencheminkaist/constants/color.dart';
import 'package:gencheminkaist/home.dart';
import 'package:gencheminkaist/models/course.dart';
import 'package:gencheminkaist/models/genchem_theme.dart';
import 'package:gencheminkaist/pages/loading_page.dart';
import 'package:gencheminkaist/widgets/genchem.dart';

void main() => runApp(GenChemApp());

class GenChemApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "KAIST GenChem",
      theme: _buildTheme(),
      home: FutureBuilder<RemoteConfig>(
        future: _setupRemoteConfig(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done)
            return _buildGenChem(snapshot.data);
          return LoadingPage(backgroundColor: PRIMARY_COLOR);
        },
      ),
    );
  }

  GenChem _buildGenChem(RemoteConfig remoteConfig) {
    return GenChem(
      courses: (jsonDecode(remoteConfig.getString("courses")) as List)
          .map((e) => Course.fromMap(e))
          .toList(),
      genchemUrl: remoteConfig.getString("genchem_url"),
      noticeUrl: remoteConfig.getString("notice_url"),
      theme: GenChemTheme(
        primaryColor: PRIMARY_COLOR,
        secondaryColor: SECONDARY_COLOR,
      ),
      home: GenChemHome(),
    );
  }

  ThemeData _buildTheme() {
    final base = ThemeData.light();
    return base.copyWith(
      appBarTheme: base.appBarTheme.copyWith(color: PRIMARY_COLOR),
      iconTheme: base.iconTheme.copyWith(color: Colors.grey),
      primaryTextTheme: base.primaryTextTheme.copyWith(
        title: base.primaryTextTheme.title.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

Future<RemoteConfig> _setupRemoteConfig() async {
  final remoteConfig = await RemoteConfig.instance;

  try {
    if (kDebugMode)
      remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));

    remoteConfig.setDefaults(<String, dynamic>{
      "genchem_url": "http://gencheminkaist.pe.kr/",
      "notice_url": "http://gencheminkaist.pe.kr/down.htm",
      "courses": "[]"
    });
    await remoteConfig.fetch(expiration: const Duration(minutes: 15));
    await remoteConfig.activateFetched();
  } catch (exception) {
    print(exception);
  }

  return remoteConfig;
}
