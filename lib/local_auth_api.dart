
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi{
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometric() async{
    try {
      return _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      bool canCheckBiometrics = await _auth.canCheckBiometrics;
      List<BiometricType> availableBiometrics =
      await _auth.getAvailableBiometrics();
      print("CheckBiometrics:-  $canCheckBiometrics");
      print('Available Biometrics:- ${availableBiometrics.toString()}');
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
      return <BiometricType>[];
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometric();
    if(!isAvailable) return false;

    // try {
    //     return _auth.authenticateWithBiometrics(
    //       localizedReason: 'Scan Fingerprint To authenticate',
    //       useErrorDialogs: true,
    //       stickyAuth: true,
    //     );
    //   } on PlatformException catch (e) {
    //     print("Error :- $e");
    //     return false;
    //   }
    //   try {
        return _auth.authenticate(
            localizedReason: 'Scan your fingerprint or face to authenticate',
            useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true
        );
      // } on PlatformException catch (e) {
      //   print('Err:- $e');
      // }
  }
}