import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key, required this.onTap}) : super(key: key);

  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      width: media.width * 1,
      height: media.height * 1,
      color: Colors.transparent.withOpacity(0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(media.width * 0.05),
            width: media.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Column(
              children: [
                Text(
                  'No Internet Connection',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.048,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Text(
                  'Please check your internet connection, try enabling wifi or try again later',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: media.width * 0.037,
                  ),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                ElevatedButton(
                  onPressed: onTap,
                  child: const Text('Ok'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
