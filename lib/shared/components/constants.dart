/// News app Get articles
//    baseUrl: 'https://newsapi.org/',
//        url: 'v2/top-headlines',
//  'country':'eg',
//  'category':'business',
//  'apiKey':'d7a7d49d1cfa42c9a54aa645bc58cf8e',

///search News app
// https://newsapi.org/v2/everything?q=tesla&apiKey=d7a7d49d1cfa42c9a54aa645bc58cf8e

/// Font Theme Size
/// NAME         SIZE  WEIGHT  SPACING
/// headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headlineMedium    34.0  regular  0.25
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyLarge)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5
///
import 'package:flutter/material.dart';

import '../../modules/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(BuildContext context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, ShopLoginScreen());
      showBriefMsg(msg: 'sign Out');
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); //800 is the size of each chunk
  // ignore: avoid_print
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = '';
