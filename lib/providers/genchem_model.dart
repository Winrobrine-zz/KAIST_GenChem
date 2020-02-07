import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gencheminkaist/models/course.dart';

enum GenChemState {
  progress,
  done,
  error,
}

class GenChemModel extends ChangeNotifier {
  String _genchemUrl;
  String get genchemUrl => _genchemUrl;

  String _noticeUrl;
  String get noticeUrl => _noticeUrl;

  List<Course> _courses;
  List<Course> get courses => _courses;

  GenChemState _state = GenChemState.progress;
  GenChemState get state => _state;

  GenChemModel() {
    _setupRemoteConfig();
  }

  Future<void> _setupRemoteConfig() async {
    final remoteConfig = await RemoteConfig.instance;

    try {
      if (kDebugMode)
        remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));

      remoteConfig.setDefaults({
        "genchem_url": "http://gencheminkaist.pe.kr/",
        "notice_url": "http://gencheminkaist.pe.kr/down.htm",
        "courses": "[]"
      });
      await remoteConfig.fetch(expiration: const Duration(minutes: 15));
      await remoteConfig.activateFetched();

      _courses = (jsonDecode(remoteConfig.getString("courses")) as List)
          .map((e) => Course.fromMap(e))
          .toList();
      _genchemUrl = remoteConfig.getString("genchem_url");
      _noticeUrl = remoteConfig.getString("notice_url");

      _state = GenChemState.done;
    } catch (exception) {
      print(exception);
      _state = GenChemState.error;
    }

    notifyListeners();
  }
}
