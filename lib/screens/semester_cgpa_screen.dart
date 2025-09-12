import 'package:flutter/material.dart';

class SemesterCgpaScreen extends StatefulWidget {
  const SemesterCgpaScreen({super.key});

  @override
  State<SemesterCgpaScreen> createState() => _SemesterCgpaScreenState();
}

class _SemesterCgpaScreenState extends State<SemesterCgpaScreen> {
  final List<String> items = [
    "Semester 1",
    "Semester 2",
    "Semester 3",
    "Semester 4",
    "Semester 5",
    "Semester 6",
    "Semester 7",
    "Semester 8",
  ];
  final List<double> semesterCredits = [
    20.50,
    21.50,
    22.25,
    19.25,
    19.50,
    19.50,
    20.50,
    17.50,
  ];

  List<double?> semesterGPAs = List.filled(8, null);

  double calculateCGPA() {
    double totalCreditPoints = 0;
    double totalCredits = 0;

    for (int i = 0; i < semesterGPAs.length; i++) {
      if (semesterGPAs[i] != null) {
        totalCreditPoints += semesterGPAs[i]! * semesterCredits[i];
        totalCredits += semesterCredits[i];
      }
    }

    return totalCredits > 0 ? totalCreditPoints / totalCredits : 0.0;
  }

  void _showGPABottomSheet(int index) {
    TextEditingController gpaController = TextEditingController();
    double? currentGPA = semesterGPAs[index];

    if (currentGPA != null) {
      gpaController.text = currentGPA.toStringAsFixed(2);
    }

    showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      // Full page showing bottom sheet
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),

        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Enter GPA for ${items[index]}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: gpaController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: "GPA (0.00 - 4.00)",
                border: OutlineInputBorder(),
                hintText: "e.g. 3.75, 3.50",
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF92A7C7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      double? gpa = double.tryParse(gpaController.text);
                      if (gpa != null && gpa >= 0.0 && gpa <= 4.0) {
                        setState(() {
                          semesterGPAs[index] = gpa;
                        });
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Please enter a valid GPA (0.00 - 4.00)",
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double cgpa = calculateCGPA();
    int completedSemesters = semesterGPAs.where((gpa) => gpa != null).length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CGPA Calculation",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Overall CGPA",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  cgpa.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Completed Semesters: $completedSemesters/8",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _showGPABottomSheet(index);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          items[index],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          semesterGPAs[index]?.toStringAsFixed(2) ?? "Not set",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
    );
  }
}
