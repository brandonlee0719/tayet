import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
// import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screen_utils.dart';

Widget customTitleText(String title,
    {BuildContext? context,
    Color? colors,
    TextAlign? textAlign,
    double? spacing,
    double? size,
    DecorationImage? image}) {
  return Text(
    title,
    overflow: TextOverflow.clip,
    textAlign: textAlign ?? TextAlign.start,
    style: GoogleFonts.tajawal().copyWith(
      color: colors ?? Colors.black,
      fontWeight: FontWeight.w700,
      letterSpacing: spacing ?? 1,
      fontSize: size ?? 20,
    ),
  );
}

Widget customDescriptionText(String title,
    {BuildContext? context,
    Color? colors,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? spacing,
    double? fontSize,
    Null Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Text(
      title,
      overflow: TextOverflow.clip,
      textAlign: textAlign,
      style: GoogleFonts.tajawal().copyWith(
        height: 1.5,
        color: colors ?? Colors.black54,

        fontWeight: fontWeight ?? FontWeight.normal,
        fontStyle: FontStyle.normal,
        letterSpacing: spacing ?? 0.5,
        fontSize: fontSize ?? 13,
      ),
    ),
  );
}

Widget backArrow(VoidCallback ontap, {Color? color, Color? colorIcon}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      height: 40,
      child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color ?? Colors.white,
          ),
          alignment: Alignment.center,
          child: Image.asset(
            "assets/icons/ic_back_arrow.png",
            width: 20,
            height: 20,
            color: colorIcon ?? Colors.black.withOpacity(0.2),
          )),
    ),
  );
}

Widget filterContainer(Color color) {
  return Container(
      height: getProportionateScreenHeight(40),
      width: getProportionateScreenWidth(40),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Icon(
        Icons.filter_list_rounded,
        color: Colors.white,
      )));
}

Widget userImage(String path, {double height = 100}) {
  return Container(
    child: Container(
      width: height,
      height: height,
      alignment: FractionalOffset.topCenter,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(height / 2),
        image: DecorationImage(image: NetworkImage(path)),
      ),
    ),
  );
}

Widget customIcon(
  BuildContext context, {
  int? icon,
  bool isEnable = false,
  double size = 18,
  bool istwitterIcon = true,
  bool isFontAwesomeRegular = false,
  bool isFontAwesomeSolid = false,
  Color? iconColor,
  double paddingIcon = 10,
}) {
  //iconColor = iconColor ?? Theme.of(context).textTheme.caption.color;
  return Padding(
    padding: EdgeInsets.only(bottom: istwitterIcon ? paddingIcon : 0),
    child: Icon(
      IconData(icon!,
          fontFamily: istwitterIcon
              ? 'TwitterIcon'
              : isFontAwesomeRegular
                  ? 'AwesomeRegular'
                  : isFontAwesomeSolid
                      ? 'AwesomeSolid'
                      : 'Fontello'),
      size: size,
      color: isEnable ? Theme.of(context).primaryColor : iconColor,
    ),
  );
}

Widget customTappbleIcon(BuildContext context, int icon,
    {double size = 16,
    bool isEnable = false,
    Function(bool, int)? onPressed1,
    bool? isBoolValue,
    int? id,
    Function? onPressed2,
    bool isFontAwesomeRegular = false,
    bool istwitterIcon = false,
    bool isFontAwesomeSolid = false,
    Color? iconColor,
    EdgeInsetsGeometry? padding}) {
  if (padding == null) {
    padding = EdgeInsets.all(10);
  }
  return MaterialButton(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    minWidth: 10,
    height: 10,
    padding: padding,
    shape: CircleBorder(),
    color: Colors.transparent,
    elevation: 0,
    onPressed: () {
      if (onPressed1 != null) {
        onPressed1(isBoolValue!, id!);
      } else if (onPressed2 != null) {
        onPressed2();
      }
    },
    child: customIcon(context,
        icon: icon,
        size: size,
        isEnable: isEnable,
        istwitterIcon: istwitterIcon,
        isFontAwesomeRegular: isFontAwesomeRegular,
        isFontAwesomeSolid: isFontAwesomeSolid,
        iconColor: iconColor),
  );
}

Widget customText(String msg,
    {Key? key,
    TextStyle? style,
    TextAlign textAlign = TextAlign.justify,
    TextOverflow overflow = TextOverflow.visible,
    required BuildContext context,
    bool softwrap = true}) {
  // ignore: unnecessary_null_comparison
  if (msg == null) {
    return SizedBox(
      height: 0,
      width: 0,
    );
  } else {
    // ignore: unnecessary_null_comparison
    if (context != null && style != null) {
      var fontSize =
          style.fontSize ?? Theme.of(context).textTheme.bodyText1!.fontSize;
      style = style.copyWith(
        fontSize: fontSize! - (fullWidth(context) <= 375 ? 2 : 0),
      );
    }
    return Text(
      msg,
      style: style,
      textAlign: textAlign,
      overflow: overflow,
      softWrap: softwrap,
      key: key,
    );
  }
}

double fullWidth(BuildContext context) {
  // cprint(MediaQuery.of(context).size.width.toString());
  return MediaQuery.of(context).size.width;
}

double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Widget customInkWell(
    {required Widget child,
    required BuildContext context,
    Function(bool, int)? function1,
    Function? onPressed,
    bool isEnable = false,
    int no = 0,
    Color color = Colors.transparent,
    Color? splashColor,
    BorderRadius? radius}) {
  if (splashColor == null) {
    splashColor = Theme.of(context).primaryColorLight;
  }
  if (radius == null) {
    radius = BorderRadius.circular(0);
  }
  return Material(
    color: color,
    child: InkWell(
      borderRadius: radius,
      onTap: () {
        if (function1 != null) {
          function1(isEnable, no);
        } else if (onPressed != null) {
          onPressed();
        }
      },
      splashColor: splashColor,
      child: child,
    ),
  );
}

SizedBox sizedBox({double height = 5, String? title}) {
  return SizedBox(
    height: title == null || title.isEmpty ? 0 : height,
  );
}

Widget emptyListWidget(BuildContext context, String title,
    {String? subTitle, String image = 'emptyImage.png'}) {
  return Container(
    color: Color(0xfffafafa),
    child: Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: fullWidth(context) * .95,
            height: fullWidth(context) * .95,
            decoration: BoxDecoration(
              // color: Color(0xfff1f3f6),
              boxShadow: <BoxShadow>[
                // BoxShadow(blurRadius: 50,offset: Offset(0, 0),color: Color(0xffe2e5ed),spreadRadius:20),
                BoxShadow(
                  offset: Offset(0, 0),
                  color: Color(0xffe2e5ed),
                ),
                BoxShadow(
                    blurRadius: 50,
                    offset: Offset(10, 0),
                    color: Color(0xffffffff),
                    spreadRadius: -5),
              ],
              shape: BoxShape.circle,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/$image', height: 170),
              SizedBox(
                height: 20,
              ),
              customText(
                title,
                style: Theme.of(context)
                    .typography
                    .dense
                    .headline1!
                    .copyWith(color: Color(0xff9da9c7)),
                context: context,
              ),
              customText(
                subTitle!,
                style: Theme.of(context)
                    .typography
                    .dense
                    .bodyText2!
                    .copyWith(color: Color(0xffabb8d6)),
                context: context,
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget loader() {
  if (Platform.isIOS) {
    return Center(
      child: CupertinoActivityIndicator(),
    );
  } else {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
  }
}

Widget customSwitcherWidget(
    {@required child, Duration duraton = const Duration(milliseconds: 500)}) {
  return AnimatedSwitcher(
    duration: duraton,
    transitionBuilder: (Widget child, Animation<double> animation) {
      return ScaleTransition(child: child, scale: animation);
    },
    child: child,
  );
}

Widget customExtendedText(String text, bool isExpanded,
    {required BuildContext context,
    required TextStyle style,
    Function? onPressed,
    required TickerProvider provider,
    AlignmentGeometry alignment = Alignment.topRight,
    required EdgeInsetsGeometry padding,
    int wordLimit = 100,
    bool isAnimated = true}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      AnimatedSize(
        vsync: provider,
        duration: Duration(milliseconds: (isAnimated ? 500 : 0)),
        child: ConstrainedBox(
          constraints: isExpanded
              ? BoxConstraints()
              : BoxConstraints(maxHeight: wordLimit == 100 ? 100.0 : 260.0),
          child: customText(text,
              softwrap: true,
              overflow: TextOverflow.fade,
              style: style,
              context: context,
              textAlign: TextAlign.start),
        ),
      ),
      // ignore: unnecessary_null_comparison
      text != null && text.length > wordLimit
          ? Container(
              alignment: alignment,
              child: InkWell(
                onTap: () => onPressed,
                child: Padding(
                  padding: padding,
                  child: Text(
                    !isExpanded ? 'more...' : 'Less...',
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ),
              ),
            )
          : Container()
    ],
  );
}

double getDimention(context, double unit) {
  if (fullWidth(context) <= 360.0) {
    return unit / 1.3;
  } else {
    return unit;
  }
}

Widget customListTile(
  BuildContext context, {
  Widget? title,
  required Widget subtitle,
  Widget? leading,
  Widget? trailing,
}) {
  return Container(
    width: fullWidth(context) - 80,
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: title ?? Container()),
            trailing ?? Container(),
          ],
        ),
        subtitle
      ],
    ),
  );
}

Widget customListTileOld(BuildContext context,
    {Widget? title,
    Widget? subtitle,
    Widget? leading,
    Widget? trailing,
    Function? onTap}) {
  return customInkWell(
    context: context,
    onPressed: () {
      if (onTap != null) {
        onTap();
      }
    },
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Container(
            width: 40,
            height: 40,
            child: leading,
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: fullWidth(context) - 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: title ?? Container()),
                    trailing ?? Container(),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: subtitle,
                )
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    ),
  );
}
