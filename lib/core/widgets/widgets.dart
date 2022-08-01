import 'package:flutter/material.dart';

class HeightSpace extends StatelessWidget {
  final double? height;

  const HeightSpace([this.height]);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height ?? 10);
  }
}

class ContanierButton extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final String text;
  final VoidCallback? onTap;

  const ContanierButton({
    Key? key,
    this.color,
    this.textColor,
    this.text = 'Ok',
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
          color: color ?? Colors.grey[800],
        ),
        child: MText(
          text,
          color: textColor ?? Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}

//Medium text
class MText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  final int? maxLines;

  const MText(
    this.text, {
    Key? key,
    this.color,
    this.fontSize,
    this.textAlign,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize ?? 16,
        color: color ?? const Color(0xff111111),
      ),
      maxLines: maxLines,
    );
  }
}

class WidthSpace extends StatelessWidget {
  final double? width;
  const WidthSpace([this.width]);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 10,
    );
  }
}

class CircularContainer extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Widget child;
  final double? height;
  final double? width;
  final double? raduis;
  final VoidCallback? onTap;

  const CircularContainer({
    Key? key,
    this.padding,
    this.margin,
    required this.child,
    this.color,
    this.height,
    this.width,
    this.raduis,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: height,
        width: width,
        padding: padding ?? const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        child: Center(child: child),
      ),
      onTap: onTap,
    );
  }
}

class ErrorWithButtonWidget extends StatelessWidget {
  final VoidCallback onTryAgainPressd;
  final String? buttonText;
  final String? errorMessage;
  final Color? textAndIconColor;
  final double? iconSize;
  final IconData? iconData;

  const ErrorWithButtonWidget({
    required this.onTryAgainPressd,
    this.buttonText,
    this.errorMessage,
    this.iconSize,
    this.textAndIconColor,
    this.iconData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData ?? Icons.error_outline_rounded,
            color: textAndIconColor ?? Colors.red[700],
          ),
          const HeightSpace(),
          MText(
            errorMessage ?? 'Error Happend',
            color: textAndIconColor ?? Colors.red[700],
          ),
          const HeightSpace(),
          ElevatedButton(
            child: MText(
              buttonText ?? 'Try Again',
              color: Colors.white,
            ),
            onPressed: () {
              onTryAgainPressd();
            },
          ),
        ],
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
