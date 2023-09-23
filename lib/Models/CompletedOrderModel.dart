class CompletedOrderModel {
  final String SlNo;
  final String OrderId;
  final String OrderDate;
  final String username;
  final String Name;
  final String Total;
  final String PaymentMethod;
  final String Ostatus;
  final String shipphone;
  final String shipadd1;
  final String shipadd2;
  final String shipcity;
  final String shipstate;
  final String shipzipcode;
  final String TotalQty;
  final String DeliveryDate;
  final String status;

  CompletedOrderModel(
      {required this.SlNo,
      required this.OrderId,
      required this.OrderDate,
      required this.username,
      required this.Name,
      required this.Total,
      required this.PaymentMethod,
      required this.Ostatus,
      required this.shipphone,
      required this.shipadd1,
      required this.shipadd2,
      required this.shipcity,
      required this.shipstate,
      required this.shipzipcode,
      required this.TotalQty,
      required this.DeliveryDate,
      required this.status});

  factory CompletedOrderModel.fromJson(Map<String, dynamic> json) {
    return CompletedOrderModel(
      SlNo: json['SlNo'].toString(),
      OrderId: json['OrderId'].toString(),
      OrderDate: json['OrderDate'].toString(),
      username: json['Username'].toString(),
      Name: json['Name'].toString(),
      Total: json['Total'].toString(),
      PaymentMethod: json['PaymentMethod'].toString(),
      Ostatus: json['Ostatus'].toString(),
      shipphone: json['shipphone'].toString(),
      shipadd1: json['shipadd1'].toString(),
      shipadd2: json['shipadd2'].toString(),
      shipcity: json['shipcity'].toString(),
      shipstate: json['shipstate'].toString(),
      shipzipcode: json['shipzipcode'].toString(),
      TotalQty: json['TotalQty'].toString(),
      DeliveryDate: json['DeliveryDate'].toString(),
      status: json['status'].toString(),
    );
  }
}
