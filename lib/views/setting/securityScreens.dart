

import 'package:flutter/material.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Security"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "App Security",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,fontFamily: "title"),
            ),
            const SizedBox(height: 10),
            Text(
              "At Local Market, the safety of your account and data is our top priority. "
                  "We follow industry-standard practices to ensure your information is protected.",
              style: TextStyle(fontSize: 14, height: 1.6, color: Colors.grey.shade800,fontFamily: "body_c"),
            ),
            const SizedBox(height: 20),

            _buildSection(
              title: "1. Secure Authentication",
              content:
              "All users must create an account with a valid email and strong password. "
                  "We recommend enabling two-factor authentication (2FA) for extra protection.",
            ),
            _buildSection(
              title: "2. Data Encryption",
              content:
              "Your sensitive data (such as login credentials and personal details) "
                  "is encrypted both during transmission and while stored.",
            ),
            _buildSection(
              title: "3. Regular Monitoring",
              content:
              "We monitor unusual activities to detect unauthorized access and keep your account safe.",
            ),
            _buildSection(
              title: "4. Safe Transactions",
              content:
              "All product purchases and payments are handled through secure and verified channels.",
            ),
            _buildSection(
              title: "5. User Responsibilities",
              content:
              "Keep your login details private, avoid sharing passwords, and regularly update them for better protection.",
            ),
            _buildSection(
              title: "6. Report Issues",
              content:
              "If you notice any suspicious activity in your account, please report immediately to support@localmarket.com.",
            ),

            const SizedBox(height: 30),
            Center(
              child: Icon(Icons.security, size: 60, color: Colors.blueAccent),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "Your Security, Our Priority 🔒",
                style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade700,fontFamily: "title"),
              ),
            ),
          ],
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
                  fontSize: 16, fontWeight: FontWeight.bold,fontFamily: "body_c")),
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
