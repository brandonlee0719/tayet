import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_auction/repository.dart/wallet_repository.dart';
import 'package:smart_auction/user_screen.dart/dashboard/tab/closed.dart';
import 'package:smart_auction/user_screen.dart/dashboard/tab/live.dart';
import 'package:smart_auction/user_screen.dart/dashboard/tab/notification.dart';
import 'package:smart_auction/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  ScrollController? _scrollController;
  TabController? _tabController;
  final _walletRepository = Get.find<WalletRepository>();
  bool? fixedScroll;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController!.addListener(_scrollListener);
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.addListener(_smoothScrollToTop);
    fixedScroll = false;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    _scrollController!.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (fixedScroll!) {
      _scrollController!.jumpTo(0);
    }
  }

  _smoothScrollToTop() {
    _scrollController!.animateTo(
      0,
      duration: const Duration(microseconds: 300),
      curve: Curves.ease,
    );
    setState(() {
      fixedScroll = _tabController!.index == 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: AppColors.whitecolor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Container(
          padding: const EdgeInsets.only(left: 3.0, right: 2.0, top: 40.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    child: Image.asset('assets/images/tayet-logo-mono.png'),
                    width: Adaptive.w(35),
                    height: Adaptive.h(8),
                  ),
                  // Text(
                  //   tr('auctions'),
                  //   style: GoogleFonts.changaTextTheme().displayLarge!.copyWith(
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  // ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 1, color: AppColors.primarycolor)),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 15, left: 10),
                            child: Icon(
                              FontAwesomeIcons.coins,
                              size: 22,
                            ),
                          ),
                          Obx(() {
                            return Text(
                              _walletRepository.coinBalance.toStringAsFixed(2),
                              style: GoogleFonts.changaTextTheme()
                                  .caption!
                                  .copyWith(fontSize: 18),
                            );
                          })
                        ],
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 0.5, color: AppColors.accentcolor)),
                child: TabBar(
                  labelStyle: GoogleFonts.changaTextTheme().titleMedium,
                  unselectedLabelColor: AppColors.primarycolor,
                  indicator: const BoxDecoration(color: AppColors.primarycolor),
                  tabs: [
                    Tab(
                      text: tr('live'),
                      icon: const Icon(Icons.signal_cellular_alt),
                    ),
                    Tab(
                      text: tr('closed'),
                      icon: const Icon(Icons.close),
                    ),
                    Tab(
                      text: tr('remindme'),
                      icon: Icon(Icons.notifications,
                          color: _tabController!.index == 2
                              ? AppColors.whitecolor
                              : AppColors.accentcolor),
                    )
                  ],
                  controller: _tabController,
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            LiveScreen(),
            ClosedScreen(),
            NotificationScreen()
          ],
        ),
      ),
    );
  }
}
