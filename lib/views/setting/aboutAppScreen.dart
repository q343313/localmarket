


import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About This App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            // 🔹 App Logo
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue.shade100,
                backgroundImage: AssetImage("assets/images/ec.png"),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 App Name
            const Center(
              child: Text(
                "Local Market",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,fontFamily: "title"),
              ),
            ),
            const SizedBox(height: 6),
            const Center(
              child: Text(
                "Your neighborhood shopping app",
                style: TextStyle(fontSize: 14, color: Colors.grey,fontFamily: "body_c"),
              ),
            ),

            const SizedBox(height: 20),
            const Divider(),

            // 🔹 About Description
            const Text(
              "About Local Market",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: "title"),
            ),
            const SizedBox(height: 10),
            const Text(
              "Local Market is a simple ecommerce-style app designed for your community. "
                  "You can create an account, browse products, and connect with local sellers. "
                  "It’s like having a digital market in your pocket – shop, sell, and explore with ease.",
              style: TextStyle(fontSize: 18, height: 1.5,fontFamily: "body_p"),
            ),

            const SizedBox(height: 20),

            // 🔹 Features
            const Text(
              "Key Features",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: "body_c"),
            ),
            const SizedBox(height: 10),
            _buildFeatureItem(Icons.person, "Create your account to get started."),
            _buildFeatureItem(Icons.shopping_cart, "Browse and buy products like an ecommerce app."),
            _buildFeatureItem(Icons.store_mall_directory, "Connect with local sellers."),
            _buildFeatureItem(Icons.favorite, "Save your favorite products for later."),
            _buildFeatureItem(Icons.notifications, "Get notified about offers and updates."),

            const SizedBox(height: 20),
            const Divider(),

            // 🔹 Developer Info
            const Text(
              "Developer Info",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.code, color: Colors.blue),
              title: Text("Developed by",style: TextStyle(fontFamily: "body_c",fontSize: 15),),
              subtitle: Text("Talha Afridi",style: TextStyle(fontFamily: "body_c",fontSize: 14,color: Colors.blue),),
            ),
            const ListTile(
              leading: Icon(Icons.email, color: Colors.blue),
              title: Text("Contact",style: TextStyle(fontFamily: "body_c",fontSize: 15),),
              subtitle: Text("talhaafridishah@gmail.com",style: TextStyle(fontFamily: "body_c",fontSize: 14,color: Colors.blue),),
            ),
            const ListTile(
              leading: Icon(Icons.public, color: Colors.blue),
              title: Text("Website",style: TextStyle(fontFamily: "body_c",fontSize: 15),),
              subtitle: Text("www.localmarket.com",style: TextStyle(fontFamily: "body_c",fontSize: 14,color: Colors.blue),),
            ),

            const SizedBox(height: 30),

            // 🔹 Version
            Center(
              child: Text(
                "App Version 1.0.0",
                style: TextStyle(color: Colors.grey.shade600,fontSize: 14,fontFamily: "body_c"),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // reusable widget for features
  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 20,fontFamily: "body_p",))),
        ],
      ),
    );
  }
}
