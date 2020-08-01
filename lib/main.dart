import 'package:baloon_sekbar/widgets/myPaint.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: UxChallenge(),
    );
  }
}

class UxChallenge extends StatefulWidget {
  @override
  _UxChallengeState createState() => _UxChallengeState();
}

class _UxChallengeState extends State<UxChallenge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BallonSlider(),
      ),
    );
  }
}

class BallonSlider extends StatefulWidget {
  @override
  _BallonSliderState createState() => _BallonSliderState();
}

class _BallonSliderState extends State<BallonSlider>
    with SingleTickerProviderStateMixin {
  double compPercent;
  double outCircleRadius;
  double inCircleRadius;
  double baloonScale;
  double position;
  int balloonNum;

  Animation<double> inCircleAnim;
  Animation<double> outCircleAnim;
  Animation<double> positionAnim;

  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("hello");

    position = -10;
    compPercent = 250;
    outCircleRadius = 15;
    inCircleRadius = 5;

    baloonScale = 1;
    controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    final Animation curve =
        CurvedAnimation(parent: controller, curve: Curves.easeIn);

    inCircleAnim = Tween<double>(begin: 5, end: 22).animate(curve)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });

    outCircleAnim = Tween<double>(begin: 15, end: 24).animate(curve)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });

      positionAnim = Tween<double>(begin: -10, end: -75).animate(curve)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    // controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double borderWidth = MediaQuery.of(context).size.width - 44;
    inCircleRadius = inCircleAnim.value;
    outCircleRadius = outCircleAnim.value;
    position = positionAnim.value;
    balloonNum = compPercent.round();

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 150),
          width: baloonScale,
          height: baloonScale,
          

          transform: Matrix4.translationValues(
              -(borderWidth / 2) + compPercent, position, 0),

          // transform: Transform.translate(offset: Offset(3,4),),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(
                "assets/balloon.png",
                fit: BoxFit.fill,
                color: Colors.orange,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "$balloonNum",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTapDown: (detdown) {
            print("ontapDown $detdown");
          },
          onPanCancel: () {},
          onPanDown: (s) {
            print("OnPanDown  $s");
            setState(() {
              if(s.localPosition.dx - outCircleRadius < borderWidth){
              compPercent = s.localPosition.dx - outCircleRadius;
              baloonScale = 75;}
            });
            controller.forward();
          },
          onPanEnd: (s) {
            print("OnPanEnd  $s");
            setState(() {
              baloonScale = 1;
            });
            controller.reverse();
          },
          onPanStart: (s) {
            print("OnPanStart  $s");
          },
          onTapUp: (t) {
            controller.reverse();
            setState(() {
              baloonScale = 1;
            });
          },
          onPanUpdate: (s) {
            print("OnPanUpdate  " + s.localPosition.dx.toString());
            setState(() {
              compPercent = s.localPosition.dx - outCircleRadius;
            });
          },
          child: Container(
            width: double.infinity,
            height: 45,
            child: CustomPaint(
                painter: MyPaint(
                    compPercent, borderWidth, outCircleRadius, inCircleRadius),
                child: Text("")),
          ),
        ),
      ],
    );
  }
}
