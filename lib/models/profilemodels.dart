


class ProfileModels {
  final int userid;
  final String username;
  final String userimage;
  final String useremail;
  final String userpassword;
  final String userphone;
  final String userbio;
  final String userdeof;
  final String useraddress;
  final List product;
  final String country;
  final List favorite;
  final List craft;
  final int nocount;
  final List notification;


  ProfileModels({
    required this.username,
    required this.useraddress,
    required this.userid,
    required this.userimage,
    required this.userphone,
    required this.userbio,
    required this.userdeof,
    required this.useremail,
    required this.userpassword,
    required this.product,
    required this.country,
    this.favorite =const [],
    this.craft  = const [],
    this.nocount  =  0,
    this.notification =const []
});

  ProfileModels.fromJson(Map<String,dynamic>json):
      userpassword = json["userpassword"],
      useremail = json["useremail"],
      userdeof = json["userdeof"],
      userbio = json["userbio"],
      userphone = json["userphone"],
      userimage = json["userimage"],
      username=json["username"],
      product = json["product"],
      userid = json["userid"],
      country = json["country"],
      useraddress = json["useraddress"],
  favorite =json["favorite"],
  craft = json["craft"],
        nocount =json["nocount"],
        notification = json["notification"]
  ;


  Map<String,dynamic>toMap(){
    return {
      "useraddress":useraddress,
      "userid":userid,
      "username":username,
      "userimage":userimage,
      "userbio":userbio,
      "userpassword":userpassword,
      "product":product,
      "country":country,
      "userphone":userphone,
      "userdeof":userdeof,
      "useremail":useremail,
      "favorite":favorite,
      "craft":craft,
      "notification":notification,
      "nocount":nocount
    };
  }


}