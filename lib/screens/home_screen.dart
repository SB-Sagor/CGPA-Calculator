import 'package:cgpa/screens/gpa_screen.dart';
import 'package:cgpa/screens/semester_cgpa_screen.dart';
import 'package:cgpa/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<dynamic> items = ["GPA", "CGPA"];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Calculation",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            TextButton(
              onPressed: () {
                Provider.of<ThemeProvider>(
                  context,
                  listen: false,
                ).toggleTheme();
              },
              child: Icon(
                Provider.of<ThemeProvider>(context).isLightMode
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('images/boss.png'),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Color(0xFF92A7C7), width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            "CGPA Calculator",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Calculate your GPA & CGPA easily",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (items[index] == "GPA") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GpaScreen()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SemesterCgpaScreen(),
                        ),
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(20),
                  splashColor: Colors.white24,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(16),
                    ),
                    elevation: 6,
                    shadowColor: Colors.black54,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        gradient: themeProvider.isLightMode
                            ? const LinearGradient(
                                colors: [Color(0xFF6A85B6), Color(0xFF92A7C7)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : const LinearGradient(
                                colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),

                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          items[index],
                          style: TextStyle(fontSize: 26),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
