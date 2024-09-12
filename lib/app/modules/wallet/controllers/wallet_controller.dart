import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/data/models/wallet_transactions_model.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/wallet_provider.dart';

class WalletController extends GetxController {
  final ScrollController transactionsListScrollController = ScrollController();

  bool getTransactionsListLoading = false;
  void changeGetTransactionsLoading(bool newGetMyCarsListLoading) {
    getTransactionsListLoading = newGetMyCarsListLoading;
    update([GetBuildersIdsConstants.transactionsList]);
  }

  WalletTransactionsModel? transactionsList;
  void changeTransactionsList(WalletTransactionsModel? newData,
      {bool? refresh}) {
    if (refresh == true) {
      transactionsList = null;
    } else {
      if (transactionsList?.transactions?.data?.isNotEmpty == true) {
        transactionsList?.transactions?.data
            ?.addAll(newData?.transactions?.data ?? []);
        transactionsList?.transactions?.meta = newData?.transactions?.meta;
      } else {
        transactionsList = newData;
      }
    }
    update([GetBuildersIdsConstants.transactionsList]);
  }

  int transactionsCurrentPage = 1;
  void getTransactions() {
    WalletProvider()
        .getWalletTransactions(
      page: transactionsCurrentPage,
      onLoading: () => changeGetTransactionsLoading(true),
      onFinal: () => changeGetTransactionsLoading(false),
    )
        .then(
      (value) {
        if (value != null) {
          changeTransactionsList(value);
        }
      },
    );
  }

  void transactionsScrollEvent() {
    transactionsListScrollController.addListener(() {
      double maxScroll =
          transactionsListScrollController.position.maxScrollExtent;
      if (transactionsListScrollController.offset > maxScroll * 0.8) {
        if (!getTransactionsListLoading) {
          if (transactionsCurrentPage <
              (transactionsList?.transactions?.meta?.lastPage ?? 0)) {
            transactionsCurrentPage++;
            getTransactions();
          }
        }
      }
    });
  }

  void refreshTransactions() {
    transactionsCurrentPage = 1;
    changeTransactionsList(null, refresh: true);
    getTransactions();
  }

  @override
  void onInit() {
    getTransactions();
    super.onInit();
  }

  @override
  void onReady() {
    transactionsScrollEvent();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
