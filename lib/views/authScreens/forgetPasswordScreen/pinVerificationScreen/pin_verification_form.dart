import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_textfield.dart';

class PinVerificationForm extends StatelessWidget {
  final List<TextEditingController> pinTEControllers;
  final List<FocusNode> focusNodes;
  final GlobalKey<FormState> formKey;
  final double textFieldHeight = 50;
  final double textFieldWidth;

  const PinVerificationForm(
      {super.key,
      required this.textFieldWidth,
      required this.pinTEControllers,
      required this.focusNodes,
      required this.formKey});

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.orientationOf(context);
    return Form(
      key: formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(focusNodes.length, (index) {
          return Padding(
            padding: EdgeInsets.only(left: (orientation == Orientation.portrait) ? 8 :18),
            child: SizedBox(
              width: textFieldWidth,
              height: textFieldHeight,
              child: AppTextField(
                focusNode: focusNodes[index],
                controller: pinTEControllers[index],
                inputType: TextInputType.number,
                maxLength: 1,
                textAlign: TextAlign.center,
                textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                disableValidation: true,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (index == focusNodes.length - 1) {
                      FocusScope.of(context).unfocus();
                    } else {
                      FocusScope.of(context)
                          .requestFocus(focusNodes[index + 1]);
                    }
                  }
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
