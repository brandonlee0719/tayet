import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../model/auction.dart';
import '../../../user_screen.dart/bid.dart';
import '../../../repository.dart/bidItem_repository.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import 'package:timeago/timeago.dart' as timeago;

class LiveScreen extends StatelessWidget {
  LiveScreen({Key? key}) : super(key: key);
  final _biddingController = Get.find<BidItemRepository>();
  final currentTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      body: Obx(() {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            child: (_biddingController.biddingItems.isEmpty)
                ? const Expanded(
                    child: Center(
                      child: Text(
                        "No Auction Available right now",
                        style: TextStyle(
                            fontSize: 16, color: AppColors.primarycolor),
                      ),
                    ),
                  )
                : GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _biddingController.biddingItems.length,
                    itemBuilder: (BuildContext context, int? index) {
                      var item = _biddingController.biddingItems[index!];

                      Auction? auction =
                          _biddingController.checkIfAuctionAvailable(item.id!);

                      return GestureDetector(
                        onTap: () {
                          _biddingController.currentItem(item);
                          pushNewScreen(
                            context,
                            screen: BidPage(
                              item: item,
                            ),
                            withNavBar:
                                true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: AnimatedContainer(
                          margin: const EdgeInsets.all(15.0),
                          clipBehavior: Clip.none,
                          // transform: Matrix4.translationValues(
                          //     (index % 2 == 0)
                          //         ? -MediaQuery.of(context).size.height * 0.1
                          //         : MediaQuery.of(context).size.height * 0.1,
                          //     0.0,
                          //     0.0),
                          decoration: BoxDecoration(
                              // shape: BoxShape.rectangle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 157, 94, 0)
                                      .withOpacity(0.6),
                                  spreadRadius: 5,
                                  blurRadius: 13,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                )
                              ],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: 0.5, color: AppColors.accentcolor)),
                          duration: const Duration(seconds: 7),
                          curve: const Interval(0.6, 0.8,
                              curve: Curves.easeInCirc),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      // width: 100.w,
                                      // height: context.height * 0.4,
                                      height: 45.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        // shape: BoxShape.rectangle,
                                        color: Colors.white,
                                        image: DecorationImage(
                                          colorFilter: const ColorFilter.mode(
                                              Colors.black45, BlendMode.darken),
                                          fit: BoxFit.fill,
                                          image: CachedNetworkImageProvider(
                                              item.imageUrl!.first),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 7,
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              top: 20, left: 20, right: 10),
                                          // width: width,
                                          child: Text(item.title!,
                                              softWrap: true,
                                              overflow: TextOverflow.fade,
                                              maxLines: 3,
                                              style: GoogleFonts.tajawal()
                                                  .copyWith(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                        )),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              top: 10, right: 10),
                                          // width: width,
                                          // TODO: Format the Minimum price without decimal
                                          child: Text(
                                              "\$ ${item.mininum_price}",
                                              style:
                                                  GoogleFonts.changaTextTheme()
                                                      .titleLarge!
                                                      .copyWith(
                                                          fontSize: 22.0))),
                                      //   Text(item.title!,
                                      //       softWrap: true,
                                      //       overflow: TextOverflow.fade,
                                      //       maxLines: 3,
                                      //       style: GoogleFonts.tajawal()
                                      //           .copyWith(
                                      //               fontSize: 22.0,
                                      //               fontWeight:
                                      //                   FontWeight.bold)),
                                      // )
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          right: 20.0, left: 20.0),
                                      child: Icon(FontAwesomeIcons.signal,
                                          size: 15,
                                          color:
                                              Color.fromARGB(255, 56, 102, 4)),
                                    ),
                                    SizedBox(
                                      // width: Adaptive.w(40),
                                      child: Text(
                                        item.start_Date!.formatDate()!,
                                        style: GoogleFonts.changaTextTheme()
                                            .caption!,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          right: 20.0, left: 20.0),
                                      child: Icon(FontAwesomeIcons.hammer,
                                          size: 15, color: Colors.red),
                                    ),
                                    SizedBox(
                                      // width: Adaptive.w(40),
                                      child: Text(
                                          timeago.format(item.start_Date!,
                                              allowFromNow: true),
                                          style: GoogleFonts.changaTextTheme()
                                              .caption!),
                                    ),
                                  ],
                                ),
                                // TODO: Show category of thw auction
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     const Padding(
                                //       padding: EdgeInsets.only(
                                //           right: 20.0, left: 20.0),
                                //       child: Icon(FontAwesomeIcons.clock,
                                //           size: 15, color: Colors.grey),
                                //     ),
                                //     SizedBox(
                                //       // width: Adaptive.w(40),
                                //       child: Text(
                                //           auction!.categoryList!.first
                                //               .toString(),
                                //           style: GoogleFonts.changaTextTheme()
                                //               .caption!),
                                //     ),
                                //   ],
                                // ),
                                if (currentTime.isAfter(item.start_Date!))
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            right: 20.0, left: 20.0),
                                        child: Icon(
                                            FontAwesomeIcons.userFriends,
                                            size: 15,
                                            color: AppColors.primarycolor),
                                      ),
                                      if (auction != null)
                                        SizedBox(
                                          // width: Adaptive.w(40),
                                          child: Text(
                                              "${auction.bidder!.length} bids طقات"
                                                  .tr,
                                              style:
                                                  GoogleFonts.changaTextTheme()
                                                      .caption!),
                                        ),
                                    ],
                                  ),
                              ]),
                        ),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1 / 1.4,
                            // mainAxisExtent: 55.h,
                            crossAxisCount: 1,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 90),
                  ),
          ),
        );
      }),
    );
  }
}
