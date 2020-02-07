import 'package:flutter/material.dart';
import 'package:gencheminkaist/constants/color.dart';
import 'package:gencheminkaist/home.dart';
import 'package:gencheminkaist/pages/loading_page.dart';
import 'package:gencheminkaist/providers/genchem_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (context) => GenChemModel(),
      child: GenChemApp(),
    ));

class GenChemApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "KAIST GenChem",
      theme: _buildTheme(),
      home: Consumer<GenChemModel>(
        builder: (context, genchemModel, _) {
          if (genchemModel.state == GenChemState.done) return GenChemHome();
          return LoadingPage(backgroundColor: PRIMARY_COLOR);
        },
      ),
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
