class PaymentInvoiceModel {
  String? id;
  String? status;
  int? amount;
  int? fee;
  String? currency;
  int? refunded;
  int? captured;
  String? description;
  String? amountFormat;
  String? feeFormat;
  String? refundedFormat;
  String? capturedFormat;
  int? invoiceId;
  String? ip;
  String? callbackUrl;
  String? createdAt;
  String? updatedAt;
  Source? source;

  PaymentInvoiceModel(
      {this.id,
      this.status,
      this.amount,
      this.fee,
      this.currency,
      this.refunded,
      this.captured,
      this.description,
      this.amountFormat,
      this.feeFormat,
      this.refundedFormat,
      this.capturedFormat,
      this.invoiceId,
      this.ip,
      this.callbackUrl,
      this.createdAt,
      this.updatedAt,
      this.source});

  PaymentInvoiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    amount = json['amount'];
    fee = json['fee'];
    currency = json['currency'];
    refunded = json['refunded'];
    captured = json['captured'];

    description = json['description'];
    amountFormat = json['amount_format'];
    feeFormat = json['fee_format'];
    refundedFormat = json['refunded_format'];
    capturedFormat = json['captured_format'];
    invoiceId = json['invoice_id'];
    ip = json['ip'];
    callbackUrl = json['callback_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    source =
        json['source'] != null ? new Source.fromJson(json['source']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['amount'] = this.amount;
    data['fee'] = this.fee;
    data['currency'] = this.currency;
    data['refunded'] = this.refunded;
    data['captured'] = this.captured;

    data['description'] = this.description;
    data['amount_format'] = this.amountFormat;
    data['fee_format'] = this.feeFormat;
    data['refunded_format'] = this.refundedFormat;
    data['captured_format'] = this.capturedFormat;
    data['invoice_id'] = this.invoiceId;
    data['ip'] = this.ip;
    data['callback_url'] = this.callbackUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.source != null) {
      data['source'] = this.source!.toJson();
    }
    return data;
  }
}

class Source {
  String? type;
  String? company;
  String? name;
  String? number;
  String? gatewayId;
  Null? referenceNumber;
  Null? token;
  Null? message;
  String? transactionUrl;

  Source(
      {this.type,
      this.company,
      this.name,
      this.number,
      this.gatewayId,
      this.referenceNumber,
      this.token,
      this.message,
      this.transactionUrl});

  Source.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    company = json['company'];
    name = json['name'];
    number = json['number'];
    gatewayId = json['gateway_id'];
    referenceNumber = json['reference_number'];
    token = json['token'];
    message = json['message'];
    transactionUrl = json['transaction_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['company'] = this.company;
    data['name'] = this.name;
    data['number'] = this.number;
    data['gateway_id'] = this.gatewayId;
    data['reference_number'] = this.referenceNumber;
    data['token'] = this.token;
    data['message'] = this.message;
    data['transaction_url'] = this.transactionUrl;
    return data;
  }
}
