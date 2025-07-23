import 'package:final_q/view/login_screen.dart';
import 'package:flutter/material.dart';

import '../core/helper/shared_preferences_helper.dart';

class TopicDetailScreen extends StatefulWidget {
  final String topic;

  const TopicDetailScreen({super.key, required this.topic});

  @override
  State<TopicDetailScreen> createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends State<TopicDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLoggedIn = false;


  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
      super.initState();
      checkLoginStatus();
    }

    Future<void> checkLoginStatus() async {
      bool status = await SharedPreferencesHelper().getPrefBool(key: 'isLoggedIn', defaultValue: false);
      setState(() {
        isLoggedIn = status;
      });
    }

    @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<String> videos = [
    "https://www.youtube.com/watch?v=video1",
    "https://www.youtube.com/watch?v=video2",
    "https://www.youtube.com/watch?v=video2",
    "https://www.youtube.com/watch?v=video2",
  ];

  final List<String> documents = [
    "https://example.com/flutter-intro.pdf",
    "https://example.com/widgets-guide.pdf",
    "https://example.com/widgets-guide.pdf",
  ];

  final List<String> resources = [
    "https://flutter.dev/docs",
    "https://medium.com/flutter",
    "https://medium.com/flutter",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic,style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          indicatorColor: Colors.purple[200],
          unselectedLabelColor: Colors.black,
          tabs: const [
            Tab(icon: Icon(Icons.play_circle_fill), text: "Videos"),
            Tab(icon: Icon(Icons.picture_as_pdf), text: "Documents"),
            Tab(icon: Icon(Icons.link), text: "Resources"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildVideoTab(),
          _buildDocumentsTab(),
          _buildResourcesTab(),
        ],
      ),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.lock, size: 60, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            "You need to login to view this content",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              bool isLoggedIn = await SharedPreferencesHelper().getPrefBool(key: 'isLoggedIn', defaultValue: false);

              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            child: const Text("Login or Register",style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoTab() {
    if (!isLoggedIn) {
      return _buildLoginPrompt(context);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.play_circle),
          title: Text("Video ${index + 1}"),
          subtitle: Text(videos[index]),
          onTap: () {
            // open video
          },
        );
      },
    );
  }

  Widget _buildDocumentsTab() {
    if (!isLoggedIn) {
      return _buildLoginPrompt(context);
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: documents.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.picture_as_pdf),
          title: Text("Document ${index + 1}"),
          subtitle: Text(documents[index]),
          onTap: () {
            // open PDF
          },
        );
      },
    );
  }

  Widget _buildResourcesTab() {
    if (!isLoggedIn) {
      return _buildLoginPrompt(context);
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: resources.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.link),
          title: Text("Resource ${index + 1}"),
          subtitle: Text(resources[index]),
          onTap: () {
         //open link
          },
        );
      },
    );
  }
}
