import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BerryPayLoading extends StatefulWidget {
  final String message;

  const BerryPayLoading({Key? key, this.message = "Loading"}) : super(key: key);

  @override
  _BerryPayLoadingState createState() => _BerryPayLoadingState();
}

class _BerryPayLoadingState extends State<BerryPayLoading> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(alignment: Alignment.center, children: <Widget>[
          const SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
          Image.asset("assets/images/logo.png", width: 30)
        ]),
        const SizedBox(height: 16),
        Text(widget.message)
      ],
    ));
  }
}

class WhiteBerryPayLoading extends StatefulWidget {
  const WhiteBerryPayLoading({super.key});

  @override
  _WhiteBerryPayLoadingState createState() => _WhiteBerryPayLoadingState();
}

class _WhiteBerryPayLoadingState extends State<WhiteBerryPayLoading> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(alignment: Alignment.center, children: <Widget>[
          const SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          Image.asset("assets/images/bp_logo_white.png", width: 30)
        ]),
        const SizedBox(height: 16),
        const Text("Loading", style: TextStyle(color: Colors.white))
      ],
    ));
  }
}

Future<void> showOnScreenLoading(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100,
                width: 100,
                child: Theme(
                  data: ThemeData(
                      cupertinoOverrideTheme: const CupertinoThemeData(
                          brightness: Brightness.dark)),
                  child: const CupertinoActivityIndicator(),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class Loading {
  static Future<void> onScreen(
      {required BuildContext context, bool isDismissible = true}) {
    return showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => isDismissible,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: 90,
                      width: 90,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: Theme(
                        data: ThemeData(
                            cupertinoOverrideTheme: const CupertinoThemeData(
                                brightness: Brightness.light)),
                        child: Lottie.asset(
                          'assets/lottie/berrymuter.json',
                          animate: true,
                          repeat: true,
                          reverse: true,
                          fit: BoxFit.fill,
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
