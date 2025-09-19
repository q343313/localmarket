

import '../../allpaths.dart';

class AddUserData extends DatabaseServices{

  final collection2  = FirebaseFirestore.instance.collection("owners");

  @override
  addProduct(ProductModel productmodels)async{
    var pref =await SharedPreferences.getInstance();
    final duc = pref.getString("email");
    final usrdata = await collection2.doc(duc).get();
    var userproduct = usrdata.data()!["product"].toList();
    final newproduct = [...userproduct,productmodels.toMap()];
    await collection2.doc(duc).update({"product":newproduct});
  }

  @override
  createUserProfile(ProfileModels profilemodels)async{
    await collection2.doc(profilemodels.useremail.toString()).set(profilemodels.toMap());
  }

  @override
  deleteUserProfile()async{
    ProfileModels profileModels = ProfileModels(
        username: "",
        useraddress: "",
        userid: Random().nextInt(100000),
        userimage: "",
        userphone: "",
        userbio: "",
        userdeof: "",
        useremail: "",
        userpassword: "", product: [], country: "");
    var pref =await SharedPreferences.getInstance();
    final duc = pref.getString("email");
    await collection2.doc(duc).update(profileModels.toMap());
  }

  @override
  updateUserProfile(UpdateModels updateModles)async{
    var pref =await SharedPreferences.getInstance();
    final duc = pref.getString("email");
    await collection2.doc(duc).update(updateModles.toMap());
  }

  @override
  addProfileImage(String image)async{
    var pref =await SharedPreferences.getInstance();
    final duc = pref.getString("email");
    await collection2.doc(duc).update({"userimage":image});
  }

  @override
  seenNotification()async{
    var pref =await SharedPreferences.getInstance();
    final duc = pref.getString("email");
    await collection2.doc(duc).update({"nocount":0});
  }

  @override
  deleteNotification(String id)async{
    var pref =await SharedPreferences.getInstance();
    final duc = pref.getString("email");
    final doc = collection2.doc(duc);
    final snapshot = await doc.get();
    final craft = snapshot.data()!["notification"];
    final newnotif = craft.where((e)=>e["id"] != id).toList();
    await collection2.doc(duc).update({"notification":newnotif});
  }

  @override
  numberUnSeenNotification()async{
    var pref =await SharedPreferences.getInstance();
    final duc = pref.getString("email");
    final doc = collection2.doc(duc);
    final snapshot = await doc.get();
    final craft = snapshot.data()!["nocount"];
    print(craft);
    await collection2.doc(duc).update({"nocount": craft + 1});
  }

  @override
  addNotification(RemoteMessage message)async{
    var pref =await SharedPreferences.getInstance();
    final duc = pref.getString("email");
    final doc = collection2.doc(duc);
    final snapshot = await doc.get();
    final craft = snapshot.data()!["notification"];
    final notification = {
      "id":Random().nextInt(10000).toString(),
      "title":message.notification!.title,
      "data":jsonEncode(message.data),
      "body":message.notification!.body.toString(),
      "datetime":"${message.sentTime!.day}/${message.sentTime!.month}/${message.sentTime!.year}"
    };
    final newdata= [...craft,notification];
    await collection2.doc(duc).update({"notification":newdata});
  }

  @override
  addCraftProduct(dynamic lis)async{
    var pref =await SharedPreferences.getInstance();
    final duc = pref.getString("email");
    await collection2.doc(duc).update({"craft":lis});
  }

  @override
  addFavoriteProduct(product)async{
    var pref =await SharedPreferences.getInstance();
    final duc = pref.getString("email");
    final doc = collection2.doc(duc);
    final snapshot = await doc.get();
    final craft = snapshot.data()!["favorite"];
    final newproduct = [...craft,product];
    await collection2.doc(duc).update({"favorite":newproduct});
  }

  @override
  deleteValueCraft(value)async{
    var pref =await SharedPreferences.getInstance();
    final duc = pref.getString("email");
    final doc = collection2.doc(duc);
    final snapshot = await doc.get();
    final craft = snapshot.data()!["craft"];
    print(craft);
    final craftproduct = craft.where((e)=>e["product"]["name"] != value).toList();
    print(craftproduct);
    await collection2.doc(duc).update({"craft":craftproduct});
  }

  @override
  changeUserPassword(String password)async{
    var pref =await SharedPreferences.getInstance();
    final duc = pref.getString("email");
    final doc = collection2.doc(duc);
    await collection2.doc(duc).update({"userpassword":password});
  }

  @override
  deleteProfileImage()async{
    var pref =await SharedPreferences.getInstance();
    final duc = pref.getString("email");
    await collection2.doc(duc).update({"userimage":""});
  }

}

final docutmejt = FirebaseFirestore.instance.collection("practice");

 checkuserexists()async{
  final user = await docutmejt.doc("lis").get();
  final userdata = user.data()!["users"];
  print(userdata);
  if(userdata.contains("Wali")){
    print("Exists");
  }else{
    print("Not Exists");
  }
}

addproductinalluser()async{
  final newprodict= [
    {
      "productlocation": "Hyderabad",
      "image": ["https://images.pexels.com/photos/699122/pexels-photo-699122.jpeg?auto=compress&cs=tinysrgb&w=600"],
      "price": 45000,
      "name": "DSLR Camera",
      "company": "Canon",
      "detail": "Professional DSLR camera with 24MP lens and WiFi."
    },
    {
      "productlocation": "Karachi",
      "image": ["https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg?auto=compress&cs=tinysrgb&w=600"],
      "price": 1500,
      "name": "Power Bank",
      "company": "Anker",
      "detail": "10000mAh fast charging power bank with dual USB."
    },
    {
      "productlocation": "Lahore",
      "image": ["https://images.pexels.com/photos/2047905/pexels-photo-2047905.jpeg?auto=compress&cs=tinysrgb&w=600"],
      "price": 4000,
      "name": "Keyboard",
      "company": "Redragon",
      "detail": "Mechanical RGB keyboard for gamers."
    },
    {
      "productlocation": "Peshawar",
      "image": ["https://images.pexels.com/photos/45055/pexels-photo-45055.jpeg?auto=compress&cs=tinysrgb&w=600"],
      "price": 12000,
      "name": "Tablet",
      "company": "Lenovo",
      "detail": "Android tablet with large screen for multimedia."
    },
    {
      "productlocation": "Islamabad",
      "image": ["https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg?auto=compress&cs=tinysrgb&w=600"],
      "price": 2000,
      "name": "USB Flash Drive",
      "company": "SanDisk",
      "detail": "64GB high speed USB 3.0 flash drive."
    },
    {
      "productlocation": "Karachi",
      "image": ["https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg?auto=compress&cs=tinysrgb&w=600"],
      "price": 900,
      "name": "Memory Card",
      "company": "Kingston",
      "detail": "128GB microSD card for phones and cameras."
    },
    {
      "productlocation": "Faisalabad",
      "image": ["https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg?auto=compress&cs=tinysrgb&w=600"],
      "price": 10000,
      "name": "Fitness Tracker",
      "company": "Fitbit",
      "detail": "Track your health, heart rate, and sleep cycles."
    },
    {
      "productlocation": "Lahore",
      "image": ["https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg?auto=compress&cs=tinysrgb&w=600"],
      "price": 2200,
      "name": "Portable Fan",
      "company": "Xiaomi",
      "detail": "Rechargeable mini fan for summer use."
    },
    {
      "productlocation": "Karachi",
      "image": ["https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg?auto=compress&cs=tinysrgb&w=600"],
      "price": 600,
      "name": "Water Bottle",
      "company": "Nike",
      "detail": "Insulated stainless steel sports water bottle."
    },
    {
      "productlocation": "Islamabad",
      "image": ["https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg?auto=compress&cs=tinysrgb&w=600"],
      "price": 15000,
      "name": "Smart TV Box",
      "company": "Mi",
      "detail": "Stream 4K Netflix, YouTube, and apps on TV."
    },
    {
      "productlocation": "Karachi",
      "image": ["https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg?auto=compress&cs=tinysrgb&w=600"],
      "price": 7000,
      "name": "Microwave Oven",
      "company": "Haier",
      "detail": "20L compact microwave oven with defrost function."
    },
    {
      "productlocation": "Quetta",
      "image": ["https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg?auto=compress&cs=tinysrgb&w=600"],
      "price": 3500,
      "name": "Electric Kettle",
      "company": "Kenwood",
      "detail": "1.7L fast boil electric kettle."
    },
    {
      "productlocation": "Lahore",
      "image": ["https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg?auto=compress&cs=tinysrgb&w=600"],
      "price": 1800,
      "name": "Hair Dryer",
      "company": "Panasonic",
      "detail": "Compact hair dryer with multiple speed settings."
    }
  ];
  final collection2  = FirebaseFirestore.instance.collection("owners");
  final user = "afridijan@gmail.com";
  final usrdata = await collection2.doc(user).get();
  var userproduct = usrdata.data()!["product"].toList();
  userproduct = newprodict;
  print(userproduct);
  await collection2.doc(user).update({"product":userproduct});
}
