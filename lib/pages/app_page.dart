import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AppPage extends StatelessWidget {
  AppPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("APP Info"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildAppInfo(BuildContext context, PackageInfo packageInfo) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset("assets/icons/ic_launcher.png"),
        Text(
          packageInfo.appName,
          style: textTheme.title.copyWith(color: Colors.black),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            packageInfo.version,
            style: textTheme.subtitle.copyWith(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Future<PackageInfo> _getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: FutureBuilder<PackageInfo>(
            future: _getPackageInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              }
              if (snapshot.connectionState == ConnectionState.done)
                return _buildAppInfo(context, snapshot.data);
              return Center(
                child: const CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
