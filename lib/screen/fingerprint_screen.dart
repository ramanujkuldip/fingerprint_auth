import 'package:fingerprint_auth/local_auth_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class FingerptintScreen extends StatelessWidget {
  bool isAvailable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    final isAvail = LocalAuthApi.hasBiometric();
                    isAvail.then((value) => {
                      isAvailable = value,
                    print("isAval:- ${isAvailable}"),
                    });

                    final biometrics = LocalAuthApi.getBiometrics();
                    final hasFingerprint = biometrics.then((value) => print('Values:- $value'));
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Available Biometrics'),
                          content: Container(
                            child: text('Biometrics', isAvailable),
                          ),
                        ),
                    );
                    print("check value:- $isAvailable");
                  },
                  child: Text("Check Availabilty")),
              ElevatedButton(
                  onPressed: () async {
                    final isAuthenticated = await LocalAuthApi.authenticate();
                    if(isAuthenticated){
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Available Biometrics'),
                          content: Text("Authenticatation Done"),
                        ),);
                    }
                  },
                  child: Text("Authenticate")),
            ],
          ),
        ),
      ),
    );
  }

  text(String text,checked){
    print("check value:- $checked");
    return Container(
      child: Row(
        children: [
          checked ? Icon(Icons.check,color: Colors.green,)
              : Icon(Icons.close,color: Colors.red,),
          Text(text)
        ],
      ),
    );
  }

  // Widget _text(String text,checked) => Container(
  //       child: Row(
  //         children: [
  //           checked ? Icon(Icons.check,color: Colors.green,)
  //               : Icon(Icons.close,color: Colors.red,),
  //           Text(text)
  //         ],
  //       ),
  //     );
}
