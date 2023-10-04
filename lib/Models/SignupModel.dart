class SignupModel {
  String customerID;
  String firstname;
  String lastname;
  String dateOfBirth;
  String gender;
  String marital;
  String addressLine1;
  String addressLine2;
  String city;
  String state;
  String zipcode;
  String country;
  String phone;
  String email;
  String nominee;
  String relation;
  String nomineeaAge;

  SignupModel({
    required this.customerID,
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    required this.gender,
    required this.marital,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.country,
    required this.phone,
    required this.email,
    required this.nominee,
    required this.relation,
    required this.nomineeaAge,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      customerID: json['CustomerID'],
      firstname: json['Firstname'],
      lastname: json['Lastname'],
      dateOfBirth: json['DateOfBirth'],
      gender: json['Gender'],
      marital: json['Marital'],
      addressLine1: json['Address1'],
      addressLine2: json['Address2'],
      city: json['City'],
      state: json['State'],
      zipcode: json['Zip'],
      country: json['Country'],
      phone: json['Phone'].toString(),
      email: json['Email'],
      nominee: json['Nominee'],
      relation: json['Relation'],
      nomineeaAge: json['NomineeaAge'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CustomerID': customerID,
      'Firstname': firstname,
      'Lastname': lastname,
      'DateOfBirth': dateOfBirth,
      'Gender': gender,
      'Marital': marital,
      'AddressLine1': addressLine1,
      'AddressLine2': addressLine2,
      'City': city,
      'State': state,
      'Zipcode': zipcode,
      'Country': country,
      'Phone': phone,
      'Email': email,
      'Nominee': nominee,
      'Relation': relation,
      'NomineeaAge': nomineeaAge,
    };
  }
}
