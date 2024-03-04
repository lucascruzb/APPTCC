import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/app_bar_custom.dart';
import '../../../components/realm/realm_services.dart';
import 'components/image_input.dart';

class RegFotosScreen extends StatefulWidget {
  const RegFotosScreen({super.key});

  @override
  State<RegFotosScreen> createState() => _RegFotosScreenState();
}

class _RegFotosScreenState extends State<RegFotosScreen> {
  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Provider.of<RealmServices?>(context) == null
          ? Container()
          : SizedBox(height: availableHeight, child: const ImageInput()),
    );
  }
}
