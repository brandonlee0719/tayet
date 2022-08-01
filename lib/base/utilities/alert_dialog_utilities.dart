import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';

import '../app_lib.dart';

class AlertDialogUtilities {
  static void renameListDialog(
      BuildContext context,
      String title,
      String message,
      String negative,
      String positive,
      TextEditingController inputController,
      Function() onNagative,
      Function() onPositive) {
    if (message.isEmpty) {
      return;
    }
    Widget dialog = Container(
        width: double.infinity,
        padding: const EdgeInsets.all(28.0),
        child: Material(
            color: Colors.amberAccent,
            borderRadius: BorderRadius.circular((20)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  title.isEmpty
                      ? Container()
                      : Text(
                          title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.grey),
                        ),
                  const SizedBox(
                    height: 32,
                  ),
                  message.isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(message,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey)),
                        ),
                  TextField(
                    controller: inputController,
                    autofocus: true,
                    style: const TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                        hintText: '',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorKey.c35),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorKey.c35),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorKey.c35),
                        )),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onNagative();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              negative.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.amber),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onPositive();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              positive.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )));
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  dialog,
                ],
              ),
            ));
  }

  static void showPressedMessage(BuildContext context) {
    if (context.debugDoingBuild) {
      return;
    }
    try {
      Flushbar(
        message:
            AppLocalization.getStringsValue(context, LanguageKey.itemPressed),
        mainButton: TextButton(
          onPressed: () {},
          child: Text(
            AppLocalization.getStringsValue(context, LanguageKey.action),
            style: TextStyle(color: ColorKey.registerBox),
          ),
        ),
        duration: const Duration(seconds: 3),
      ).show(context);
    } catch (e) {
      if (kDebugMode) {
        print("Error in showSnackBar: " + e.toString());
      }
    }
  }
}
