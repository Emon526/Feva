import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../provider/callprovider.dart';
import '../utils/utils.dart';
import '../widgets/custominputwidget.dart';
import '../widgets/cutombutton.dart';
import 'callhostscreen.dart';

class HiringFormScreen extends StatelessWidget {
  final countryController = TextEditingController();
  final skillController = TextEditingController();
  HiringFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Hiring",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Consumer<CallProvider>(
        builder: (BuildContext context, CallProvider value, Widget? child) =>
            SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: value.hiringFormKey,
                          child: Column(
                            children: [
                              InputWidget(
                                readOnly: true,
                                inputname:
                                    'What Country Are You Looking to Hire Form?',
                                textEditingController: countryController,
                                labelText: 'Select Country',
                                textInputType: TextInputType.text,
                                onChanged: (value) {},
                                onTap: () => _showDropdown(
                                  context: context,
                                  selectedCountry: value.country,
                                  onChanged: (String? newValue) {
                                    countryController.text = newValue!;
                                    Navigator.of(context).pop();
                                  },
                                ),
                                validator: RequiredValidator(
                                  errorText: 'Input Required',
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              InputWidget(
                                inputname: 'Skills',
                                textEditingController: skillController,
                                labelText: 'Type here',
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                onChanged: (skill) {
                                  skillController.text = skill;
                                },
                                onFieldSubmitted: (skill) => {
                                  skillController.text = skill,
                                },
                                validator: RequiredValidator(
                                  errorText: 'Input Required',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  ontap: () {
                    if (value.hiringFormKey.currentState!.validate()) {
                      value.skill = skillController.text;
                      value.country = countryController.text;
                      debugPrint(value.country);
                      debugPrint(value.skill);
                      value.ishiring = true;
                      // value.fetchToken(
                      //   DateTime.now().millisecondsSinceEpoch,
                      //   'publisher',
                      // );
                      FocusManager.instance.primaryFocus!.unfocus();
                      value.joinChannel(DateTime.now().millisecondsSinceEpoch);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CallHostScreen(),
                        ),
                      );
                    }
                  },
                  buttontext: 'Continue →',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showDropdown(
      {required BuildContext context,
      required String selectedCountry,
      required Function(String?)? onChanged}) {
    List<String> options = <String>[
      'Canada',
      'United States',
      'India',
      'Philippines',
      'Pakistan',
      'Venezuela'
    ];
    Utils(context).showCustomDialog(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButton<String>(
              value: selectedCountry,
              onChanged: onChanged,
              underline: const SizedBox(),
              isExpanded: true,
              style: const TextStyle(color: Colors.black),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
              selectedItemBuilder: (BuildContext context) {
                return options.map((String value) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      selectedCountry,
                    ),
                  );
                }).toList();
              },
              items: options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )));
  }
}
