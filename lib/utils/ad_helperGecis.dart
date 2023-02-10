import 'dart:io';

class AdHelperGecis {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4109178583091990/3935194785';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}

//ca-app-pub-4109178583091990/7739253597