import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../provider/callprovider.dart';
import '../utils/utils.dart';
import '../widgets/custominputwidget.dart';
import '../widgets/cutombutton.dart';
import 'callhostscreen.dart';

class LookingForJobsScreen extends StatelessWidget {
  final countryController = TextEditingController();
  final skillController = TextEditingController();
  LookingForJobsScreen({super.key});

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
          "Looking for jobs",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Consumer<CallProvider>(
        builder: (BuildContext context, CallProvider value, Widget? child) =>
            Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: value.lookingforjobsFormKey,
                        child: Column(
                          children: [
                            InputWidget(
                              inputname: 'Where are you Form?',
                              textEditingController: countryController,
                              labelText: 'Select Country',
                              textInputType: TextInputType.text,
                              onChanged: (value) {},
                              onTap: () => _showDropdown(
                                context: context,
                                selectedCountry: value.country,
                                onChanged: (String? newValue) {
                                  value.country = newValue!;
                                  countryController.text = newValue;
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
                              onChanged: (skill) {
                                value.skill = skill;
                              },
                              onFieldSubmitted: (skill) => value.skill = skill,
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
                ontap: () async {
                  FocusManager.instance.primaryFocus!.unfocus();
                  if (value.lookingforjobsFormKey.currentState!.validate()) {
                    value.ishiring = false;
                    //TODO:Fix User UID
                    //  value.fetchToken(DateTime.now().millisecond);
                    value.fetchToken(0);
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
    );
  }

  void _showDropdown(
      {required BuildContext context,
      required String selectedCountry,
      required Function(String?)? onChanged}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        List<String> options = <String>[
          'Canada',
          'United States',
          'India',
          'Philippines',
          'Pakistan',
          'Venezuela'
        ];
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                // width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton<String>(
                  value: selectedCountry,
                  onChanged: onChanged,

                  underline: const SizedBox(),
                  isExpanded: true,
                  style: const TextStyle(color: Colors.black),
                  // dropdownColor: AppColors.kWhite,
                  icon: const Icon(Icons.keyboard_arrow_down,
                      color: Colors.black),
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
