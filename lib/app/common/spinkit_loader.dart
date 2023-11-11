import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinkitLoader extends StatelessWidget {
  const SpinkitLoader({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SpinKitThreeBounce(
      color: Colors.white,
      size: media.width * 0.045,
    );
  }
}
