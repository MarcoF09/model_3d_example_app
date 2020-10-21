import 'dart:io';
import 'package:flutter/material.dart';
import 'package:local_assets_server/local_assets_server.dart';
import 'package:model3dexampleapp/widgets/web_view_container.dart';

class Model3D extends StatefulWidget {
  Model3D({Key key, this.modelRoute}) : super(key: key);

  final String modelRoute;

  @override
  _Model3DState createState() => _Model3DState();
}

class _Model3DState extends State<Model3D> {
  bool isListening = false;
  String address;
  int port;

  @override
  initState() {
    // _initHtml();
    _initServer();

    super.initState();
  }

  // _initHtml() async {
    // await rootBundle.loadString('assets/template/index.html');
    // The HTMLGenerator has work in progress, the idea is to generate the html dynamically to have
    // a better usage experience
    // HtmlGenerator generator =
    //     new HtmlGenerator(template: template, url: 'model/out.glb');
    // generator.generate();
  // }

  _initServer() async {
    final server = new LocalAssetsServer(
      address: InternetAddress.loopbackIPv4,
      assetsBasePath: 'assets/template',
    );

    final address = await server.serve();

    setState(() {
      this.address = address.address;
      port = server.boundPort;
      isListening = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isListening
        ? WebViewContainer('http://$address:$port')
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
