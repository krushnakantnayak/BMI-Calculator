import 'package:f_app/Widgets/custom_text_field.dart';
import 'package:f_app/Widgets/header_text.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BMI",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const MyHomePage(title: "Bodifit"),
    );
  }
}

final formKey = GlobalKey<FormState>();
final FocusNode ftFocus = FocusNode();
final FocusNode inFocus = FocusNode();
final FocusNode calcFocus = FocusNode();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required String title});
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
    var wt = double.parse(wtController.text.toString());
    var ft = double.parse(ftController.text.toString());
    var inch = double.parse(inController.text.toString());
    // calculate BMI
    var totalInch = (ft * 12) + inch;
    var totalCm = totalInch * 2.54;
    var totalMeter = totalCm / 100;
    var bmi = wt / (totalMeter * totalMeter);
    var msg = "";
    // Update BMI
    if (bmi > 25) {
      msg = "you are overWeight";
      bgcolor = const Color.fromARGB(255, 245, 97, 18);
    } else if (bmi < 18) {
      msg = "you are underWeight";
      bgcolor = Colors.red.shade200;
    } else {
      msg = "You are Healthy";
      bgcolor = const Color.fromARGB(255, 80, 247, 86);
    }
    setState(() {
      result = " $msg \n Your BMI is:${bmi.toStringAsFixed(3)}";
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Bodifit"))),
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
                  const Text(
                    'BMI',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 21),
                  const HeaderText(title: "Enter Your Weight"),
                  // Custom Textform field
                  CustomTextField(
                    lable: "Kilogram",
                    requestFocus: ftFocus,
                    controller: wtController,
                  ),
                  const HeaderText(title: "Enter Your height"),
                  Row(
                    children: [
                      Expanded(
                          child: CustomTextField(
                        lable: "Feet",
                        focusNode: ftFocus,
                        requestFocus: inFocus,
                        controller: ftController,
                      )),
                      Expanded(
                          child: CustomTextField(
                        lable: "Inch",
                        focusNode: inFocus,
                        requestFocus: calcFocus,
                        controller: inController,
                      )),
                    ],
                  ),
                  ElevatedButton(
                    focusNode: calcFocus,
                    onPressed: _onCalculate,
                    child: const Text("Calculate"),
                  ),
                  const SizedBox(height: 11),
                  // Result
                  Text(
                    result,
                    style: const TextStyle(fontSize: 19),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
