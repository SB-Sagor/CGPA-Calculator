import 'package:cgpa/screens/cgpa_screen.dart';
import 'package:cgpa/screens/gpa_screen.dart';
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
              child: Text(
                Provider.of<ThemeProvider>(context).isLightMode
                    ? "Light"
                    : "Dark",
              ),
            ),
          ],
        ),
      ),
      body: Center(
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
                    MaterialPageRoute(builder: (context) => CgpaScreen()),
                  );
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Color(0xFF92A7C7),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    items[index],
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
