

import 'package:flutter/material.dart';

class AboutDeveloperScreen extends StatelessWidget {
  const AboutDeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Developer"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            // 🔹 Profile Image
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue.shade100,
                backgroundImage: AssetImage("assets/images/me.jpeg"),
                // 👆 yahan apni image dalni hai (assets se ya network image)
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Developer Name
            const Center(
              child: Text(
                "Talha Afridi Coder",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,fontFamily: "title"),
              ),
            ),
            const SizedBox(height: 6),
            const Center(
              child: Text(
                "Flutter & Full Stack Developer",
                style: TextStyle(fontSize: 16, color: Colors.grey,fontFamily: "body_c"),
              ),
            ),

            const SizedBox(height: 20),
            const Divider(),

            // 🔹 About Me
            const Text(
              "About Me",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: "title"),
            ),
            const SizedBox(height: 10),
            const Text(
              "I am a passionate developer with expertise in cross-platform mobile app development, "
                  "backend systems, data science, and cybersecurity. I love building scalable apps and "
                  "exploring cutting-edge technologies.",
              style: TextStyle(fontSize: 20, height: 1.5,fontFamily: "body_p"),
            ),

            const SizedBox(height: 20),

            // 🔹 Skills Section
            const Text(
              "Technical Skills",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: "title"),
            ),
            const SizedBox(height: 10),
            _buildSkillItem(Icons.phone_android, "Flutter (Mobile App Development)"),
            _buildSkillItem(Icons.code, "Python (NumPy, Pandas, OpenCV, Django)"),
            _buildSkillItem(Icons.security, "Networking & Cybersecurity"),
            _buildSkillItem(Icons.storage, "Databases (SQLite, Firebase, PostgreSQL)"),
            _buildSkillItem(Icons.web, "REST APIs & Backend Development"),

            const SizedBox(height: 20),

            // 🔹 Achievements / Work
            const Text(
              "What I Do",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: "title"),
            ),
            const SizedBox(height: 10),
            const Text(
              "✔ Build high-quality mobile apps using Flutter\n"
                  "✔ Create and manage backend systems with Django & Firebase\n"
                  "✔ Perform data analysis and visualization with Python libraries\n"
                  "✔ Work on computer vision projects using OpenCV\n"
                  "✔ Ensure secure and optimized networking solutions\n",
              style: TextStyle(fontSize: 12, height: 1.6,fontFamily: "body_c"),
            ),

            const SizedBox(height: 20),
            const Divider(),

            // 🔹 Contact Info
            const Text(
              "Contact Me",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: "title"),
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.email, color: Colors.blue),
              title: Text("Email",style: TextStyle(fontFamily: "body_c",fontSize: 15)),
              subtitle: Text("talhaafridi@gmail.com",style: TextStyle(fontFamily: "body_c",fontSize: 12,color: Colors.blue)), // 👈 apna email
            ),
            const ListTile(
              leading: Icon(Icons.link, color: Colors.blue),
              title: Text("GitHub",style: TextStyle(fontFamily: "body_c",fontSize: 15)),
              subtitle: Text("github.com/q343313",style: TextStyle(fontFamily: "body_c",fontSize: 12,color: Colors.blue),), // 👈 apna github link
            ),
            const ListTile(
              leading: Icon(Icons.work, color: Colors.blue),
              title: Text("LinkedIn",style: TextStyle(fontFamily: "body_c",fontSize: 15)),
              subtitle: Text("linkedin.com/in/talhaafridi",style: TextStyle(fontFamily: "body_c",fontSize: 12,color: Colors.blue)), // 👈 apna linkedin
            ),

            const SizedBox(height: 30),

            Center(
              child: Text(
                "“Building apps that connect people with technology.”",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                  fontFamily: "body_c"
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // 🔹 reusable widget for skill items
  Widget _buildSkillItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12,fontFamily: "body_c"))),
        ],
      ),
    );
  }
}
