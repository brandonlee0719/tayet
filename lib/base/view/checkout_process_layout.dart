import '../../base/app_lib.dart';

class CheckoutProcessLayout extends StatefulWidget {
  final String first;
  final IconData firstIcon;
  final Color firstIconOrTextColor;
  final Color firstBg;

  final String second;
  final IconData secondIcon;
  final Color secondIconOrTextColor;
  final Color secondBg;

  final String third;
  final IconData thirdIcon;
  final Color thirdIconOrTextColor;
  final Color thirdBg;

  const CheckoutProcessLayout(
      this.first,
      this.firstIcon,
      this.firstIconOrTextColor,
      this.firstBg,
      this.second,
      this.secondIcon,
      this.secondIconOrTextColor,
      this.secondBg,
      this.third,
      this.thirdIcon,
      this.thirdIconOrTextColor,
      this.thirdBg,
      {Key? key})
      : super(key: key);

  @override
  _CheckoutProcessLayoutState createState() => _CheckoutProcessLayoutState(
      first,
      firstIcon,
      firstIconOrTextColor,
      firstBg,
      second,
      secondIcon,
      secondIconOrTextColor,
      secondBg,
      third,
      thirdIcon,
      thirdIconOrTextColor,
      thirdBg);
}

class _CheckoutProcessLayoutState extends State<CheckoutProcessLayout>
    with BaseLayout {
  String first;
  IconData firstIcon;
  Color firstIconOrTextColor;
  Color firstBg;

  String second;
  IconData secondIcon;
  Color secondIconOrTextColor;
  Color secondBg;

  String third;
  IconData thirdIcon;
  Color thirdIconOrTextColor;
  Color thirdBg;

  _CheckoutProcessLayoutState(
      this.first,
      this.firstIcon,
      this.firstIconOrTextColor,
      this.firstBg,
      this.second,
      this.secondIcon,
      this.secondIconOrTextColor,
      this.secondBg,
      this.third,
      this.thirdIcon,
      this.thirdIconOrTextColor,
      this.thirdBg);

  Widget getCheckoutProcess() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        checkoutItem(
            LanguageKey.shipping,
            LanguageKey.addressInput,
            widget.firstBg,
            widget.firstIconOrTextColor,
            widget.first,
            widget.firstIcon,
            0),
        checkoutItem(
            LanguageKey.payment,
            LanguageKey.financialInfo,
            widget.secondBg,
            widget.secondIconOrTextColor,
            widget.second,
            widget.secondIcon,
            1),
        checkoutItem(
            LanguageKey.review,
            LanguageKey.checkTheOrder,
            widget.thirdBg,
            widget.thirdIconOrTextColor,
            widget.third,
            widget.thirdIcon,
            2),
      ],
    );
  }

  Widget line(Color color) {
    return Expanded(
      child: Container(
        height: 2,
        color: color,
      ),
    );
  }

  Widget checkoutItem(String titleOne, String titleTwo, Color bgColor,
      Color textColor, String text, IconData iconData, int index) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 8,
        ),
        circle(bgColor, textColor, text, index, iconData),
        const SizedBox(
          height: 8,
        ),
        Text(
          getStringValue(titleOne, context),
          style:
              TextStyle(fontSize: 16, color: CheckoutProcessColor().textColor),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          getStringValue(titleTwo, context),
          style: TextStyle(fontSize: 16, color: ColorKey.anortherGrey),
        ),
      ],
    );
  }

  Widget circle(Color bgColor, Color textColor, String text, int index,
      IconData iconData) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width / 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          line(index == 0 ? Colors.transparent : ColorKey.colodSecondGrey),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 20,
            height: 20,
            decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
            child: Center(
              child: iconData != null
                  ? Icon(
                      iconData,
                      color: textColor,
                      size: 14,
                    )
                  : Text(
                      text,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: textColor),
                    ),
            ),
          ),
          line(index == 2 ? Colors.transparent : ColorKey.colodSecondGrey),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getCheckoutProcess();
  }
}
