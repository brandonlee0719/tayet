// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flag/flag.dart';
import 'package:flag/platform/canvas_kit_stub.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:simple_animated_icon/simple_animated_icon.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../model/auction.dart';
import '../model/items_model.dart';
import '../repository.dart/bidItem_repository.dart';
import '../repository.dart/wallet_repository.dart';
import '../user_screen.dart/profile.dart';
import '../utils/avatar.dart';
import '../utils/colors.dart' show AppColors;
import '../utils/custom_theme.dart' as customTheme;

class BidPage extends StatefulWidget {
  Items? item;
  Auction? auction;
  BidPage({Key? key, this.item, this.auction}) : super(key: key);
  _BidPageState createState() => _BidPageState();
}

class _BidPageState extends State<BidPage> with SingleTickerProviderStateMixin {
  // List<Widget> items=[featureimage(),featureimage(),featureimage(),featureimage()];
  double currentIndex = 0;
  final bidController = Get.find<BidItemRepository>();

  final double currentIndexPage = 0;
  final CarouselController? _CarouselController = CarouselController();
  bool _isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _color;
  late Animation<double> _progress;
  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0);
  final _walletController = Get.find<WalletRepository>();

  static const IconData bidicon =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250))
      ..addListener(() {
        // call `build` on animation progress
        setState(() {});
      });

    var curve = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    );

    _progress = Tween<double>(begin: 0.0, end: 1.0).animate(curve);
    _color = ColorTween(
            begin: const Color.fromARGB(255, 255, 255, 255), end: Colors.red)
        .animate(curve);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animate() async {
    if (_isOpened) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      _isOpened = !_isOpened;
    });
    if (widget.item == null) {
      // Check for auction availablility on Firestore and then adds it
      bidController.bidAvaiableAuction(widget.auction!);
    } else {
      bidController.bidAuction(widget.item!);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        // preferredSize: Size.fromHeight(70),
        title: Text(tr("auction"),
            style: GoogleFonts.changaTextTheme().bodyMedium),
        centerTitle: true,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(width: 1, color: AppColors.primarycolor)),
                  child: Row(
                    children: [
                      Text(
                        tr('coin') + ":",
                        style: GoogleFonts.changaTextTheme()
                            .bodyMedium
                            ?.copyWith(fontSize: 12.0),
                      ),
                      const SizedBox(width: 4),
                      Obx(() {
                        return Text(
                          _walletController.coinBalance.toStringAsFixed(2),
                          style: Theme.of(context).textTheme.displayMedium,
                        );
                      })
                    ],
                  )),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  pushNewScreen(
                    context,
                    screen: const ProfileScreen(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: Avatar(
                  borderWidth: 0,
                  showButton: false,
                  borderColor: AppColors.primarycolor,
                  onButtonPressed: () {
                    print("clicked on");
                  },
                  radius: 15,
                  image: const AssetImage("assets/images/user-male.png"),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      (widget.item == null)
                          ? "${widget.auction!.itemName}"
                          : "${widget.item!.title}",
                      style: GoogleFonts.changaTextTheme()
                          .bodyLarge!
                          .copyWith(fontSize: 28),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.all(5),
                                child: Text(tr('rp'),
                                    style: GoogleFonts.changaTextTheme()
                                        .titleSmall)),
                            Container(
                              width: 100,
                              height: 40,
                              decoration: const BoxDecoration(
                                  color: AppColors.primarycolor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              padding: const EdgeInsets.all(5),
                              child: Center(
                                  child: Text(
                                (widget.item == null)
                                    ? "\$${widget.auction!.retail_price}"
                                    : "\$${widget.item!.retail_price}",
                                style: const TextStyle(color: Colors.white),
                              )),
                            )
                          ],
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.all(5),
                                child: Text(tr('mp'),
                                    style: GoogleFonts.changaTextTheme()
                                        .titleSmall)),
                            Container(
                              width: 100,
                              height: 40,
                              decoration: const BoxDecoration(
                                  color: AppColors.primarycolor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              padding: const EdgeInsets.all(5),
                              child: Center(
                                  child: Text(
                                (widget.item == null)
                                    ? "\$${widget.auction!.mininum_price}"
                                    : "\$${widget.item!.mininum_price}",
                                style: const TextStyle(color: Colors.white),
                              )),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.all(5),
                                child: Text(tr("cr") + ":",
                                    style: GoogleFonts.changaTextTheme()
                                        .titleSmall)),
                            Container(
                              width: 100,
                              height: 40,
                              decoration: const BoxDecoration(
                                  color: AppColors.primarycolor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              padding: const EdgeInsets.all(5),
                              child: Obx(() {
                                Auction? auction = bidController.currentAuction;
                                return Center(
                                    child: Text(
                                  (auction == null)
                                      ? "\$ ${widget.item!.bidding_rate?.toStringAsFixed(2) ?? 0.00}"
                                      : "\$${auction.currentAuctionValue?.toStringAsFixed(2) ?? 0.00}",
                                  style: const TextStyle(color: Colors.white),
                                ));
                              }),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // main product image
                    // TODO: product image should be a list of images and should be displayed in a carousel
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.height * 0.3,
                    //   child: Image.network(
                    //     widget.item!.imageUrl ??
                    //         "https://tayet3aleeh.com/wp-content/uploads/visual-portfolio/placeholder.png",
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    // ANCHOR: Countdown timer builder for auction
                    Container(
                      width: 50.h,
                      decoration: const BoxDecoration(
                        color: AppColors.primarycolor,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 187, 67, 23),
                            Color.fromARGB(255, 218, 218, 8),
                          ],
                        ),
                      ),
                      // color: AppColors.primarycolor,
                      child: Column(
                        children: [
                          Center(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: buildCountdownDoy(
                                    widget.item!.start_Date,
                                    widget.item!.close_Date)),
                          ),
                          // SizedBox(
                          //   // height: 10,
                          //   child: Text(
                          //       "Time Now: ${DateTime.now().toString()} Timezone: ${DateTime.now().timeZoneName}",
                          //       style: GoogleFonts.changaTextTheme()
                          //           .titleSmall!
                          //           .copyWith(color: Colors.white)),
                          // ),
                          if (widget.item != null &&
                              widget.item!.start_Date!.isAfter(DateTime.now()))
                            SizedBox(
                              // height: 10,
                              child: Text(
                                  "Starting at: ${DateFormat("H:mm", "en").format(widget.item!.start_Date!)} ${widget.item!.start_Date!.timeZoneName} || ${DateFormat("H:mm", "en").format(widget.item!.start_Date!.toLocal())} BHR",
                                  style: GoogleFonts.changaTextTheme()
                                      .titleSmall!
                                      .copyWith(color: Colors.white)),
                            ),
                          if (DateTime.now()
                              .toUtc()
                              .isBefore(widget.item!.close_Date!))
                            SizedBox(
                              // height: 10,
                              child: Text(
                                  "Closing at: ${widget.item!.close_Date!.hour.toString()}:${widget.item!.close_Date!.minute.toString()} TZ: ${widget.item!.close_Date!.timeZoneName}",
                                  style: GoogleFonts.changaTextTheme()
                                      .titleSmall!
                                      .copyWith(color: Colors.white)),
                            ),
                        ],
                      ),
                    ),
                    Obx(() {
                      Auction? auction = bidController.currentAuction;

                      if (auction!.bidder == null) {
                        return Container();
                      }
                      Get.log(
                          "Time Now: ${DateTime.now().toString()} Zone: ${DateTime.now().timeZoneName} \nStartring Date: ${widget.item!.start_Date!.toString()} Zone: ${widget.item!.start_Date!.timeZoneName} \nClosing Date: ${widget.item!.close_Date!.toString()} Zone: ${widget.item!.close_Date!.timeZoneName}");
                      if (auction.bidder!.isNotEmpty) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  tr("latestbid"),
                                  style: GoogleFonts.changaTextTheme()
                                      .displayLarge!
                                      .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  height: 48.h,
                                  child: DataTable2(
                                      columnSpacing: 5.0,
                                      bottomMargin: 30.0,
                                      lmRatio: 0.2,
                                      // scrollController: _scrollController,
                                      border: const TableBorder(
                                          horizontalInside:
                                              BorderSide(width: .8)),
                                      columns: [
                                        const DataColumn(
                                          label: Icon(
                                            Icons.flag,
                                            size: 15.0,
                                          ),
                                        ),
                                        DataColumn(
                                            label: Text(
                                          tr("user"),
                                          style: GoogleFonts.changaTextTheme()
                                              .titleSmall!
                                              .copyWith(fontSize: 12.0),
                                        )),
                                        DataColumn(
                                            label: Text(tr("price"),
                                                style: GoogleFonts
                                                        .changaTextTheme()
                                                    .titleSmall!
                                                    .copyWith(fontSize: 12.0))),
                                        DataColumn(
                                            label: Text(tr("since"),
                                                style: GoogleFonts
                                                        .changaTextTheme()
                                                    .titleSmall!
                                                    .copyWith(fontSize: 12.0))),
                                      ],
                                      rows: bidController
                                          .currentAuction!.bidder!.reversed
                                          .toList()
                                          .map((e) => DataRow(cells: [
                                                DataCell(
                                                  Flag.fromString(
                                                    e.countyCode!,
                                                    height: 25,
                                                    width: 25,
                                                  ),
                                                ),
                                                DataCell(Text(e.userName!,
                                                    style: GoogleFonts
                                                            .changaTextTheme()
                                                        .titleSmall)),
                                                DataCell(Text(
                                                    "\$ ${e.amount?.toStringAsFixed(2)}")),
                                                DataCell(Text(
                                                    timeago
                                                        .format(e.createdTime!),
                                                    textScaleFactor: 0.7)),
                                              ]))
                                          .toList()),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: 20.h,
                          //  flex: 5,
                          child: Center(
                            child: Text(
                              tr("nobid"),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                            ),
                          ),
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
            // TODO: Hide Bidding button when  auction is closed
            // (DateTime.now().isAfter((widget.item == null)
            //         ? widget.auction!.closing_time!
            //         : widget.item!.close_Date!))
            //     ? Container()
            //     : bidButton(),
            // const MessageButton()
            if (DateTime.now()
                .toUtc()
                .isBefore(widget.item!.close_Date!.toUtc()))
              bidButton()
            else
              IconButton(
                icon: const Icon(Icons.construction),
                iconSize: 20.0,
                color: Colors.indigo,
                onPressed: () {
                  Get.snackbar(tr("auctionnotstarted"),
                      'إزهل شوي قاعد أشوف في وين الخلل؟',
                      icon: const Icon(FontAwesomeIcons.poop),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      borderRadius: 10,
                      margin: const EdgeInsets.all(10),
                      borderColor: Colors.red,
                      borderWidth: 1,
                      colorText: Colors.white);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget featureWidget() {
    return Column(children: [
      const SizedBox(
        height: 20,
      ),
      CarouselSlider(
          items: (widget.item == null)
              ? widget.auction!.imageList!
                  .map((e) => FeaturedImage(
                        imageUrl: e,
                      ))
                  .toList()
              : widget.item!.productImages!
                  .map((e) => FeaturedImage(
                        imageUrl: e,
                      ))
                  .toList(),
          carouselController: _CarouselController,
          options: CarouselOptions(
            height: Adaptive.h(20),
            aspectRatio: 16 / 9,
            viewportFraction: 0.9,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 15),
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            // onPageChanged: callbackFunction,
            onPageChanged: (value, xt) {
              if (kDebugMode) {
                print("value $value");
              }
              currentIndex = value * 1.0;
            },
            scrollDirection: Axis.horizontal,
          )),
      const SizedBox(
        height: 20,
      ),
      DotsIndicator(
        dotsCount: (widget.item == null)
            ? widget.auction!.imageList!.length
            : widget.item!.productImages!.length,
        position: currentIndex,
        decorator: const DotsDecorator(
          color: Colors.black87, // Inactive color
          activeColor: Colors.redAccent,
        ),
        onTap: (value) {
          _CarouselController?.animateToPage(value.toInt());
        },
      )
    ]);
  }

  Widget bidButton() {
    // FIXME: #19 When bid button is pressed it goes to X for 2 seconds then flips back
    // meanwhile the 2 seconds the user cannot bid
    return Positioned(
      bottom: 80,
      left: MediaQuery.of(context).size.width * 0.45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: animate,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: AppColors.primarycolor,
                  boxShadow: [
                    BoxShadow(color: Colors.black54, blurRadius: 20.0)
                  ]),
              height: 70,
              width: 70,
              child: Center(
                child: SimpleAnimatedIcon(
                    // startIcon, endIcon, and progress are required
                    startIcon: bidicon,
                    size: 40,
                    color: Colors.white,
                    endIcon: Icons.close,
                    progress: _progress,
                    transitions: const [Transitions.slide_in_left]

                    // use default transition
                    // transitions: [Transitions.rotate_cw],
                    ),
              ),
              //  RiveAnimation.asset('assets/riveAmin/new_file.riv'),
            ),
          ),
          Obx(() {
            Auction? auction = bidController.currentAuction;
            return (auction!.id != null && auction.bidder!.isNotEmpty)
                ? Container(
                    width: 50,
                    height: 30,
                    decoration: const BoxDecoration(
                        color: AppColors.primarycolor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(color: Colors.black54, blurRadius: 20.0)
                        ]),
                    child: Center(
                        child: Text("X${auction.bidder!.length}",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white))))
                : Container();
          })
        ],
      ),
    );
  }

  Widget messageButton() {
    return Positioned(
      bottom: 70,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: animate,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: AppColors.primarycolor,
              ),
              height: 40,
              width: 40,
              child:
                  const Center(child: Icon(Icons.message, color: Colors.white)),
              //  RiveAnimation.asset('assets/riveAmin/new_file.riv'),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildCountdownDoy(DateTime? openTime, DateTime? closeTime) {
  if (kDebugMode) {
    print("BuildCountdownDoy $openTime");
  }
  if (openTime == null) {
    return Container();
  }
  // var durationDiff = countTime!.difference(DateTime.now());
  var timeNow = DateTime.now().toUtc();
  // var durationDiff = DateTime.now().difference(countTime!);
  Duration? durationDiff;

  if (DateTime.now().toUtc().isBefore(closeTime!.toUtc())) {
    Get.log(
        "Auction OPEN 🥳 Difference is ${timeNow.difference(openTime).inSeconds}");
    durationDiff = timeNow.difference(openTime);
  } else {
    Get.log("Auction Close 💩 Diff is ${timeNow.difference(closeTime)}");
    durationDiff = timeNow.difference(closeTime);

  }
  if (durationDiff != null) {
    return SlideCountdown(duration: const Duration(seconds: 25), onDone: () {});
  }
  // ANCHOR: Main countdown timer
  return SlideCountdown(
    // key: const Key("countdown")
    onChanged: (value) => Get.log("Countdown ${durationDiff!.inSeconds}"),
    onDone: () {
      Get.snackbar(tr("auctionclosed"), "Auction Closed .. تريانه بنرجع",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
      Get.log("Auction is Done", isError: true);
    },

    slideDirection:
        (durationDiff.inSeconds > 0) ? SlideDirection.up : SlideDirection.down,
    fade: true,
    textStyle: GoogleFonts.changaTextTheme().titleSmall!.copyWith(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30.0),
    padding: const EdgeInsets.all(15.0),
    icon: const Padding(
      padding: EdgeInsets.all(8.0),
      child: Icon(FontAwesomeIcons.clock, color: Colors.white),
    ),
    decoration: BoxDecoration(
      color: (durationDiff.inSeconds > 0)
          ? const Color.fromARGB(255, 156, 49, 10)
          : Colors.green,
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
    ),
    duration: durationDiff.abs(),
  );
}

class FeaturedImage extends StatefulWidget {
  String? imageUrl;
  FeaturedImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  State<FeaturedImage> createState() => _FeaturedImageState();
}

class _FeaturedImageState extends State<FeaturedImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: Stack(children: [
        Container(
          // width: MediaQuery.of(context).size.width,
          // height: Adaptive.h(80),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(
                  image: NetworkImage(
                    widget.imageUrl!,
                  ),
                  fit: BoxFit.fitHeight)),
        ),

        // Container(
        //   decoration: BoxDecoration(
        //   borderRadius: BorderRadius.all(Radius.circular(20))

        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.only(
        //         top: 30.0, right: 10.0),
        //     child: Container(
        //       alignment: AlignmentDirectional
        //           .centerEnd,
        //       child: Stack(
        //         children: [
        //           Container(
        //             decoration: BoxDecoration(
        //              image: DecorationImage(image: AssetImage(
        //                 'assets/images/Rectangle 28.png'),fit: BoxFit.cover),
        //                 borderRadius: BorderRadius.all(Radius.circular(20),)

        //             ),

        //           ),

        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ]),
    );
  }
}
