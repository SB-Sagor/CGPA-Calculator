import 'package:cgpa/screens/semester_subjects.dart';
import 'package:flutter/material.dart';

class SemesterGpaScreen extends StatefulWidget {
  final String semesterName;

  const SemesterGpaScreen({super.key, required this.semesterName});

  @override
  State<SemesterGpaScreen> createState() => _SemesterGpaScreenState();
}

class _SemesterGpaScreenState extends State<SemesterGpaScreen> {
  late List<Map<String, dynamic>> subjects;
  late List<TextEditingController> gradeControllers;
  List<double?> selectedGrades = [];
  final List<Map<String, dynamic>> gradeOptions = [
    {'label': 'A+', 'value': 4.00},
    {'label': 'A', 'value': 3.75},
    {'label': 'A-', 'value': 3.50},
    {'label': 'B+', 'value': 3.25},
    {'label': 'B', 'value': 3.00},
    {'label': 'B-', 'value': 2.75},
    {'label': 'C+', 'value': 2.50},
    {'label': 'C', 'value': 2.25},
    {'label': 'D', 'value': 2.00},
    {'label': 'F', 'value': 0.00},
  ];

  @override
  @override
  void initState() {
    super.initState();
    subjects = semesterSubjects[widget.semesterName] ?? [];
    selectedGrades = List.filled(subjects.length, null);
    gradeControllers = List.generate(
      subjects.length,
      (_) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (var controller in gradeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  double calculateGpa() {
    double totalCredits = 0;
    double totalCreditGrade = 0;

    for (int i = 0; i < subjects.length; i++) {
      double credit = subjects[i]['credit'];
      double grade = selectedGrades[i] ?? 0;

      totalCredits += credit;
      totalCreditGrade += grade * credit;
    }

    return totalCredits == 0 ? 0 : totalCreditGrade / totalCredits;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.semesterName} GPA")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  final subject = subjects[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${subject['code']} - ${subject['title']}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text("Credit: ${subject['credit']}"),
                          SizedBox(height: 8),
                          // If you want the value to be the whole map
                          DropdownButtonFormField<double>(
                            value: selectedGrades[index],
                            decoration: InputDecoration(
                              labelText: "Select grade",
                              border: OutlineInputBorder(),
                            ),
                            items: gradeOptions.map((item) {
                              return DropdownMenuItem<double>(
                                value: item['value'],
                                child: Row(
                                  // Or any other layout widget
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(item['label']),
                                    Text("(${item['value']})"),
                                    // Displaying the value
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedGrades[index] = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                double gpa = calculateGpa();
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (_) => Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Calculated GPA",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Your GPA is: ${gpa.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF92A7C7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "OK",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF92A7C7),
                foregroundColor: Colors.black,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text(
                  "Calculate GPA",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
