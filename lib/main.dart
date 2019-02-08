import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'dart:ui' as ui show Image;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyWidget();
  }
}

class MyWidget extends StatefulWidget {
  @override
  MyWidgetState createState() => new MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {
  NodeWithSize rootNode;

  @override
  void initState() {
    super.initState();
    rootNode = new NodeWithSize(const Size(1024.0, 1024.0));
  }

  @override
  Widget build(BuildContext context) {

    // ImageMap images = new ImageMap(rootBundle);
    // Sprite car = new Sprite.fromImage(carImage);

  	return new SpriteWidget(rootNode);
  }
}