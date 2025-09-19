


class UpdateModels {
  final String username;
  final String userphone;
  final String userbio;
  final String useraddress;
  final String country;

  UpdateModels({
    required this.country,
    required this.userbio,
    required this.userphone,
    required this.username,
    required this.useraddress
});

  UpdateModels.fromJson(Map<String,dynamic>json):
      username = json["username"],
  country=json["country"],
  useraddress = json["useraddress"],
  userbio  = json["userbio"],
  userphone = json["userphone"];

  Map<String,dynamic>toMap(){
    return {
      "userbio":userbio,
      "username":username,
      "useraddress":useraddress,
      "userphone":userphone,
      "country":country
    };
  }

}