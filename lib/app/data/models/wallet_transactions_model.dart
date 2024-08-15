import 'package:solvodev_mobile_structure/app/data/models/pagination_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/transaction_model.dart';

class WalletTransactionsModel {
  double? amount;
  PaginationModel<TransactionsModel>? transactions;

  WalletTransactionsModel({this.amount, this.transactions});

  WalletTransactionsModel.fromJson(Map<String, dynamic> json) {
    amount =
        json['wallet'] != null ? double.parse(json['wallet'].toString()) : 0;
    transactions = json['wallet_transactions'] != null
        ? PaginationModel.fromJson(
            json['wallet_transactions'], TransactionsModel.fromJson)
        : null;
  }
}
