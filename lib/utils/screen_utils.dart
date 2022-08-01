import 'package:flutter/material.dart';

import 'colors.dart';

class ScreenUtils {
  static MediaQueryData _mediaQueryData = MediaQueryData();
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double defaultSize = 0;
  //static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    //orientation = _mediaQueryData.orientation;
  }

  static showAlertDialog(BuildContext context, String title, String content) {
    // set up the AlertDialog
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: Theme.of(context).textTheme.subtitle1,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ),
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      insetPadding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      backgroundColor: AppColors.accentcolor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          color: AppColors.accentcolor,
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = ScreenUtils.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = ScreenUtils.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
// Positioned(
//         bottom: 70,
//        left: MediaQuery.of(context).size.width*0.45,
//         child: Row(
//           mainAxisAlignment:MainAxisAlignment.start,
//           crossAxisAlignment:CrossAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: animate,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(30)),
//                   color:AppColors.primarycolor,
//                 ),
//               height: 70,
//               width:70,
//               child:Center(
//                 child: SimpleAnimatedIcon(
//                 // startIcon, endIcon, and progress are required
//                 startIcon:bidicon,
//                 size: 40,
//                 color: Colors.white,
//                 endIcon: Icons.close,
//                 progress: _progress,
//                 // use default transition
//                 // transitions: [Transitions.rotate_cw],
//                     ),
             
//               ),
//               //  RiveAnimation.asset('assets/riveAmin/new_file.riv'),
//                 ),
//             ),
//              Container(
//                width:50,height:30,
//                    decoration:BoxDecoration(
//                      color:AppColors.primarycolor,
//                      borderRadius: BorderRadius.all(Radius.circular(20)),

//                    ),
//                   child:Center(child: Text("X4",style: TextStyle(fontSize: 14,color:Colors.white)))
//             )
//           ],
          
//         ),
//       )
//   ],
// ),