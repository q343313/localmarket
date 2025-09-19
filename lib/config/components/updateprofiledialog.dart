

import 'package:flutter/cupertino.dart';

import '../../allpaths.dart';

Future updateuserdialog(BuildContext context, user, WidgetRef ref) {
  final width = MediaQuery.of(context).size.width;
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController biocontroller = TextEditingController();
  String country = user["country"];

  usernamecontroller.text = user["username"];
  addresscontroller.text = user["useraddress"];
  phonecontroller.text = user["userphone"];
  biocontroller.text = user["userbio"];

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 12,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 🔹 Drag handle
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // 🔹 Title
              Text(
                "Update Profile",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: "title",
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),

              // 🔹 Username
              CustomTextfieldWidget(
                controller: usernamecontroller,
                label: "User Name",
                preffixicon: Icons.account_circle,
                onChanged: (value) =>
                    ref.read(updateproviders.notifier).addusername(value),
              ),
              const SizedBox(height: 16),

              // 🔹 Phone number
              Text("Contact Info",
                  style: TextStyle(
                      fontFamily: "title",
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary)),
              const SizedBox(height: 8),
              buildupdatephonetext(context, ref, phonecontroller, country),
              const SizedBox(height: 16),

              // 🔹 User bio
              Text("About You",
                  style: TextStyle(
                      fontFamily: "title",
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary)),
              const SizedBox(height: 8),
              CustomTextfieldWidget(
                controller: biocontroller,
                label: "User Bio",
                minlines: 2,
                lines: 3,
                preffixicon: Icons.details,
                onChanged: (value) =>
                    ref.read(updateproviders.notifier).adduserbio(value),
              ),
              const SizedBox(height: 16),

              // 🔹 Address
              Text("Address",
                  style: TextStyle(
                      fontFamily: "title",
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary)),
              const SizedBox(height: 8),
              CustomTextfieldWidget(
                controller: addresscontroller,
                minlines: 2,
                lines: 3,
                label: "Address",
                preffixicon: Icons.location_on,
                onChanged: (value) =>
                    ref.read(updateproviders.notifier).addaddress(value),
              ),
              const SizedBox(height: 24),

              // 🔹 Buttons
              buildallupdatebuttons(context, ref, user),
              const SizedBox(height: 36),
            ],
          ),
        ),
      );
    },
  );
}


Widget buildupdatephonetext(BuildContext context,WidgetRef ref,TextEditingController phonecontroller,String country){
  return  Consumer(builder: (context, ref, child) {
    final countrycode =
    ref.watch(updateproviders.select((va) => va.country));
    return PhoneTextField(
      controller: phonecontroller,
      countrycode: countrycode.isEmpty ? country : countrycode,
      callback: () {
        showCountryPicker(
          context: context,
          onSelect: (vl) {
            ref
                .read(updateproviders.notifier)
                .addcountry("${vl.flagEmoji} +${vl.phoneCode}");
          },
        );
      },
    );
  });
}

Widget buildallupdatebuttons(BuildContext context,WidgetRef ref,user){
  return Consumer(builder: (context, ref, _) {
    final updateenum =
    ref.watch(updateproviders.select((val) => val.updateEnum));
    switch (updateenum) {
      case UpdateEnum.loading:
        return const Center(
            child: CupertinoActivityIndicator(color: Colors.blue));

      case UpdateEnum.success:
      case UpdateEnum.failure:
      case UpdateEnum.initlal:
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(
                      color:
                      Theme.of(context).colorScheme.secondary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ref
                      .read(updateproviders.notifier)
                      .resetstates();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontFamily: "title",
                    fontSize: 16,
                    color:
                    Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            buildupdatebuttons(ref, context, user)
          ],
        );
    }
  });
}

Widget buildupdatebuttons(WidgetRef ref,BuildContext context,user){
  return Expanded(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
        Theme.of(context).colorScheme.primary,
        padding:
        const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
        ref
            .read(updateproviders.notifier)
            .updateuseraccont(user);
        ref.read(imageproviders.notifier).deleteimage();
      },
      child: const Text(
        "Update",
        style: TextStyle(
          fontFamily: "title",
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    ),
  );
}