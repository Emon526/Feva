import 'package:feva/utils/utils.dart';
import 'package:flutter/material.dart';

import '../consts/consts.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final TextInputAction? textInputAction;
  final TextInputType textInputType;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final String? Function(String?) validator;
  final bool? readOnly;
  final String inputname;

  const InputWidget({
    super.key,
    required this.textEditingController,
    required this.labelText,
    required this.inputname,
    this.textInputAction,
    required this.textInputType,
    required this.onChanged,
    required this.validator,
    this.onFieldSubmitted,
    this.onTap,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          inputname,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: Utils(context).getScreenSize.height * 0.01,
        ),
        TextFormField(
          readOnly: readOnly ?? false,
          validator: validator,
          controller: textEditingController,
          textInputAction: textInputAction ?? TextInputAction.next,
          keyboardType: textInputType,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            filled: true,
            // labelText: labelText,
            // label: Text(labelText),
            hintText: labelText,
            enabledBorder: InputBorder.none,
            // border: const OutlineInputBorder(),
            // labelStyle: const TextStyle(color: Consts.primaryColor),
            // enabledBorder: const OutlineInputBorder(
            //     borderSide: BorderSide(color: Consts.primaryColor)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Consts.primaryColor)),
          ),
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          onTap: onTap,
        ),
      ],
    );
  }
}
