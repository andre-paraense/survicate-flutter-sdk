
class UserTraitsModel {

  final String userId;
  final String firstName;
  final Map<String, String> customTraits;

  UserTraitsModel({this.userId, this.firstName, this.customTraits});

  Map<String, String> toMap(){
    Map<String, String> userTraits = <String, String>{};

    if(userId != null){
      userTraits['userId'] = userId;
    }

    if(firstName != null){
      userTraits['firstName'] = firstName;
    }

    if(customTraits != null && customTraits.isNotEmpty){
      userTraits..addAll(customTraits);
    }

    return userTraits;
  }
}