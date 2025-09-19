



import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help Center"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 10),

            _buildHelpItem(
              icon: Icons.person_add,
              title: "1. Create an Account",
              description:
              "Go to the Sign Up screen, enter your details (name, email, phone, password), and create an account to get started.",
            ),
            _buildHelpItem(
              icon: Icons.account_circle,
              title: "2. Update Your Profile",
              description:
              "After creating your account, go to the Profile section where you can update your name, profile photo, and other personal details.",
            ),
            _buildHelpItem(
              icon: Icons.add_box,
              title: "3. Add a Product",
              description:
              "To sell a product, go to 'Add Product', upload product images, enter price, location, and description, then save it.",
            ),
            _buildHelpItem(
              icon: Icons.shopping_cart,
              title: "4. Buy a Product",
              description:
              "Browse the product listings, select the one you like, view details, and click 'Buy Now' to proceed with purchase.",
            ),
            _buildHelpItem(
              icon: Icons.message,
              title: "5. Message to Owners",
              description:
              "If you have any queries about a product, you can directly message the product owner using the chat/message option.",
            ),

            const SizedBox(height: 20),
            const Divider(),

            const Text(
              "Need More Help?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: "title"),
            ),
            const SizedBox(height: 10),
            const Text(
              "If you face any issue while using the app, feel free to contact our support team.",
              style: TextStyle(fontSize: 14, height: 1.6,fontFamily: "body_c"),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.blue),
              title: const Text("Email Support",style: TextStyle(fontFamily: "body_c"),),
              subtitle: const Text("support@localmarket.com",style: TextStyle(fontFamily: "body_c",fontSize: 12,color: Colors.blue),),
              onTap: () {
                // 👉 Yahan ap email integration kar sakte ho
              },
            ),
            ListTile(
              leading: const Icon(Icons.call, color: Colors.green),
              title: const Text("Phone Support",style: TextStyle(fontFamily: "body_c"),),
              subtitle: const Text("+92 318 2586785",style: TextStyle(fontFamily: "body_c",color: Colors.blue),),
              onTap: () {
              },
            ),

            const SizedBox(height: 30),
            Center(
              child: Text(
                "We are here to help you 24/7!",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                  fontFamily: "body_c"
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Reusable Help Item widget
  Widget _buildHelpItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      color: Colors.grey.shade100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: Colors.blue),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold,fontFamily: "body_c")),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16, height: 1.5,fontFamily: "body_p"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
