class UserTraitsModel {
  final String? userId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? organization;
  final String? department;
  final String? jobTitle;
  final String? phone;
  final String? website;
  final String? addressFirstLine;
  final String? addressSecondLine;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? fax;
  final String? annualRevenue;
  final String? employees;
  final String? industry;
  final Map<String, String>? customTraits;

  UserTraitsModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.organization,
    this.department,
    this.jobTitle,
    this.phone,
    this.website,
    this.addressFirstLine,
    this.addressSecondLine,
    this.city,
    this.state,
    this.zipCode,
    this.fax,
    this.annualRevenue,
    this.employees,
    this.industry,
    this.customTraits,
  });

  Map<String, String?> toMap() {
    Map<String, String?> userTraits = <String, String?>{};

    if (userId != null) {
      userTraits['user_id'] = userId;
    }

    if (firstName != null) {
      userTraits['first_name'] = firstName;
    }

    if (lastName != null) {
      userTraits['last_name'] = lastName;
    }

    if (email != null) {
      userTraits['email'] = email;
    }

    if (organization != null) {
      userTraits['organization'] = organization;
    }

    if (department != null) {
      userTraits['department'] = department;
    }

    if (jobTitle != null) {
      userTraits['job_title'] = jobTitle;
    }

    if (phone != null) {
      userTraits['phone'] = phone;
    }

    if (website != null) {
      userTraits['website'] = website;
    }

    if (addressFirstLine != null) {
      userTraits['address_one'] = addressFirstLine;
    }

    if (addressSecondLine != null) {
      userTraits['address_two'] = addressSecondLine;
    }

    if (city != null) {
      userTraits['city'] = city;
    }

    if (state != null) {
      userTraits['state'] = state;
    }

    if (zipCode != null) {
      userTraits['zip'] = zipCode;
    }

    if (fax != null) {
      userTraits['fax'] = fax;
    }

    if (annualRevenue != null) {
      userTraits['annual_revenue'] = annualRevenue;
    }

    if (employees != null) {
      userTraits['employees'] = employees;
    }

    if (industry != null) {
      userTraits['industry'] = industry;
    }

    if (customTraits != null && customTraits!.isNotEmpty) {
      userTraits..addAll(customTraits!);
    }

    return userTraits;
  }
}
