import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';

String getApplicationId(){
  if(Platform.isAndroid){
    return "ca-app-pub-2994316306593080~1182086820";
  }else{
    return "not-id";
  }
}
String getInstertitialAd(){
  if(Platform.isAndroid){
    return "ca-app-pub-1071729557629592/7057192049";
  }else{
    return "not-id";
  }
}

InterstitialAd getNewTripInterstitialAd(){
  return InterstitialAd(
    adUnitId: InterstitialAd.testAdUnitId,
    listener: (MobileAdEvent event){
      print('Interstitial event $event');
    }
  );
}