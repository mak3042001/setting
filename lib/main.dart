import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SettingsScreen(),
    );
  }
}


class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  FocusNode focusNode = FocusNode();
  bool isEnabled = true;
  bool drakeMode = false;

  @override
  void initState() {
    super.initState();
    // Add a listener to the focus node to update the enabled state
    focusNode.addListener(() {
      setState(() {
        isEnabled = focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap:  () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Center(child: Text('Setting',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),)),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  focusNode: focusNode,
                  enabled: isEnabled,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: SettingsList(
                  sections: [
                    SettingsSection(
                      title: Text(''),
                      tiles: [
                        SettingsTile(
                          title: Text('Lock Screen'),
                          leading: Icon(Icons.lock),
                          onPressed: (BuildContext context) {},
                        ),
                        SettingsTile.switchTile(
                          title: Text('Drake Mode'),
                          leading: Icon(Icons.nightlight_round),
                          onToggle: (bool value) {
                            setState(() {
                              drakeMode = value;
                            });
                          }, initialValue: drakeMode,
                        ),
                        SettingsTile(
                          title: Text('Sound & Vibration'),
                          leading: const Icon(Icons.volume_up),
                          onPressed: (BuildContext context) {},
                        ),
                        SettingsTile(
                          title: Text('About'),
                          leading: Icon(Icons.info),
                          onPressed: (BuildContext context) {},
                        ),
                      ],
                    ),
                    SettingsSection(
                      title: Text(''),
                      tiles: [
                        SettingsTile(
                          title: Text('Contact'),
                          leading: Icon(Icons.contact_page),
                          onPressed: (BuildContext context) {},
                        ),
                        SettingsTile(
                          title: Text('Sound & Vibration'),
                          leading: Icon(Icons.volume_up),
                          onPressed: (BuildContext context) {},
                        ),
                        SettingsTile(
                          title: Text('About'),
                          leading: Icon(Icons.info),
                          onPressed: (BuildContext context) {},
                        ),
                        SettingsTile(
                          title: Text('Contact'),
                          leading: Icon(Icons.contact_page),
                          onPressed: (BuildContext context) {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'My Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

