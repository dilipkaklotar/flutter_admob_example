import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

const appId = "your admob id";
const BANNER_AD_ID = "your banner ad id";
const INTERSTITIAL_AD_ID = "your interstitial ad id";

void main() {
  FirebaseAdMob.instance.initialize(appId: appId);
  runApp(MaterialApp(
    title: 'Admob Example',
    theme: ThemeData.light(),
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    birthday: DateTime.now(),
    childDirected: false,
    designedForFamilies: false,
    gender: MobileAdGender.male,
    // or MobileAdGender.female, MobileAdGender.unknown
    testDevices: <String>[
      "CB42A5248B0BD4B8ECE61892906FD228"
    ], // Android emulators are considered test devices
  );

 static BannerAd myBanner = BannerAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: BannerAd.testAdUnitId,
    size: AdSize.smartBanner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
  );

 static InterstitialAd myInterstitial = InterstitialAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: InterstitialAd.testAdUnitId,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      if (event == MobileAdEvent.closed) {
        myInterstitial..load();
      }
    },
  );

  @override
  void initState() {
    super.initState();

    myBanner..load();
    myInterstitial..load();
  }

  @override
  Widget build(BuildContext context) {
    myBanner
      ..show(
        anchorOffset: 0.0,
        anchorType: AnchorType.bottom,
      );

    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Load'),
              onPressed: () {
                myInterstitial
                  ..show(
                    anchorType: AnchorType.bottom,
                    anchorOffset: 0.0,
                  );
              },
            )
          ],
        ),
      ),
    );
  }
}
