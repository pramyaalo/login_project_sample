class KYCListModel {
  final String Id;
  final String customerid;
  final String firstname;
  final String lastname;
  final String phone;
  final String dob;
  final String gender;
  final String telegram;
  final String address1;
  final String address2;
  final String state;
  final String city;
  final String zip;
  final String country;
  final String passport;
  final String passportphoto;
  final String idfront;
  final String idback;
  final String nationalidphoto;
  final String driver;
  final String driverphoto;
  final String submitdate;
  final String checkdate;
  final String checkby;
  final String adminnote;
  final String submitkby;
  final String status;
  final String reject;
  final String datecreated;
  final String kycapply;

  KYCListModel(
      {required this.Id,
      required this.customerid,
      required this.firstname,
      required this.lastname,
      required this.phone,
      required this.dob,
      required this.gender,
      required this.telegram,
      required this.address1,
      required this.address2,
      required this.state,
      required this.city,
      required this.zip,
      required this.country,
      required this.passport,
      required this.passportphoto,
      required this.idfront,
      required this.idback,
      required this.nationalidphoto,
      required this.driver,
      required this.driverphoto,
      required this.submitdate,
      required this.checkdate,
      required this.checkby,
      required this.adminnote,
      required this.submitkby,
      required this.status,
      required this.reject,
      required this.datecreated,
      required this.kycapply});

  factory KYCListModel.fromJson(Map<String, dynamic> json) {
    return KYCListModel(
      Id: json['Id'].toString(),
      customerid: json['customerid'].toString(),
      firstname: json['firstname'].toString(),
      lastname: json['lastname'].toString(),
      phone: json['phone'].toString(),
      dob: json['dob'].toString(),
      gender: json['gender'].toString(),
      telegram: json['telegram'].toString(),
      address1: json['address1'].toString(),
      address2: json['address2'].toString(),
      state: json['state'].toString(),
      city: json['city'].toString(),
      zip: json['zip'].toString(),
      country: json['country'].toString(),
      passport: json['passport'].toString(),
      passportphoto: json['passportphoto'].toString(),
      idfront: json['idfront'].toString(),
      idback: json['idback'].toString(),
      nationalidphoto: json['nationalidphoto'].toString(),
      driver: json['driver'].toString(),
      driverphoto: json['driverphoto'].toString(),
      submitdate: json['submitdate'].toString(),
      checkdate: json['checkdate'].toString(),
      checkby: json['checkby'].toString(),
      adminnote: json['adminnote'].toString(),
      submitkby: json['submitkby'].toString(),
      status: json['status'].toString(),
      reject: json['reject'].toString(),
      datecreated: json['datecreated'].toString(),
      kycapply: json['kycapply'].toString(),
    );
  }
}
