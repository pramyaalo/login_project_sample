class LoginModel {
  final String UserType;
  final String UserTypeId;
  final String UserID;
  final String Username;
  final String Name;
  final String Password;
  final String TransactionPassword;
  final String Email;
  final String Mobile;
  final String Timein;
  final String Timeout;
  final String Status;
  final String Two;
  final String Photo;
  final String Paypal;
  final String Payza;
  final String Datecreated;
  final String Currency;

//<editor-fold desc="Data Methods">

  LoginModel({
    required this.UserType,
    required this.UserTypeId,
    required this.UserID,
    required this.Username,
    required this.Name,
    required this.Password,
    required this.TransactionPassword,
    required this.Email,
    required this.Mobile,
    required this.Timein,
    required this.Timeout,
    required this.Status,
    required this.Two,
    required this.Photo,
    required this.Paypal,
    required this.Payza,
    required this.Datecreated,
    required this.Currency,
  });

  factory LoginModel.fromJson(Map<String, dynamic> map) {
    return LoginModel(
      UserType: map['UserType'].toString(),
      UserTypeId: map['UserTypeId'].toString(),
      UserID: map['UserID'].toString(),
      Username: map['Username'].toString(),
      Name: map['Name'].toString(),
      Password: map['Password'].toString(),
      TransactionPassword: map['TransactionPassword'].toString(),
      Email: map['Email'].toString(),
      Mobile: map['Mobile'].toString(),
      Timein: map['Timein'].toString(),
      Timeout: map['Timeout'].toString(),
      Status: map['Status'].toString().toString(),
      Two: map['Two'].toString().toString(),
      Photo: map['Photo'].toString(),
      Paypal: map['Paypal'].toString().toString(),
      Payza: map['Payza'].toString().toString(),
      Datecreated: map['Datecreated'].toString(),
      Currency: map['Currency'].toString(),
    );
  }
}
