import 'package:f_app/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BMI_Calculator",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const MyHomePage(title: "BMI_CALCULATOR"),
    );
  }
}

final formKey = GlobalKey<FormState>();
final FocusNode ftFocus = FocusNode();
final FocusNode inFocus = FocusNode();
final FocusNode calcFocus = FocusNode();

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required String title}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();

  var result = "";
  var bgcolor = Colors.amber.shade200;

  void _onCalculate() {
    if (formKey.currentState!.validate()) {}
    var wt = int.parse(wtController.text.toString());
    var ft = int.parse(ftController.text.toString());
    var inch = int.parse(inController.text.toString());
    // calculate BMI
    var totalInch = (ft * 12) + inch;
    var totalCm = totalInch * 2.54;
    var totalMeter = totalCm / 100;
    var bmi = wt / (totalMeter * totalMeter);
    var msg = "";
    // Update BMI
    if (bmi > 25) {
      msg = "you are overWeight";
      bgcolor = Colors.orange.shade200;
    } else if (bmi < 18) {
      msg = "you are underWeight";
      bgcolor = Colors.red.shade200;
    } else {
      msg = "You are Healthy";
      bgcolor = Colors.green.shade200;
    }
    setState(() {
      result = " $msg \n Your BMI is:${bmi.toStringAsFixed(3)}";
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BMI Calculator")),
      body: Container(
        color: bgcolor,
        child: Center(
          child: SizedBox(
            width: 300,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header
                  const Text('BMI', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 21),
                  const HeaderText(title: "Enter Your Weight"),
                  // Custom Textform field
                  CustomTextField(controller: wtController, lable: "Kilogram", requestFocus: ftFocus),
                  const HeaderText(title: "Enter Your height"),
                  Row(
                    children: [
                      Expanded(child: CustomTextField(focusNode: ftFocus, controller: ftController, lable: "Feet", requestFocus: inFocus)),
                      Expanded(child: CustomTextField(focusNode: inFocus, controller: inController, lable: "Inch", requestFocus: calcFocus)),
                    ],
                  ),
                  ElevatedButton(focusNode: calcFocus, onPressed: _onCalculate, child: const Text("Calculate")),
                  const SizedBox(height: 11),
                  // Result
                  Text(result, style: const TextStyle(fontSize: 19))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  final String title;
  const HeaderText({
    super.key,
    required this.title,
  });
// this is a test comment
// bohhut sara code ...
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
      ),
    );
  }
}
