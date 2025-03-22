import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String bmiResult = "";
  String status = "";
  Color statusColor = Colors.black;

  // BMI Calculation Logic
  void calculateBMI() {
    double height = double.tryParse(heightController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;

    if (height <= 0 || weight <= 0) {
      setState(() {
        bmiResult = "Invalid Input";
        status = "Please enter valid height & weight!";
        statusColor = Colors.red;
      });
      return;
    }

    double bmi = weight / ((height / 100) * (height / 100));
    bmi = double.parse(bmi.toStringAsFixed(1));

    setState(() {
      bmiResult = "BMI: $bmi kg/m²";
      if (bmi < 18.5) {
        status = "Underweight";
        statusColor = Colors.blue;
      } else if (bmi < 24.9) {
        status = "Normal";
        statusColor = Colors.green;
      } else if (bmi < 29.9) {
        status = "Overweight";
        statusColor = Colors.orange;
      } else {
        status = "Obese";
        statusColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Developed by Sazzy"), // Change the title as needed
        centerTitle: true, // Align title in center
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center( // Centering the Title
              child: Text(
                "Calculate Your BMI", // Change this text
                style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),

            // Height Input
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Height (cm)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.height),
              ),
            ),
            SizedBox(height: 15),

            // Weight Input
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Weight (kg)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.monitor_weight),
              ),
            ),
            SizedBox(height: 20),

            // Calculate Button
            ElevatedButton(
              onPressed: calculateBMI,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text("Check Your BMI"), // Change button text here
            ),

            SizedBox(height: 20),
            // BMI Result
            Text(
              bmiResult,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            // BMI Status
            Text(
              status,
              style: TextStyle(fontSize: 20, color: statusColor, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
