class UserTraitsModel {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String organization;
  final String department;
  final String jobTitle;
  final String phone;
  final String website;
  final String addressFirstLine;
  final String addressSecondLine;
  final String city;
  final String state;
  final String zipCode;
  final String fax;
  final String annualRevenue;
  final String employees;
  final String industry;
  final Map<String, String> customTraits;

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

  Map<String, String> toMap() {
    Map<String, String> userTraits = <String, String>{};

    _insertIntoMap(userTraits, 'user_id', userId);
    _insertIntoMap(userTraits, 'first_name', firstName);
    _insertIntoMap(userTraits, 'last_name', lastName);
    _insertIntoMap(userTraits, 'email', email);
    _insertIntoMap(userTraits, 'organization', organization);
    _insertIntoMap(userTraits, 'department', department);
    _insertIntoMap(userTraits, 'job_title', jobTitle);
    _insertIntoMap(userTraits, 'phone', phone);
    _insertIntoMap(userTraits, 'website', website);
    _insertIntoMap(userTraits, 'address_one', addressFirstLine);
    _insertIntoMap(userTraits, 'address_two', addressSecondLine);
    _insertIntoMap(userTraits, 'city', city);
    _insertIntoMap(userTraits, 'state', state);
    _insertIntoMap(userTraits, 'zip', zipCode);
    _insertIntoMap(userTraits, 'fax', fax);
    _insertIntoMap(userTraits, 'annual_revenue', annualRevenue);
    _insertIntoMap(userTraits, 'employees', employees);
    _insertIntoMap(userTraits, 'industry', industry);

    if (customTraits != null && customTraits.isNotEmpty) {
      userTraits.addAll(customTraits);
    }

    return userTraits;
  }

  void _insertIntoMap(Map<String, String> map, String key, String value) {
    if (value != null) {
      map[key] = value;
    }
  }
}
