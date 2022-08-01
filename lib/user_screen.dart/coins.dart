import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_auction/model/coins_model.dart';
import 'package:smart_auction/model/items_model.dart';
import 'package:smart_auction/repository.dart/wallet_repository.dart';
import 'package:smart_auction/user_screen.dart/paymentPage.dart';
import 'package:smart_auction/utils/colors.dart';
import 'package:smart_auction/utils/font_family.dart';

class CoinScreen extends StatelessWidget {
  CoinScreen({Key? key}) : super(key: key);
  static const String tokenizationKey = 'sandbox_8hxpnkht_kzdtzv2btm4p7s5j';
  final _walletController = Get.find<WalletRepository>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      appBar: AppBar(
        backgroundColor: AppColors.whitecolor,
        elevation: 0,
        centerTitle: true,
        title: Text('COINSPACK'.tr,
            style: GoogleFonts.changaTextTheme().titleMedium),
      ),
      body: Obx(() {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _walletController.coinList.length,
              itemBuilder: (BuildContext context, int? index) {
                var item = _walletController.coinList[index!];
                return Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0.5, color: AppColors.accentcolor)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10),
                      Expanded(
                        child: Image.network(item.image!),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              CoinsList[index].name!,
                              style: TextStyle(
                                  color: AppColors.accentcolor,
                                  fontSize: 14,
                                  fontFamily: GoogleFonts.tajawal().fontFamily),
                            ),
                            Text('\$ ' + item.price!.toString())
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          _walletController.addFundToWallet(
                              CoinsList[index].price!.toString());
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primarycolor,
                          ),
                          child: Center(
                            child: Text(
                              'buy'.tr,
                              style: TextStyle(
                                  color: AppColors.whitecolor,
                                  fontSize: 15,
                                  fontFamily: GoogleFonts.tajawal().fontFamily),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1 / 1.1,
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
            ),
          ),
        );
      }),
    );
  }
}
