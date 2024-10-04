import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/constants.dart';

class CustomField extends StatefulWidget {
  final double? width;
  final double? height;

  final Function(String) setValue;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  final bool obscureText;
  final String? initialValue;
  final String? hintText;
  final String? unit;
  final int? maxLines;

  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  final List<TextInputFormatter>? textFormatters;
  final TextEditingController? controller;

  final bool readOnly;

  const CustomField({
    Key? key,
    this.width,
    this.height,
    required this.setValue,
    this.obscureText = false,
    this.keyboardType = TextInputType.visiblePassword,
    this.validator,
    this.initialValue,
    this.controller,
    this.readOnly = false,
    this.hintText,
    this.maxLines = 1,
    this.textFormatters,
    this.unit,
    this.focusNode,
    this.nextFocusNode,
  }) : super(key: key);

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    var devHeight = SizeConfig.getHeight(context);
    var devWidth = SizeConfig.getWidth(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: devWidth * 0.05),
      child: SizedBox(
        width: (widget.width != null) ? widget.width! * devWidth : null,
        height: (widget.height != null) ? widget.height! * devHeight : null,
        child: TextFormField(
          maxLines: widget.maxLines,
          readOnly: widget.readOnly,
          controller: widget.controller,
          initialValue: widget.initialValue,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          cursorColor: Colors.black,
          inputFormatters: widget.textFormatters,
          style: TextStyle(
              fontSize: devWidth * 0.04,
              color: Theme.of(context).colorScheme.secondary),
          onChanged: (value) {
            widget.setValue(value);
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).primaryColor,

            border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.secondary),
                borderRadius:
                    BorderRadius.all(Radius.circular(devWidth * 0.05))),
            label: Text(
              widget.hintText ?? "",
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),

            suffixText: widget.unit,
            // Text(widget.unit ?? "",
            //     style: const TextStyle(
            //         fontWeight: FontWeight.w200, color: Colors.grey))
          ),
          obscureText: widget.obscureText,
        ),
      ),
    );
  }

  // Form formChild(height) {
  //   return Form(
  //     key: widget.formKey,
  //     child: TextFormField(
  //       maxLines: widget.maxLines,
  //       readOnly: widget.readOnly,
  //       controller: widget.controller,
  //       initialValue: widget.initialValue,
  //       validator: widget.validator,
  //       keyboardType: widget.keyboardType,
  //       cursorColor: Colors.black,
  //       inputFormatters: widget.textFormatters,
  //       style: TextStyle(fontSize: height * 0.018),
  //       onChanged: (value) {
  //         widget.setValue(value);
  //       },
  //       decoration: InputDecoration(
  //           filled: true,
  //           fillColor: Platform.isIOS
  //               ? const Color.fromRGBO(235, 235, 235, 1)
  //               : Colors.white,
  //           border: Platform.isIOS
  //               ? const OutlineInputBorder(
  //                   borderSide: BorderSide.none,
  //                   borderRadius: BorderRadius.all(Radius.circular(10)))
  //               : const OutlineInputBorder(
  //                   borderRadius: BorderRadius.all(Radius.circular(10))),
  //           hintText: widget.hintText),
  //       obscureText: widget.obscureText,
  //     ),
  //   );
  // }
}

class CustomTextInputWidget extends StatelessWidget {
  const CustomTextInputWidget({
    super.key,
    required this.width,
    required this.height,
    this.filledColor,
    this.borderColor,
    this.focusedBorderColor,
    this.textAlign,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText,
    this.initialValue,
    this.hintText,
    this.unit,
    this.maxLines,
    this.textFormatters,
    this.focusNode,
    this.nextFocusNode,
  });

  final double width;
  final double height;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  final Color? filledColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final TextAlign? textAlign;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? initialValue;
  final String? hintText;
  final String? unit;
  final int? maxLines;
  final List<TextInputFormatter>? textFormatters;

  @override
  Widget build(BuildContext context) {
    var devHeight = SizeConfig.getHeight(context);
    var devWidth = SizeConfig.getWidth(context);
    return Container(
      width: width * devWidth,
      height: height * devHeight,
      padding: EdgeInsets.symmetric(horizontal: devWidth * 0.05),
      decoration: BoxDecoration(
        color: filledColor ?? Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText ?? false,
        obscuringCharacter: 'x',
        initialValue: initialValue,
        validator: validator,
        keyboardType: keyboardType,
        cursorColor: Colors.black,
        inputFormatters: textFormatters,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        style: TextStyle(
            fontSize: devWidth * 0.04,
            color: Theme.of(context).colorScheme.primary),
        onFieldSubmitted: (value) => (nextFocusNode != null)
            ? FocusScope.of(context).requestFocus(nextFocusNode)
            : null,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: devWidth * 0.05),
          contentPadding: EdgeInsets.zero,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? const Color(0x00000000),
              width: 1,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: focusedBorderColor ?? const Color(0x00000000),
              width: 1,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
        ),
      ),
    );
  }
}
