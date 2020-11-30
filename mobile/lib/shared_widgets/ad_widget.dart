import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

import '../app_config.dart';

class AdWidget extends StatelessWidget {
  final NativeAdmobController controller;
  final double adWidth;
  final double adHeight;
  final double loadingSize;

  const AdWidget(
      {Key key,
      @required this.controller,
      @required this.adHeight,
      @required this.adWidth,
      @required this.loadingSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: adWidth,
      height: adHeight,
      child: NativeAdmob(
        adUnitID: AppConfig().adId,
        loading: Center(
          child: Container(
            width: loadingSize,
            height: loadingSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ),
        controller: controller,
        type: NativeAdmobType.full,
      ),
    );
  }
}
