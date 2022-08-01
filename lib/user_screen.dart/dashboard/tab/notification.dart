import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_auction/utils/constants.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../model/auction.dart';
import '../../../repository.dart/bidItem_repository.dart';
import '../../../utils/colors.dart';
import '../../../utils/font_family.dart';
import '../../bid.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);
  final _biddingController = Get.find<BidItemRepository>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      body: Obx(() {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: (_biddingController.myBids.isEmpty)
                ? const Expanded(
                    child: Center(
                      child: Text(
                        "You don\'t any active bid ",
                        style: TextStyle(
                            fontSize: 16, color: AppColors.primarycolor),
                      ),
                    ),
                  )
                : GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _biddingController.myBids.length,
                    itemBuilder: (BuildContext context, int? index) {
                      // var item = _biddingController.biddingItems[index!];
                      Auction? auction = _biddingController.myBids[index!];

                      return Visibility(
                        visible: auction == null ? true : !auction.isSold!,
                        child: GestureDetector(
                          onTap: () {
                            _biddingController.setCurrentAuction(auction);
                            pushNewScreen(
                              context,
                              screen: BidPage(
                                auction: auction,
                              ),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                          child: AnimatedContainer(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 0.5, color: AppColors.accentcolor)),
                            duration: const Duration(seconds: 5),
                            curve: const Interval(0.6, 0.8,
                                curve: Curves.easeInCirc),
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  decoration: const BoxDecoration(
                                    color: AppColors.accentcolor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Icon(FontAwesomeIcons.signal,
                                              size: 15,
                                              color: Colors.lightGreenAccent),
                                        ),
                                        Text(
                                          auction.startingTime!.formatDate()!,
                                          style: TextStyle(
                                              color: AppColors.whitecolor,
                                              fontSize: 15,
                                              fontFamily: GoogleFonts.tajawal()
                                                  .fontFamily),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 30,
                                    right: 10,
                                    child: Container(
                                      // width: MediaQuery.of(context).size.width*0.06,
                                      // height: MediaQuery.of(context).size.height*0.06,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 5),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        color: AppColors.orangecolor,
                                      ),
                                      child: Center(
                                          child: Text(
                                        "\$${auction.mininum_price}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    )),
                                Positioned(
                                    top: Adaptive.h(10),
                                    left: Adaptive.w(4),
                                    child: Container(
                                      width: Adaptive.w(75),
                                      height: Adaptive.h(25),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              auction.imageList!.isEmpty
                                                  ? ""
                                                  : auction.imageList!.first),
                                        ),
                                      ),
                                    )),
                                // Positioned(
                                //   top: (Responsive.isMobile(context))
                                //       ? MediaQuery.of(context).size.height * 0.06
                                //       : MediaQuery.of(context).size.height * 0.06,
                                //   left: (Responsive.isMobile(context))
                                //       ? MediaQuery.of(context).size.height * 0.04
                                //       : MediaQuery.of(context).size.width * 0.09,
                                //   child: Center(
                                //     child: Container(
                                //       height: (Responsive.isMobile(context))
                                //           ? MediaQuery.of(context).size.height * 0.1
                                //           : MediaQuery.of(context).size.height * 0.25,
                                //       width: (Responsive.isMobile(context))
                                //           ? (MediaQuery.of(context).size.width / 3) -
                                //               50
                                //           : (MediaQuery.of(context).size.width / 3 -
                                //               50),
                                //       child: (item.productImages!.isEmpty)
                                //           ? Image.asset("assets/images/laptop.png",
                                //               fit: BoxFit.cover)
                                //           : Image.network(item.productImages!.first,
                                //               fit: BoxFit.cover),
                                //     ),
                                //   ),
                                // ),
                                Positioned(
                                    bottom: Adaptive.h(7),
                                    right: 3.0,
                                    child: Text(
                                        timeago.format(auction.startingTime!,
                                            allowFromNow: true),
                                        style: GoogleFonts.tajawal()
                                            .copyWith(fontSize: 12))),
                                Positioned(
                                  bottom: Adaptive.h(10),
                                  left: 3.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // TODO: Auto expandable box for the text
                                      FittedBox(
                                        alignment: Alignment.center,
                                        fit: BoxFit.scaleDown,
                                        child: Text(auction.itemName!,
                                            softWrap: true,
                                            overflow: TextOverflow.fade,
                                            maxLines: 3,
                                            style: GoogleFonts.tajawal()
                                                .copyWith(
                                                    fontSize: Adaptive.sp(22.0),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            // childAspectRatio: 1 / 1.5,
                            mainAxisExtent: 420,
                            crossAxisCount: 1,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 70),
                  ),
          ),
        );
      }),
    );
  }
}
