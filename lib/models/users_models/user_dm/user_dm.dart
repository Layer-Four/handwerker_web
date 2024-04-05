class UserDM {
  final DateTime? birthDay;
  final String? firstName;
  final String? lastName;
  final DateTime? entryDate;
  final DateTime? cancelationDate;
  final int? hourlyRate;
  final String? phoneNumber;
  final String? street;
  final String? streetNr;
  final String? zipCode;
  final String? city;
  final String? countryID;
  final String? userID;
  const UserDM({
    this.birthDay,
    this.cancelationDate,
    this.city,
    this.countryID,
    this.entryDate,
    this.firstName,
    this.hourlyRate,
    this.lastName,
    this.phoneNumber,
    this.street,
    this.streetNr,
    this.userID,
    this.zipCode,
  });
  DriverLicenceCategory getDriverLincense(int userID) =>
      UserDriverLicence.getDriverLicenseCategory();
}

class UserDriverLicence {
  const UserDriverLicence({
    this.banFrom,
    this.banTo,
    required this.driverLicenceCategoryId,
    this.issueDate,
    this.licenceCheckIntervalDays,
    required this.userDataID,
  });

  final DateTime? issueDate;
  final int? licenceCheckIntervalDays;
  final DateTime? banFrom;
  final DateTime? banTo;
  final int userDataID;
  // ? sowas wie Führerscheinklasse?
  final int driverLicenceCategoryId;
  static DriverLicenceCategory getDriverLicenseCategory({int? userDataID}) =>
      const DriverLicenceCategory(type: ' Führerscheinklasse');
  UserDM getUserData({required int userDataID}) => const UserDM();
}

class DriverLicenceCategory {
  final String type;
  const DriverLicenceCategory({required this.type});
}
