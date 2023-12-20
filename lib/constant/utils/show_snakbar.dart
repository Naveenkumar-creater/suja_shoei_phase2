// import 'package:flutter/material.dart';

// class ErrorShow {
//   static void showSnackBar(BuildContext? context, String message) {
//     if (context != null) {
//       final snackBar = SnackBar(
//         backgroundColor: Colors.red,
//         content:
//             Center(child: Text(message, style: const TextStyle(color: Colors.black))),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }

//   }
// }

import 'package:flutter/material.dart';

class ShowError {
  static void showAlert(BuildContext? context, String message) {
    if (context != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(backgroundColor: Colors.white,
            title: const Text('Error'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}