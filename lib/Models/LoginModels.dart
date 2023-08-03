class LoginModels {
  String UserType,
      UserTypeId,
      UserID,
      Username,
      Name,
      Password,
      TransactionPassword,
      ContactEmail,
      Mobile,
      Timein,
      Timeout,
      IsActive,
      Two,
      Photo,
      Paypal,
      Payza,
      Datecreated,
      Currency;

//<editor-fold desc="Data Methods">

  LoginModels({
    required this.UserType,
    required this.UserTypeId,
    required this.UserID,
    required this.Username,
    required this.Name,
    required this.Password,
    required this.TransactionPassword,
    required this.ContactEmail,
    required this.Mobile,
    required this.Timein,
    required this.Timeout,
    required this.IsActive,
    required this.Two,
    required this.Photo,
    required this.Paypal,
    required this.Payza,
    required this.Datecreated,
    required this.Currency,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginModels &&
          runtimeType == other.runtimeType &&
          UserType == other.UserType &&
          UserTypeId == other.UserTypeId &&
          UserID == other.UserID &&
          Username == other.Username &&
          Name == other.Name &&
          Password == other.Password &&
          TransactionPassword == other.TransactionPassword &&
          ContactEmail == other.ContactEmail &&
          Mobile == other.Mobile &&
          Timein == other.Timein &&
          Timeout == other.Timeout &&
          IsActive == other.IsActive &&
          Two == other.Two &&
          Photo == other.Photo &&
          Paypal == other.Paypal &&
          Payza == other.Payza &&
          Datecreated == other.Datecreated &&
          Currency == other.Currency);

  @override
  int get hashCode =>
      UserType.hashCode ^
      UserTypeId.hashCode ^
      UserID.hashCode ^
      Username.hashCode ^
      Name.hashCode ^
      Password.hashCode ^
      TransactionPassword.hashCode ^
      ContactEmail.hashCode ^
      Mobile.hashCode ^
      Timein.hashCode ^
      Timeout.hashCode ^
      IsActive.hashCode ^
      Two.hashCode ^
      Photo.hashCode ^
      Paypal.hashCode ^
      Payza.hashCode ^
      Datecreated.hashCode ^
      Currency.hashCode;

  @override
  String toString() {
    return 'LoginModels{' +
        ' UserType: $UserType,' +
        ' UserTypeId: $UserTypeId,' +
        ' UserID: $UserID,' +
        ' Username: $Username,' +
        ' Name: $Name,' +
        ' Password: $Password,' +
        ' TransactionPassword: $TransactionPassword,' +
        ' ContactEmail: $ContactEmail,' +
        ' Mobile: $Mobile,' +
        ' Timein: $Timein,' +
        ' Timeout: $Timeout,' +
        ' IsActive: $IsActive,' +
        ' Two: $Two,' +
        ' Photo: $Photo,' +
        ' Paypal: $Paypal,' +
        ' Payza: $Payza,' +
        ' Datecreated: $Datecreated,' +
        ' Currency: $Currency,' +
        '}';
  }

  LoginModels copyWith({
    String? UserType,
    String? UserTypeId,
    String? UserID,
    String? Username,
    String? Name,
    String? Password,
    String? TransactionPassword,
    String? ContactEmail,
    String? Mobile,
    String? Timein,
    String? Timeout,
    String? IsActive,
    String? Two,
    String? Photo,
    String? Paypal,
    String? Payza,
    String? Datecreated,
    String? Currency,
  }) {
    return LoginModels(
      UserType: UserType ?? this.UserType,
      UserTypeId: UserTypeId ?? this.UserTypeId,
      UserID: UserID ?? this.UserID,
      Username: Username ?? this.Username,
      Name: Name ?? this.Name,
      Password: Password ?? this.Password,
      TransactionPassword: TransactionPassword ?? this.TransactionPassword,
      ContactEmail: ContactEmail ?? this.ContactEmail,
      Mobile: Mobile ?? this.Mobile,
      Timein: Timein ?? this.Timein,
      Timeout: Timeout ?? this.Timeout,
      IsActive: IsActive ?? this.IsActive,
      Two: Two ?? this.Two,
      Photo: Photo ?? this.Photo,
      Paypal: Paypal ?? this.Paypal,
      Payza: Payza ?? this.Payza,
      Datecreated: Datecreated ?? this.Datecreated,
      Currency: Currency ?? this.Currency,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'UserType': this.UserType,
      'UserTypeId': this.UserTypeId,
      'UserID': this.UserID,
      'Username': this.Username,
      'Name': this.Name,
      'Password': this.Password,
      'TransactionPassword': this.TransactionPassword,
      'ContactEmail': this.ContactEmail,
      'Mobile': this.Mobile,
      'Timein': this.Timein,
      'Timeout': this.Timeout,
      'IsActive': this.IsActive,
      'Two': this.Two,
      'Photo': this.Photo,
      'Paypal': this.Paypal,
      'Payza': this.Payza,
      'Datecreated': this.Datecreated,
      'Currency': this.Currency,
    };
  }

  factory LoginModels.fromJson(Map<String, dynamic> map) {
    return LoginModels(
      UserType: map['UserType'] as String,
      UserTypeId: map['UserTypeId'].toString() as String,
      UserID: map['UserID'].toString() as String,
      Username: map['Username'] as String,
      Name: map['Name'] as String,
      Password: map['Password'] as String,
      TransactionPassword: map['TransactionPassword'] as String,
      ContactEmail: map['ContactEmail'] as String,
      Mobile: map['Mobile'] as String,
      Timein: map['Timein'] as String,
      Timeout: map['Timeout'] as String,
      IsActive: map['IsActive'].toString() as String,
      Two: map['Two'].toString() as String,
      Photo: map['Photo'] as String,
      Paypal: map['Paypal'].toString() as String,
      Payza: map['Payza'].toString() as String,
      Datecreated: map['Datecreated'] as String,
      Currency: map['Currency'] as String,
    );
  }

  factory LoginModels.fromMap(Map<String, dynamic> map) {
    return LoginModels(
      UserType: map['UserType'] as String,
      UserTypeId: map['UserTypeId'] as String,
      UserID: map['UserID'] as String,
      Username: map['Username'] as String,
      Name: map['Name'] as String,
      Password: map['Password'] as String,
      TransactionPassword: map['TransactionPassword'] as String,
      ContactEmail: map['ContactEmail'] as String,
      Mobile: map['Mobile'] as String,
      Timein: map['Timein'] as String,
      Timeout: map['Timeout'] as String,
      IsActive: map['IsActive'] as String,
      Two: map['Two'] as String,
      Photo: map['Photo'] as String,
      Paypal: map['Paypal'] as String,
      Payza: map['Payza'] as String,
      Datecreated: map['Datecreated'] as String,
      Currency: map['Currency'] as String,
    );
  }

//</editor-fold>
}
