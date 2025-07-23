import 'package:flutter/material.dart';
import 'topic_screen.dart';

class LanguagesScreen extends StatefulWidget {
  final String section;

  const LanguagesScreen({super.key, required this.section});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();

}


class _LanguagesScreenState extends State<LanguagesScreen> {
  final Map<String, List<String>> sectionLanguages = {
    "Web": ["HTML", "CSS", "JavaScript", "PHP"],
    "Mobile": ["Flutter", "React Native", "Kotlin", "Swift"],
    "Desktop": ["C#", "Electron", "JavaFX"],
    "AI": ["Python", "TensorFlow", "PyTorch"],
    "Cyber Security": ["Networking", "Kali Linux", "Ethical Hacking"],
    "Data Science": ["Python", "R", "SQL"],
  };

  final Map<String, IconData> sectionIcons = {
    "Web": Icons.language,
    "Mobile": Icons.smartphone,
    "Desktop": Icons.desktop_windows,
    "AI": Icons.memory,
    "Cyber Security": Icons.security,
    "Data Science": Icons.bar_chart,
  };
   late var icon ;
   late var languages ;

  @override
  void initState() {
    icon = sectionIcons[widget.section] ?? Icons.code;
    languages = sectionLanguages[widget.section] ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 4,
        title: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Text(
              "${widget.section}",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.purple[50]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: languages.length,
          itemBuilder: (context, index) {
            final language = languages[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TopicsScreen(language: language)),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple[100]!, Colors.white],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.15),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.code, color: Colors.deepPurple, size: 28),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        language,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepPurple[900],
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.deepPurple),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
