import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:messageboard_app/ad_helper.dart';
import 'package:messageboard_app/screens/home.dart';
import 'package:messageboard_app/services/auth.dart';
import 'package:messageboard_app/shared/constants.dart';
import 'package:messageboard_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});
  // const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Create instant object _auth
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Text field state
  String email = '';
  String password = '';
  String error = '';

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  RewardedAd? _rewardedAd;
  bool _isrewardedAdReady = false;

@override
void initState() {

  RewardedAd.load(
  adUnitId: AdHelper.rewardedAdUnitId,
  request: AdRequest(),
  rewardedAdLoadCallback: RewardedAdLoadCallback(
    onAdLoaded: (RewardedAd ad) {
      print('$ad loaded.');
      // Keep a reference to the ad so you can show it later.
      this._rewardedAd = ad;
      setState(() {
            _isrewardedAdReady = true;
          });
    },
    onAdFailedToLoad: (LoadAdError error) {
      print('RewardedAd failed to load: $error');
    },
  )
  );
   
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;
          
          setState(() {
            _isInterstitialAdReady = true;
          });
          
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');

        },
      ),
    );

  _bannerAd = BannerAd(
    adUnitId: AdHelper.bannerAdUnitId,
    request: AdRequest(),
    size: AdSize.banner,
    listener: BannerAdListener(
      onAdLoaded: (_) {
        setState(() {
          _isBannerAdReady = true;
        });
      },
      onAdFailedToLoad: (ad, err) {
        print('Failed to load a banner ad: ${err.message}');
        _isBannerAdReady = false;
        ad.dispose();
      },
    ),
  );

  _bannerAd.load();
}

@override
void dispose() {
  _interstitialAd?.dispose();
  _bannerAd.dispose();
  super.dispose();

}

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            // White Color
            backgroundColor: Color(0xFFFFFFFF),
            appBar: AppBar(
              backgroundColor: Color(0xFF2a9d8f),
              elevation: 0.0,
              title: Text('Sign In to Group Chat'),
              actions: <Widget>[
                FlatButton.icon(
                  textColor: Color(0xFFFFFFFF),
                  onPressed: () async {
                    widget.toggleView();
                  },
                  label: Text("Register"),
                  icon: Icon(Icons.person_outlined),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                      child: Text("Sign in Anonymously",
                        style: TextStyle(color: Color(0xFFFFFFFF))),
                        color: Color(0xFF2a9d8f),
                      onPressed: () async {
                        if (_isInterstitialAdReady) {
                          _interstitialAd!.show();
                        }
                        _auth.signInAnon();
                      },
                      key: const ValueKey("signin"),
                    ),
                    if (_isBannerAdReady)
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: _bannerAd.size.width.toDouble(),
                          height: _bannerAd.size.height.toDouble(),
                          child: AdWidget(ad: _bannerAd),
                        ),
                      ),
                  ],
                ),
              ),
              
            ),
            
            
          );
  }
}
