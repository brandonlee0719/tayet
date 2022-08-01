import 'package:get/get.dart';
import 'package:smart_auction/features/payment/controllers/payment_controller.dart';
import 'package:smart_auction/features/payment/data/data_sources/payment_credimax_datasource.dart';
import 'package:smart_auction/features/payment/data/repositories/payment_repo_impl.dart';
import 'package:smart_auction/repository.dart/bidItem_repository.dart';
import 'package:smart_auction/repository.dart/user_repository.dart';
import 'package:smart_auction/repository.dart/wallet_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserRepository(), permanent: true);
    Get.put(BidItemRepository(), permanent: true);
    Get.put(WalletRepository(), permanent: true);
    Get.lazyPut(
      () => PaymentController(
        repository: PaymentRepositoryImpl(
          remoteDataSource: PaymentCredimaxDataSource(),
        ),
      ),
    );
  }
}
