import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

import '../consts/consts.dart';
import '../provider/callprovider.dart';
import '../utils/utils.dart';
import '../widgets/custominputwidget.dart';
import '../widgets/cutombutton.dart';
import '../widgets/dialuserwidget.dart';
import 'callhostscreen.dart';
import 'faceverficationscreen.dart';

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
                                onTap: () => _showCountryPicker(
                                  context: context,
                                  countryList: value.countryList,
                                  selectedCountry: value.country,
                                  onChanged: (String? newValue) {
                                    countryController.text = newValue!;
                                    value.country = newValue;
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
                                readOnly: true,
                                inputname: 'Skill',
                                textEditingController: skillController,
                                labelText: 'Select Skill',
                                onTap: () => _showSkillPicker(
                                  context: context,
                                  skillList: value.skillList,
                                  selectedSkill: value.skill,
                                  onChanged: (String? newValue) {
                                    skillController.text = newValue!;
                                    value.skill = newValue;
                                    Navigator.of(context).pop();
                                  },
                                ),
                                validator: RequiredValidator(
                                  errorText: 'Input Required',
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              value.image == null
                                  ? CustomButton(
                                      ontap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const FaceVerificatuonScreen(),
                                          ),
                                        );
                                      },
                                      buttontext: 'Press to Take Photo',
                                    )
                                  : DialUserPic(
                                      image:
                                          context.read<CallProvider>().image!),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                value.image != null
                    ? CustomButton(
                        ontap: () async {
                          if (value.hiringFormKey.currentState!.validate()) {
                            value.skill = skillController.text;
                            value.country = countryController.text;
                            value.ishiring = true;

                            FocusManager.instance.primaryFocus!.unfocus();
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
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showCountryPicker(
      {required BuildContext context,
      required String selectedCountry,
      required Function(String?)? onChanged,
      required List<String> countryList}) {
    Utils(context).showCustomDialog(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: countryList.length,
        itemBuilder: (BuildContext context, int index) {
          final option = countryList[index];
          return ListTile(
            title: Text(
              option,
              style: TextStyle(
                color: option == selectedCountry
                    ? Colors
                        .white // You can change the color for the selected item
                    : Colors.black,
              ),
            ),
            tileColor: option == selectedCountry
                ? Consts
                    .secondaryColor // You can change the color for the selected item
                : Colors.white,
            onTap: () {
              onChanged!(option);
            },
          );
        },
      ),
    );
  }

  _showSkillPicker(
      {required BuildContext context,
      required String selectedSkill,
      required Function(String?)? onChanged,
      required List<String> skillList}) {
    Utils(context).showCustomDialog(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: skillList.length,
        itemBuilder: (BuildContext context, int index) {
          final option = skillList[index];
          return ListTile(
            title: Text(
              option,
              style: TextStyle(
                color: option == selectedSkill
                    ? Colors
                        .white // You can change the color for the selected item
                    : Colors.black,
              ),
            ),
            tileColor: option == selectedSkill
                ? Consts
                    .secondaryColor // You can change the color for the selected item
                : Colors.white,
            onTap: () {
              onChanged!(option);
            },
          );
        },
      ),
    );
  }
}
