import 'package:flutter/material.dart';
import 'topic_detail_screen.dart';

class TopicsScreen extends StatefulWidget {
  final String language;

  const TopicsScreen({super.key, required this.language});

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  late List<String> topics;
  List<String> filteredTopics = [];
  final TextEditingController searchController = TextEditingController();

  final Map<String, String> languageIcons = {
    "Flutter": "assets/img/flutter.png",
    "HTML": "assets/img/html.png",
    "CSS": "assets/img/css.png",
    "JavaScript": "assets/img/js.png",
    "PHP": "assets/img/php.png",
    "Python": "assets/img/python.png",
    "Kotlin": "assets/img/kotlin.png",
    "Swift": "assets/img/swift.png",
    "C#": "assets/img/csharp.png",
    "React Native": "assets/img/react.png",
    "TensorFlow": "assets/img/tensorflow.png",
    "PyTorch": "assets/img/pytorch.png",
    "Kali Linux": "assets/img/kali.png",
    "Networking": "assets/img/networking.png",
    "Ethical Hacking": "assets/img/hacking.png",
    "SQL": "assets/img/sql.png",
    "R": "assets/img/r.png",
  };

  final Map<String, List<String>> languageTopics = {
    "Flutter": ["Introduction to Flutter", "Basic Widgets", "State Management", "Working with APIs", "Navigation & Routing", "Flutter Firebase Integration"],
    "HTML": ["Introduction to HTML", "Basic Tags", "Forms & Inputs", "HTML Tables", "HTML Semantic Elements", "Multimedia in HTML"],
    "CSS": ["Introduction to CSS", "Selectors and Properties", "Box Model", "Flexbox and Grid", "Responsive Design", "Animations and Transitions"],
    "JavaScript": ["JavaScript Basics", "DOM Manipulation", "Functions & Scope", "Events Handling", "ES6 Features", "Async JS: Callbacks, Promises, Async/Await"],
    "PHP": ["Introduction to PHP", "Working with Forms", "PHP and MySQL", "Sessions and Cookies", "OOP in PHP", "Error Handling in PHP"],
    "Python": ["Python Basics", "Loops and Conditions", "Functions", "Object-Oriented Programming", "Working with Files", "Python for Data Analysis"],
    "Kotlin": ["Kotlin Basics", "Null Safety", "Classes and Objects", "Collections", "Coroutines", "Kotlin Android Overview"],
    "Swift": ["Swift Basics", "Optionals and Variables", "Control Flow", "Functions and Closures", "SwiftUI Overview", "iOS App Structure"],
    "C#": ["C# Basics", "Data Types and Variables", "OOP in C#", "LINQ", "Asynchronous Programming", "Windows Forms Development"],
    "React Native": ["Introduction to React Native", "Components and Props", "State and Hooks", "Navigation in React Native", "Styling Components", "APIs and Data Fetching"],
    "TensorFlow": ["Intro to TensorFlow", "Tensors and Operations", "Building a Neural Network", "Model Training", "Image Classification", "Saving and Loading Models"],
    "PyTorch": ["PyTorch Basics", "Autograd and Tensors", "Building Neural Networks", "Loss Functions", "Training Loops", "Using Pretrained Models"],
    "Kali Linux": ["Getting Started with Kali Linux", "Basic Commands", "Network Scanning Tools", "Password Cracking Tools", "Wireless Attacks", "Reporting and Documentation"],
    "Networking": ["Networking Basics", "OSI Model", "TCP/IP Protocols", "IP Addressing", "Subnetting", "Network Security Concepts"],
    "Ethical Hacking": ["Introduction to Ethical Hacking", "Reconnaissance Techniques", "Vulnerability Assessment", "Penetration Testing Basics", "Exploitation Techniques", "Post Exploitation and Reporting"],
    "SQL": ["SQL Basics", "SELECT and WHERE", "JOINs", "GROUP BY and Aggregates", "Subqueries", "Database Design Concepts"],
    "R": ["Introduction to R", "Vectors and Data Types", "Data Frames and Lists", "Basic Statistics in R", "Data Visualization", "Using ggplot2"]
  };

  @override
  void initState() {
    super.initState();
    topics = languageTopics[widget.language] ?? [];
    filteredTopics = topics;
  }

  void filterTopics(String query) {
    setState(() {
      filteredTopics = topics
          .where((topic) => topic.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = languageIcons[widget.language];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 4,
        title: Row(
          children: [
            if (imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(imagePath, width: 30, height: 30),
              ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "${widget.language} Topics",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.purple[50]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                onChanged: filterTopics,
                decoration: InputDecoration(
                  hintText: "Search topics...",
                  prefixIcon: Icon(Icons.search, color: Colors.purple),
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTopics.length,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final topic = filteredTopics[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TopicDetailScreen(topic: topic),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purple[100]!, Colors.white],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.15),
                            blurRadius: 8,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.book, color: Colors.deepPurple),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              topic,
                              style: TextStyle(
                                fontSize: 16,
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
          ],
        ),
      ),
    );
  }
}
