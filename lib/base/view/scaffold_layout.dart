import '../app_lib.dart';

class ScaffoldLayout extends StatefulWidget {
  final showAppBar;
  final appTitle;
  final Widget bodyData;
  final backGroundColor;
  final appBarBackgroundColor;
  final leading;
  final List<Widget> actions;
  final automaticallyImplyLeading;
  final bottomNavigationBar;
  final bottom;
  final centetTitle;
  final floadingActionButton;
  final titleColor;
  final endDrawer;
  final scaffoldKey;
  final elevation;
  final drawer;

  ScaffoldLayout(
      {this.appTitle,
      this.scaffoldKey,
      this.titleColor = Colors.black,
      this.floadingActionButton,
      required this.bodyData,
      this.leading,
      this.bottom,
      this.centetTitle = false,
      this.backGroundColor = Colors.white,
      this.appBarBackgroundColor,
      required this.actions,
      this.endDrawer,
      this.bottomNavigationBar,
      this.showAppBar = true,
      this.automaticallyImplyLeading = true,
      this.elevation = 4.0,
      this.drawer});

  static Widget iconBackButton(BuildContext context, {Color? buttonColor}) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: buttonColor ?? ColorKey.iconBlue,
        ),
        onPressed: () {
          Navigator.maybePop(context);
        },
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      ),
    );
  }

  static Widget getAndroidAppBar(context, actions, automaticallyImplyLeading,
      leading, appBarBackgroundColor, appTitle, centetTitle,
      {elevation, titleColor = Colors.black, bottom}) {
    Widget title = appTitle is String
        ? Text(
            appTitle,
            style: TextStyle(fontWeight: FontWeight.bold, color: titleColor),
          )
        : appTitle;
    return AppBar(
        actions: actions,
        bottom: bottom,
        centerTitle: centetTitle,
        elevation: elevation,
        automaticallyImplyLeading: automaticallyImplyLeading,
        leading: automaticallyImplyLeading
            ? leading ?? ScaffoldLayout.iconBackButton(context)
            : null,
        backgroundColor: appBarBackgroundColor,
//      title: InkWell(
//          onTap: () {
//            themeListener.onThemeChanged(!Constants.isDarkTheme);
//          },
//          child: title),
        title: title);
  }

  @override
  State<StatefulWidget> createState() {
    return _ScaffoldLayoutState();
  }
}

class _ScaffoldLayoutState extends State<ScaffoldLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      endDrawer: widget.endDrawer,
      backgroundColor: widget.backGroundColor,
      floatingActionButton: widget.floadingActionButton,
      appBar: !widget.showAppBar
          ? null
          : ScaffoldLayout.getAndroidAppBar(
              context,
              widget.actions,
              widget.automaticallyImplyLeading,
              widget.leading,
              widget.appBarBackgroundColor,
              widget.appTitle,
              widget.centetTitle,
              elevation: widget.elevation,
              bottom: widget.bottom,
              titleColor: widget.titleColor) as AppBar,
      body: widget.bodyData,
      drawer: widget.drawer,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
