


import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Privacy Policy",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,fontFamily: "title"),
              ),
              const SizedBox(height: 10),
              Text(
                "Welcome to Local Market! Your privacy is very important to us. "
                    "This Privacy Policy explains how we collect, use, and protect your information when you use our app.",
                style: TextStyle(fontSize: 14, height: 1.6, color: Colors.grey.shade800,fontFamily: "body_c"),
              ),
              const SizedBox(height: 20),

              _buildSection(
                title: "1. Information We Collect",
                content:
                "We collect information such as your name, email, phone number, profile details, and activity data when you use Local Market.",
              ),
              _buildSection(
                title: "2. How We Use Your Information",
                content:
                "We use your information to improve user experience, provide services, process transactions, and communicate important updates.",
              ),
              _buildSection(
                title: "3. Sharing of Information",
                content:
                "We do not sell or share your personal data with third parties, except when required by law or to provide essential services.",
              ),
              _buildSection(
                title: "4. Security",
                content:
                "We use encryption and security measures to protect your data. However, no method of transmission over the internet is 100% secure.",
              ),
              _buildSection(
                title: "5. Your Rights",
                content:
                "You have the right to update or delete your account information at any time through the app settings.",
              ),
              _buildSection(
                title: "6. Changes to Policy",
                content:
                "We may update our Privacy Policy from time to time. We will notify you of any changes by updating this page.",
              ),
              _buildSection(
                title: "7. Contact Us",
                content:
                "If you have any questions or concerns about our Privacy Policy, please contact us at support@localmarket.com.",
              ),

              const SizedBox(height: 30),
              Center(
                child: Text(
                  "Last Updated: September 2025",
                  style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade600,
                    fontFamily: "body_c"
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Reusable section widget
  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold,fontFamily: "body_c")),
          const SizedBox(height: 6),
          Text(
            content,
            style: const TextStyle(fontSize: 18, height: 1.6,fontFamily: "body_p"),
          ),
        ],
      ),
    );
  }
}
