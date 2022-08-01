import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_auction/model/auction.dart';
import 'package:smart_auction/utils/font_family.dart';

import '../../../repository.dart/bidItem_repository.dart';

class ClosedScreen extends StatefulWidget {
  ClosedScreen({Key? key}) : super(key: key);

  _ClosedScreenState createState() => _ClosedScreenState();
}

class _ClosedScreenState extends State<ClosedScreen> {
  final _auctionRepository = Get.find<BidItemRepository>();
  double currentIndex = 0;
  CarouselController _CarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CarouselSlider(
                  items: _auctionRepository.closedAuctionList
                      .map((e) => closeItem(e))
                      .toList(),
                  carouselController: _CarouselController,
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.5,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.9,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    // onPageChanged: callbackFunction,
                    onPageChanged: (value, xt) {
                      print("value $value");
                      currentIndex = value * 1.0;
                      setState(() {});
                    },
                    scrollDirection: Axis.horizontal,
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  child: DotsIndicator(
                dotsCount: _auctionRepository.closedAuctionList.length,
                position: currentIndex,
                decorator: DotsDecorator(
                  color: Colors.black87, // Inactive color
                  activeColor: Colors.redAccent,
                ),
                onTap: (value) {
                  _CarouselController.animateToPage(value.toInt());
                },
              ))
            ]),
      )),
    );
  }

  Widget closeItem(Auction item) {
    return Column(children: [
      // Text(
      //          "${tr('item')}",
      //   style: TextStyle(
      //       fontSize: 18,
      //       fontFamily: FontFamily.sofiaProBold,
      //       fontWeight: FontWeight.bold),
      // ),

      Expanded(
        flex: 1,
        child: Container(
          height: Get.height * 0.4,
          child: (item.imageList!.isEmpty)
              ? Image.asset(
                  'assets/images/laptop.png',
                  height: Get.height * 0.3,
                )
              : Image.network(item.imageList!.first),
        ),
      ),
      Divider(thickness: 1),
      Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('${tr('name')}: ${item.itemName}'),
              Text('${tr('rp')}: \$ ${item.retail_price}'),
              Text('${tr('mp')}: \$ ${item.mininum_price}'),
              Text('${tr('sp')}: \$ ${item.bidder!.reversed.first.amount}'),
              Text(
                  '${tr('username')}:  ${item.bidder!.reversed.first.userName}'),
              Text(
                  '${tr('country')}: ${CountryParser.parseCountryCode(item.bidder!.reversed.first.countyCode!).name}'),
            ],
          ))
    ]);
  }
}
