
import 'package:easy_localization/easy_localization.dart';
import 'package:final_q/view/languages_screen.dart';
import 'package:final_q/view/login_screen.dart';
import 'package:flutter/material.dart';
import '../core/helper/language_helper.dart';
import '../core/helper/responsive.dart';
import '../core/helper/shared_preferences_helper.dart';
import '../widget/custom_floating_button.dart';
import '../widget/custom_navigation_bar.dart';

class Home1Screen extends StatefulWidget {
  @override
  _Home1ScreenState createState() => _Home1ScreenState();
}

class _Home1ScreenState extends State<Home1Screen> {
  TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> sections = const [
    {"name": "Web", "icon": Icons.web, "color": Colors.purple},
    {"name": "Mobile", "icon": Icons.phone_android, "color": Colors.pink},
    {
      "name": "Desktop",
      "icon": Icons.desktop_windows,
      "color": Colors.blueGrey,
    },
    {"name": "AI", "icon": Icons.memory, "color": Colors.blueAccent},
    {
      "name": "Cyber Security",
      "icon": Icons.security,
      "color": Colors.pinkAccent,
    },
    {"name": "Data Science", "icon": Icons.bar_chart, "color": Colors.teal},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: responsiveWidth(context, 7)),
                Image.asset(
                  "assets/img/logoo.png",
                  height: responsiveHeight(context, 80),
                  width: responsiveWidth(context, 120),
                ),
                SizedBox(
                  height: responsiveHeight(context, 43),
                  width: responsiveWidth(context, 49),
                  child: Container(
                    padding: EdgeInsets.all(0),
                    child: IconButton(
                      icon: Icon(Icons.language, color: Colors.black),
                      onPressed: () async {
                        final currentLocale = context.locale;
                        Locale newLocale = currentLocale.languageCode == 'en' ? Locale('ar') : Locale('en');
                        await context.setLocale(newLocale);
                        await LanguageHelper.saveLocale(newLocale);
                      },

                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: buildCustomDrawer(context),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(7),
            child: Container(
              width: responsiveWidth(context, 400),
              height: responsiveHeight(context, 55),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: 15,
                    wordSpacing: -1,
                    color: Colors.grey[600],
                  ),
                  hintText: tr("search_hint"),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search, color: Colors.grey[600]),
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 10),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                   Text(
                    tr("Choose_section"),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                  ),
                   SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      itemCount: sections.length,
                      gridDelegate:
                           SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1,
                          ),
                      itemBuilder: (context, index) {
                        final section = sections[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => LanguagesScreen(
                                      section: tr(section["name"]),
                                    ),
                              ),
                            );
                          },
                          child: Card(
                            color: section["color"].withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  section["icon"],
                                  size: 40,
                                  color: section["color"],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  tr(section["name"]),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: section["color"],
                                  ),
                                ),
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
          ),
        ],
      ),
    );
  }

  Drawer buildCustomDrawer(BuildContext context) {
    return Drawer(
      child: FutureBuilder(
        future: Future.wait([
          SharedPreferencesHelper().getName(),
          SharedPreferencesHelper().getEmail(),
          SharedPreferencesHelper().getPrefBool(
            key: tr('isLoggedIn'),
            defaultValue: false,
          ),
        ]),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final String name = snapshot.data![0] as String;
          final String email = snapshot.data![1] as String;
          final bool isLoggedIn = snapshot.data![2] as bool;

          if (!isLoggedIn) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.purple[200]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                          'assets/img/Profile.png',
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        tr("welcome_guest"),
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.home),
                  title: Text(tr("Home")),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text(tr("about_app")),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.info_outline, size: 60, color: Colors.purple),
                                SizedBox(height: 16),
                                Text(
                                  tr('about_title'),
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                 tr("about_description"),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, color: Colors.black87),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  icon: Icon(Icons.check,color: Colors.white,),
                                  label: Text(tr("got_it"),style: TextStyle(color: Colors.white),),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                ListTile(
                  leading: Icon(Icons.login),
                  title: Text(tr("login")),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ],
            );
          }


          return ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(name,style: TextStyle(color: Colors.black),),
                accountEmail: Text(email,style: TextStyle(color: Colors.black),),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/img/Profile.png'),
                ),
                decoration: BoxDecoration(color: Colors.purple[200]),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text(tr('Home')),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text(tr('about_app')),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.info_outline, size: 60, color: Colors.purple),
                              SizedBox(height: 16),
                              Text(
                                tr("about_title"),
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(tr( "about_description" )
                                ,textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, color: Colors.black87),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(Icons.check,color: Colors.white,),
                                label: Text(tr("got_it"),style: TextStyle(color: Colors.white),),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text(tr('logout')),
                onTap: () async {
                  await SharedPreferencesHelper().savePrefBool(
                    key: 'isLoggedIn',
                    value: false,
                  );
                  await SharedPreferencesHelper().remove(key: 'name');
                  await SharedPreferencesHelper().remove(key: 'email');
                  await SharedPreferencesHelper().remove(key: 'password');
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(tr("logged_out_success"))),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
