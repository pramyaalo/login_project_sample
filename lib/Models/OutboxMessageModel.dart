class OutboxMessageModel {
  final String SlNo;
  final String Sendername;
  final String Receivername;
  final String Sender;
  final String Receiver;
  final String subject;
  final String CreatedDate;
  final String reply;
  final String Message;

  OutboxMessageModel(
      {required this.SlNo,
      required this.Sendername,
      required this.Receivername,
      required this.Sender,
      required this.Receiver,
      required this.subject,
      required this.CreatedDate,
      required this.reply,
      required this.Message});

  factory OutboxMessageModel.fromJson(Map<String, dynamic> json) {
    return OutboxMessageModel(
      SlNo: json['SlNo'].toString(),
      Sendername: json['Sendername'].toString(),
      Receivername: json['Receivername'].toString(),
      Sender: json['Sender'].toString(),
      Receiver: json['Receiver'].toString(),
      subject: json['subject'].toString(),
      CreatedDate: json['CreatedDate'].toString(),
      reply: json['reply'].toString(),
      Message: json['Message'].toString(),
    );
  }
}
