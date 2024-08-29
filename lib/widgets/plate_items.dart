import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/plate_card_bloc.dart';
import '../tools.dart';

class StringPlateItem extends StatelessWidget {
  const StringPlateItem({
    super.key,
    required this.onPressed,
    required this.indexInPlateTypes,
    this.defaultLetterIcon,
    this.textStyle,
    this.borderRadius,
    required this.width,
    required this.height,
    this.inactiveColor,
    this.activeColor,
  });

  final VoidCallback? onPressed;
  final int indexInPlateTypes;
  final int width;
  final int height;
  final Widget? defaultLetterIcon;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final Color? inactiveColor;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getPlateCardElementWidth(context),
      height: getPlateCardElementHeight(context),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: BlocBuilder<PlateCardBloc, PlateCardState>(
            builder: (BuildContext context, PlateCardState state) {
          return Container(
            width: getPlateCardElementWidth(context),
            height: getPlateCardElementHeight(context),
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(8),
              border: Border.all(
                color: (state.plateNumber.values[indexInPlateTypes] == null
                        ? inactiveColor
                        : activeColor) ??
                    Colors.grey,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: Center(
              child: state.plateNumber.values[indexInPlateTypes] == null
                  ? defaultLetterIcon ??
                      Icon(
                        Icons.question_mark,
                        color: activeColor,
                      )
                  : Text(
                      state.plateNumber.values[indexInPlateTypes]!,
                      style: textStyle,
                    ),
            ),
          );
        }),
      ),
    );
  }
}

class IntegerPlateItem extends StatelessWidget {
  const IntegerPlateItem(
      {super.key,
      required this.focusNode,
      required this.onChanged,
      required this.controller,
      required this.onCompleted,
      required this.textStyle,
      this.borderRadius,
      this.activeColor,
      this.inactiveColor,
      this.onRemoved,
      this.backgroundColor});

  final FocusNode focusNode;
  final void Function(String) onChanged;
  final void Function()? onCompleted;
  final void Function()? onRemoved;
  final TextEditingController controller;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getPlateCardElementWidth(context),
      height: getPlateCardElementHeight(context),
      child: Theme(
        data: ThemeData.light().copyWith(
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: activeColor,
            cursorColor: activeColor,
            selectionHandleColor: activeColor,
          ),
        ),
        child: TextField(
          controller: controller,
          style: textStyle,
          cursorColor: activeColor,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12),
              borderSide: BorderSide(
                color: (controller.text == '' ? inactiveColor : activeColor) ??
                    Colors.grey,
              ),
            ),
            counterText: "",
          ),
          onChanged: (value) {
            if (value.isDigit()) {
              onChanged(value);
              if (value != '') {
                if (onCompleted != null) onCompleted!();
              }
            } else {
              controller.text = '';
              if (onRemoved != null) onRemoved!();
            }
          },
          focusNode: focusNode,
          maxLength: 1,
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}

double getPlateCardElementWidth(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.087;
}

double getPlateCardElementHeight(BuildContext context) {
  return MediaQuery.of(context).size.height * 0.065;
}
