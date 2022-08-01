import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../base/app_lib.dart';
import '../../base/view/scaffold_layout.dart';
import '../color/login_color.dart';

class T3LoginScreen extends StatefulWidget {
  final String page;

  const T3LoginScreen(this.page, {Key? key}) : super(key: key);

  @override
  _T3LoginScreenState createState() => _T3LoginScreenState();
}

class _T3LoginScreenState extends State<T3LoginScreen>
    with BaseLayout, TickerProviderStateMixin {
  FocusNode emailNode = FocusNode();
  FocusNode confirmEmailNode = FocusNode();
  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmEmailController = TextEditingController();
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isShowPassword = false;

  @override
  void initState() {
    super.initState();
    emailNode.addListener(() {
      if (mounted) setState(() {});
    });
    confirmEmailNode.addListener(() {
      if (mounted) setState(() {});
    });
    firstNameNode.addListener(() {
      if (mounted) setState(() {});
    });
    lastNameNode.addListener(() {
      if (mounted) setState(() {});
    });
    passwordNode.addListener(() {
      if (mounted) setState(() {});
    });
    emailController.addListener(() {
      if (mounted) setState(() {});
    });
    confirmEmailController.addListener(() {
      if (mounted) setState(() {});
    });
    firstController.addListener(() {
      if (mounted) setState(() {});
    });
    lastController.addListener(() {
      if (mounted) setState(() {});
    });
    passwordController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    confirmEmailController.dispose();
    firstController.dispose();
    lastController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    confirmEmailNode.dispose();
    firstNameNode.dispose();
    lastNameNode.dispose();
    passwordNode.dispose();
  }

  Widget getTextField(String hintKey, FocusNode node,
      {TextEditingController? controller}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.purple[50],
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(5.0))),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
                focusNode: node,
                autofocus: false,
                controller: controller,
                obscureText: hintKey == LanguageKey.password && !isShowPassword,
                style: const TextStyle(fontSize: 16.0, color: Colors.purple),
                decoration: InputDecoration(
                  filled: false,
                  hintText: getStringValue(hintKey, context),
                  hintStyle: TextStyle(fontSize: 16, color: ColorKey.darkGrey),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.only(bottom: 4.0, top: 4.0, left: 8),
                )),
          ),
          hintKey == LanguageKey.password
              ? InkWell(
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    }
                  },
                  child: InkWell(
                    onTap: () {
                      AlertDialogUtilities.showPressedMessage(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child:
                          Icon(Icons.remove_red_eye, color: ColorKey.darkGrey),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget getBuildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              removeTop: true,
              child: ListView(
                children: <Widget>[
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Text(
                      getStringValue(LanguageKey.uFlutter, context),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Text(
                      getStringValue(LanguageKey.prototypeShopping, context),
                      style:
                          TextStyle(fontSize: 12, color: Colors.accents[400]),
                    ),
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: getTextField(
                            LanguageKey.firstName, firstNameNode,
                            controller: firstController),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: getTextField(LanguageKey.lastName, lastNameNode,
                            controller: lastController),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  getTextField(LanguageKey.emailAddress, emailNode,
                      controller: emailController),
                  const SizedBox(
                    height: 16,
                  ),
                  getTextField(LanguageKey.confirmEmail, confirmEmailNode,
                      controller: confirmEmailController),
                  const SizedBox(
                    height: 16,
                  ),
                  getTextField(LanguageKey.password, passwordNode,
                      controller: passwordController),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          ButtonTheme(
              minWidth: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  AlertDialogUtilities.showPressedMessage(context);
                },
                // color: ColorKey.c35,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    getStringValue(LanguageKey.register, context).toUpperCase(),
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              )),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Container()),
              const Expanded(
                  child: DashSeperator(
                color: Colors.black,
              )),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: ColorKey.c37),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(40.0))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16, top: 4, bottom: 4),
                  child: Text(
                    getStringValue(LanguageKey.useSocial, context)
                        .toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.cyan,
                    ),
                  ),
                ),
                // Expanded(
                //     child: DashSeperator(
                //   color: LoginSixColor().titleColor,
                // )
              ),
              // Expanded(child: Container()),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    AlertDialogUtilities.showPressedMessage(context);
                  },
                  // color: ColorKey.c4,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8, top: 8, bottom: 8),
                    child: Row(
                      children: <Widget>[
                        const Icon(FontAwesomeIcons.facebookF,
                            color: Colors.white),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          getStringValue(LanguageKey.facebookF, context)
                              .toUpperCase(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                      ],
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
                    AlertDialogUtilities.showPressedMessage(context);
                  },
                  // color: ColorKey.c38,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8, top: 8, bottom: 8),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          FontAwesomeIcons.twitter,
                          color: Colors.white,
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          getStringValue(LanguageKey.twitterT, context)
                              .toUpperCase(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldLayout(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        showAppBar: true,
        backGroundColor: Colors.grey[200],
        leading: ScaffoldLayout.iconBackButton(context,
            buttonColor: Colors.grey[500]!),
        appBarBackgroundColor: T3LoginColor().appBarColor,
        titleColor: T3LoginColor().titleColor,
        appTitle: getStringValue(LanguageKey.createAcc, context),
        bodyData: createBuilder(getBuildBody(), widget.page));
  }
}
