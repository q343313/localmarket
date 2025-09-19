import '../../../../allpaths.dart';
import '../../../../config/components/settingwidget.dart';

final appNotificationController = StateProvider<bool>((ref)=>true);
final emailNotificationController = StateProvider<bool>((ref)=>true);

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          builduserprofile(),
          const SizedBox(height: 20),

          // 🔹 Account Settings
          _buildSectionTitle("Account"),
          _buildSettingsTile(
            context,
            icon: Icons.lock_outline,
            title: "Change Password",
            subtitle: "Update your account password",
            onTap: ()=>buildchangepassworddialog(context),
          ),
         Consumer(builder: (context,ref,_){
           return  _buildSettingsTile(
             context,
             icon: Icons.delete,
             title: "Delete Account",
             subtitle: "delete you account permanently",
             onTap: () {
               showprofiledeletedialog("Delete", "If you want to delete your account you will delete your all data and all product detail",
                       ()=> ref.read(loginprovider.notifier).deleteaccount(), context);
             },
           );
         }),
          _buildSettingsTile(
            context,
            icon: Icons.location_on_outlined,
            title: "Address",
            subtitle: "Add or update your address",
            onTap: (){},
          ),

          const SizedBox(height: 20),

          // 🔹 Notifications
          _buildSectionTitle("Notifications"),
          buildnotificationtoggle(),
          buildemailnotificationtoggle(),

          const SizedBox(height: 20),

          // 🔹 App Preferences
          _buildSectionTitle("App Preferences"),
          _buildSettingsTile(
            context,
            icon: Icons.dark_mode_outlined,
            title: "Theme",
            subtitle: "Light / Dark mode",
            onTap: ()=>buildthemedialog(context),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.language,
            title: "Language",
            subtitle: "Change app language",
            onTap: () {
              Get.snackbar("Language",
                  "no setup for change language only available in english language",
              backgroundColor: Colors.blue);
            },
          ),

          const SizedBox(height: 20),

          // 🔹 Privacy & Security
          _buildSectionTitle("Privacy & Security"),
          _buildSettingsTile(
            context,
            icon: Icons.privacy_tip_outlined,
            title: "Privacy Policy",
            onTap: ()=>Navigator.pushNamed(context, RouteNames.privacyscreen),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.security_outlined,
            title: "Security Settings",
            onTap: ()=>Navigator.pushNamed(context, RouteNames.security),
          ),

          _buildSettingsTile(
            context,
            icon: Icons.system_security_update_good,
            title: "Terms and Condition",
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsAndConditionsPage())),
          ),

          const SizedBox(height: 20),

          // 🔹 Help & Support
          _buildSectionTitle("Help & Support"),
          _buildSettingsTile(
            context,
            icon: Icons.help_outline,
            title: "Help Center",
              onTap: ()=>Navigator.pushNamed(context, RouteNames.helpcenter),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.chat_outlined,
            title: "Contact Us",
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutDeveloperScreen())),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.info_outline,
            title: "About App",
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutAppScreen())),
          ),

          const SizedBox(height: 30),

          // 🔹 Logout Button
          Consumer(builder: (context,ref,_){
            return ElevatedButton.icon(
              onPressed: () {
                showprofiledeletedialog("Logout", "If you want to logout your account you will delete your all data and all product detail",
                        (){
                          ref.read(loginprovider.notifier).logoutuser();
                          AddUserData().deleteProfileImage();

                        }, context);
                ref.read(imageproviders.notifier).deleteimage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                minimumSize: const Size(double.infinity, 50),
              ),
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text("Logout", style: TextStyle(color: Colors.white, fontSize: 16,fontFamily: "title")),
            );
          }),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // 🔹 Reusable Section Title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey,fontFamily: "title"),
      ),
    );
  }

  // 🔹 Reusable Settings Tile
  Widget _buildSettingsTile(BuildContext context,
      {required IconData icon, required String title, String? subtitle, required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).brightness ==Brightness.dark
      ? AppColors.containerDarkMode
      :Colors.grey.shade100,
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500,fontFamily: "title")),
        subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey,fontFamily: "body_c")) : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}



 