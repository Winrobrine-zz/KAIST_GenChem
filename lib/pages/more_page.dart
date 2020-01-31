import 'package:flutter/material.dart';
import 'package:gencheminkaist/pages/app_page.dart';
import 'package:gencheminkaist/widgets/genchem_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class MorePage extends StatelessWidget {
  MorePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        GenChemTile(
          leading: const Icon(Icons.mail),
          title: const Text("Contact"),
          onTap: () => launch(
              "mailto:ghwhsbsb@kaist.ac.kr?subject=[KAIST GenChem Contact] "),
        ),
        GenChemTile(
          leading: const Icon(Icons.perm_device_information),
          title: const Text("APP Info"),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => AppPage())),
        ),
      ],
    );
  }
}
