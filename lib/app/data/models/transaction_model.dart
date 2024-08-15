class TransactionsModel {
  String? paymentMethod;
  String? transactionType;
  String? transactionTypeAr;
  double? debit;
  double? credit;
  double? oldBalance;
  double? newBalance;
  String? note;
  String? noteAr;
  String? date;

  TransactionsModel(
      {this.paymentMethod,
      this.transactionType,
      this.transactionTypeAr,
      this.debit,
      this.credit,
      this.oldBalance,
      this.newBalance,
      this.note,
      this.noteAr,
      this.date});

  TransactionsModel.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    transactionType = json['transaction_type'];
    transactionTypeAr = json['transaction_type_ar'];
    debit = json['debit'] != null ? double.parse(json['debit'].toString()) : 0;
    credit =
        json['credit'] != null ? double.parse(json['credit'].toString()) : 0;
    oldBalance = json['old_balance'] != null
        ? double.parse(json['old_balance'].toString())
        : 0;
    newBalance = json['new_balance'] != null
        ? double.parse(json['new_balance'].toString())
        : 0;
    note = json['note'];
    noteAr = json['note_ar'];
    date = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method'] = this.paymentMethod;
    data['transaction_type'] = this.transactionType;
    data['transaction_type_ar'] = this.transactionTypeAr;
    data['debit'] = this.debit;
    data['credit'] = this.credit;
    data['old_balance'] = this.oldBalance;
    data['new_balance'] = this.newBalance;
    data['note'] = this.note;
    data['note_ar'] = this.noteAr;
    data['created_at'] = this.date;
    return data;
  }
}
