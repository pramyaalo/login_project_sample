class PendingOrderModel {
  final String SlNo;
  final String OrderId;
  final String Date;
  final String username;
  final String Name;
  final String Total1;
  final String Total;
  final String PaymentMethod;
  final String ostatus;
  final String uniqueid;
  final String shipphone;
  final String shipadd1;
  final String shipadd2;
  final String shipcity;
  final String shipstate;
  final String shipzipcode;
  final String TotalQty;

  PendingOrderModel(
      {required this.SlNo,
      required this.OrderId,
      required this.Date,
      required this.username,
      required this.Name,
      required this.Total1,
      required this.Total,
      required this.PaymentMethod,
      required this.ostatus,
      required this.uniqueid,
      required this.shipphone,
      required this.shipadd1,
      required this.shipadd2,
      required this.shipcity,
      required this.shipstate,
      required this.shipzipcode,
      required this.TotalQty});

  factory PendingOrderModel.fromJson(Map<String, dynamic> json) {
    return PendingOrderModel(
      SlNo: json['SlNo'].toString(),
      OrderId: json['OrderId'].toString(),
      Date: json['Date'].toString(),
      username: json['Username'].toString(),
      Name: json['Name'].toString(),
      Total1: json['Total1'].toString(),
      Total: json['Total'].toString(),
      PaymentMethod: json['PaymentMethod'].toString(),
      ostatus: json['ostatus'].toString(),
      uniqueid: json['uniqueid'].toString(),
      shipphone: json['shipphone'].toString(),
      shipadd1: json['shipadd1'].toString(),
      shipadd2: json['shipadd2'].toString(),
      shipcity: json['shipcity'].toString(),
      shipstate: json['shipstate'].toString(),
      shipzipcode: json['shipzipcode'].toString(),
      TotalQty: json['TotalQty'].toString(),
    );
  }
}
