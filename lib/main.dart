import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: BackgroundWidget()
    );
  }
}

class BackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("test");
      },
      child: Scaffold(
        body: Container(
          child: MovingBaseWidget(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/daily_bg.png"),
              fit: BoxFit.cover
            )
          ),
        ),
      )
    );
  }
}

class MovingBaseWidget extends StatefulWidget {
  @override
  MovingBaseWidgetState createState() => MovingBaseWidgetState();
}

class MovingBaseWidgetState extends State<MovingBaseWidget>
    with TickerProviderStateMixin {

  AnimationController _controller;
  Animation _firtsAnimation;
  Animation _secondAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    
    _firtsAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));//..addListener(handler);

    _secondAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  void handler(status) {
    if (status == AnimationStatus.completed) {
      _firtsAnimation.removeStatusListener(handler);
      _controller.reset();
      _firtsAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ))
        ..addStatusListener((status) {
          // if (status == AnimationStatus.completed) {
          //   Navigator.pop(context);
          // }
        });
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    _controller.forward();
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return Container(
            child: Transform(
              transform:
              Matrix4.translationValues(_firtsAnimation.value * width, 0.0, 0.0),
              child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: FittedBox(
                    child: Image.asset("assets/images/ground.png"),
                    fit: BoxFit.fill,
                  )
                ) 
              )
            ));
      });
  }

  

  

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}