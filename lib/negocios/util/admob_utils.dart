import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';

String getApplicationId() {
  if (Platform.isAndroid) {
    return "ca-app-pub-9563446058997293~1576223510";
  } else {
    return "not-id";
  }
}

String getInstertitialAd() {
  if (Platform.isAndroid) {
    return "ca-app-pub-9563446058997293/92869071";
  } else {
    return "not-id";
  }
}

InterstitialAd getNewTripInterstitialAd() {
  return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      listener: (MobileAdEvent event) {
        print('Interstitial event $event');
      });
}

Future<void> showInterstitialAd(InterstitialAd ad) {
  ad
    ..load()
    ..show(
        anchorOffset: 0.0,
        anchorType: AnchorType.bottom,
        horizontalCenterOffset: 0.0);
}
