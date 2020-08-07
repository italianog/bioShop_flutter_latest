import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  int _currentStep = 0;
  TextEditingController firstStepController;
  TextEditingController secondStepController;
  TextEditingController thirdStepController;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stepper(
            type: StepperType.horizontal,
            currentStep: _currentStep,
            onStepTapped: (int step) => setState(() => _currentStep = step),
            onStepContinue: _currentStep < 2
                ? () => setState(() => _currentStep += 1)
                : null,
            onStepCancel: _currentStep > 0
                ? () => setState(() => _currentStep -= 1)
                : null,
            steps: <Step>[
              Step(
                title: Text("Username"),
                content: TextField(
                  decoration: InputDecoration(
                    hintText: "Username",
                  ),
                  controller: firstStepController,
                ),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 0 ? StepState.complete : StepState.disabled,
              ),
              Step(
                title: Text("Account Info"),
                content: TextField(
                  decoration: InputDecoration(
                    hintText: "Info_2",
                  ),
                  controller: secondStepController,
                ),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 1 ? StepState.complete : StepState.disabled,
              ),
              Step(
                title: Text("Quasi finito"),
                content: TextField(
                  decoration: InputDecoration(
                    hintText: "Info_3",
                  ),
                  controller: thirdStepController,
                ),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 2 ? StepState.complete : StepState.disabled,
              ),
            ]),
      ),
    );
  }
}
