import 'dart:ffi' as ffi;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/plate_card_bloc.dart';
import '../constants.dart';
import '../tools.dart';
import '../widgets/plate_items.dart';
import '../widgets/remove_button.dart';
import '../widgets/special_clipper.dart';
import 'letter_picker.dart';

class CarPlateNumber extends StatefulWidget {
  const CarPlateNumber({
    super.key,
    required this.activeColor,
    required this.inactiveColor,
    required this.backgroundColor,
    this.spacingScale = 6,
    this.letterIcon,
    this.countryName,
    this.removeIcon,
    this.chooseLetterTextStyle,
    this.itemBorderRadius,
    this.numberTextStyle,
    this.letterTextStyle,
    this.onChooseLetter,
  });

  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final double spacingScale;
  final Widget? letterIcon;
  final Widget? countryName;
  final Widget? removeIcon;
  final TextStyle? chooseLetterTextStyle;
  final TextStyle? numberTextStyle;
  final TextStyle? letterTextStyle;
  final BorderRadius? itemBorderRadius;
  final VoidCallback? onChooseLetter;

  @override
  State<CarPlateNumber> createState() => _CarPlateNumberState();
}

class _CarPlateNumberState extends State<CarPlateNumber> {
  List<FocusNode> focusNodes = [];
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    final plateNumber =
        BlocProvider.of<PlateCardBloc>(context).state.plateNumber;
    final valueTypes = plateNumber.valueTypes;
    for (int i = 0; i < valueTypes.length; i++) {
      final valueType = valueTypes[i];
      if (valueType == ffi.Int) {
        final controller = TextEditingController();
        controller.text = (plateNumber.values[i] ?? '').toString();
        controllers.add(controller);
      }
      focusNodes.add(FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlateCardBloc, PlateCardState>(
      builder: (BuildContext context, PlateCardState state) {
        final plateNumber = state.plateNumber;
        if (state.plateNumber.isEmpty()) {
          for (TextEditingController controller in controllers) {
            controller.text = "";
          }
        }
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: widget.spacingScale * 3,
            horizontal: widget.spacingScale,
          ),
          child: ClipRRect(
            clipper: SpecialClipper(),
            clipBehavior: Clip.hardEdge,
            child: Container(
              decoration: BoxDecoration(
                color: plateNumber.isCompleted()
                    ? widget.activeColor
                    : widget.inactiveColor,
                border: Border.all(
                  color: plateNumber.isCompleted()
                      ? widget.activeColor
                      : widget.inactiveColor,
                  width: widget.spacingScale / 1.5,
                ),
              ),
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                clipper: SpecialClipper(),
                child: Container(
                  color: widget.backgroundColor,
                  child: IntrinsicHeight(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: widget.spacingScale * 2,
                              ),
                              widget.countryName ?? const Text('Iran'),
                              SizedBox(
                                height: widget.spacingScale,
                              ),
                              Row(
                                children: [
                                  Container(width: widget.spacingScale),
                                  Row(
                                    children: [
                                      IntegerPlateItem(
                                        backgroundColor: widget.backgroundColor,
                                        inactiveColor: widget.inactiveColor,
                                        activeColor: widget.activeColor,
                                        borderRadius: widget.itemBorderRadius,
                                        textStyle: widget.numberTextStyle,
                                        focusNode: focusNodes[6],
                                        controller: controllers[6],
                                        onCompleted: () =>
                                            focusNodes[6].unfocus(),
                                        onChanged: (value) =>
                                            BlocProvider.of<PlateCardBloc>(
                                                    context)
                                                .add(ValueIsChanged(
                                                    index: 7, value: value)),
                                        onRemoved: () =>
                                            BlocProvider.of<PlateCardBloc>(
                                                    context)
                                                .add(ValueIsChanged(
                                                    index: 7, value: '')),
                                      ),
                                      SizedBox(
                                          width: widget.spacingScale / 1.5),
                                      IntegerPlateItem(
                                        backgroundColor: widget.backgroundColor,
                                        inactiveColor: widget.inactiveColor,
                                        activeColor: widget.activeColor,
                                        borderRadius: widget.itemBorderRadius,
                                        textStyle: widget.numberTextStyle,
                                        focusNode: focusNodes[5],
                                        controller: controllers[5],
                                        onCompleted: () =>
                                            focusNodes[6].requestFocus(),
                                        onChanged: (value) =>
                                            BlocProvider.of<PlateCardBloc>(
                                                    context)
                                                .add(
                                          ValueIsChanged(
                                              index: 6, value: value),
                                        ),
                                        onRemoved: () =>
                                            BlocProvider.of<PlateCardBloc>(
                                                    context)
                                                .add(ValueIsChanged(
                                                    index: 6, value: '')),
                                      ),
                                    ],
                                  ),
                                  Container(width: widget.spacingScale),
                                ],
                              ),
                              SizedBox(
                                height: widget.spacingScale,
                              ),
                            ],
                          ),
                          VerticalDivider(
                            color: plateNumber.isCompleted()
                                ? widget.activeColor
                                : widget.inactiveColor,
                            width: widget.spacingScale / 3,
                            thickness: widget.spacingScale / 3,
                          ),
                          SizedBox(width: widget.spacingScale),
                          Row(
                            children: [
                              IntegerPlateItem(
                                backgroundColor: widget.backgroundColor,
                                inactiveColor: widget.inactiveColor,
                                activeColor: widget.activeColor,
                                borderRadius: widget.itemBorderRadius,
                                focusNode: focusNodes[4],
                                controller: controllers[4],
                                textStyle: widget.numberTextStyle,
                                onCompleted: () => focusNodes[5].requestFocus(),
                                onChanged: (value) =>
                                    BlocProvider.of<PlateCardBloc>(context).add(
                                        ValueIsChanged(index: 5, value: value)),
                                onRemoved: () =>
                                    BlocProvider.of<PlateCardBloc>(context).add(
                                        ValueIsChanged(index: 5, value: '')),
                              ),
                              SizedBox(width: widget.spacingScale / 1.5),
                              IntegerPlateItem(
                                backgroundColor: widget.backgroundColor,
                                inactiveColor: widget.inactiveColor,
                                activeColor: widget.activeColor,
                                borderRadius: widget.itemBorderRadius,
                                focusNode: focusNodes[3],
                                controller: controllers[3],
                                onCompleted: () => focusNodes[4].requestFocus(),
                                onChanged: (value) =>
                                    BlocProvider.of<PlateCardBloc>(context).add(
                                        ValueIsChanged(index: 4, value: value)),
                                onRemoved: () =>
                                    BlocProvider.of<PlateCardBloc>(context).add(
                                        ValueIsChanged(index: 4, value: '')),
                                textStyle: widget.numberTextStyle,
                              ),
                              SizedBox(width: widget.spacingScale / 1.5),
                              IntegerPlateItem(
                                backgroundColor: widget.backgroundColor,
                                inactiveColor: widget.inactiveColor,
                                activeColor: widget.activeColor,
                                borderRadius: widget.itemBorderRadius,
                                focusNode: focusNodes[2],
                                controller: controllers[2],
                                onCompleted: () => focusNodes[3].requestFocus(),
                                onChanged: (value) =>
                                    BlocProvider.of<PlateCardBloc>(context).add(
                                        ValueIsChanged(index: 3, value: value)),
                                textStyle: widget.numberTextStyle,
                                onRemoved: () =>
                                    BlocProvider.of<PlateCardBloc>(context).add(
                                        ValueIsChanged(index: 3, value: '')),
                              ),
                              SizedBox(width: widget.spacingScale / 1.5),
                              StringPlateItem(
                                width: (widget.spacingScale * 5).toInt(),
                                height: (widget.spacingScale * 10).toInt(),
                                defaultLetterIcon: widget.letterIcon,
                                borderRadius: widget.itemBorderRadius,
                                textStyle: widget.letterTextStyle,
                                indexInPlateTypes: 2,
                                activeColor: widget.activeColor,
                                inactiveColor: widget.inactiveColor,
                                onPressed: widget.onChooseLetter ??
                                    () async {
                                      String selectedValue = '';
                                      await showModalBottomSheet<String>(
                                          context: context,
                                          builder: (builder) {
                                            return LetterPicker(
                                              onSelectedItemChanged:
                                                  (int value) {
                                                selectedValue =
                                                    persianCarPlateLetters[
                                                        value];
                                              },
                                            );
                                          });
                                      BlocProvider.of<PlateCardBloc>(context)
                                          .add(
                                        ValueIsChanged(
                                          index: 2,
                                          value: selectedValue,
                                        ),
                                      );
                                    },
                              ),
                              SizedBox(width: widget.spacingScale / 1.5),
                              IntegerPlateItem(
                                backgroundColor: widget.backgroundColor,
                                inactiveColor: widget.inactiveColor,
                                activeColor: widget.activeColor,
                                borderRadius: widget.itemBorderRadius,
                                textStyle: widget.numberTextStyle,
                                focusNode: focusNodes[1],
                                controller: controllers[1],
                                onCompleted: widget.onChooseLetter ??
                                    () async {
                                      String selectedValue = '';
                                      await showModalBottomSheet<String>(
                                          context: context,
                                          builder: (builder) {
                                            return LetterPicker(
                                              onSelectedItemChanged:
                                                  (int value) {
                                                selectedValue =
                                                    persianCarPlateLetters[
                                                        value];
                                              },
                                            );
                                          });
                                      BlocProvider.of<PlateCardBloc>(context)
                                          .add(ValueIsChanged(
                                              index: 2, value: selectedValue));
                                      focusNodes[2].requestFocus();
                                    },
                                onChanged: (value) =>
                                    BlocProvider.of<PlateCardBloc>(context).add(
                                        ValueIsChanged(index: 1, value: value)),
                                onRemoved: () =>
                                    BlocProvider.of<PlateCardBloc>(context).add(
                                        ValueIsChanged(index: 1, value: '')),
                              ),
                              SizedBox(width: widget.spacingScale / 1.5),
                              IntegerPlateItem(
                                backgroundColor: widget.backgroundColor,
                                inactiveColor: widget.inactiveColor,
                                activeColor: widget.activeColor,
                                borderRadius: widget.itemBorderRadius,
                                textStyle: widget.numberTextStyle,
                                focusNode: focusNodes[0],
                                controller: controllers[0],
                                onCompleted: () => focusNodes[1].requestFocus(),
                                onChanged: (value) =>
                                    BlocProvider.of<PlateCardBloc>(context).add(
                                        ValueIsChanged(index: 0, value: value)),
                                onRemoved: () =>
                                    BlocProvider.of<PlateCardBloc>(context).add(
                                        ValueIsChanged(index: 0, value: '')),
                              ),
                            ],
                          ),
                          SizedBox(width: widget.spacingScale),
                          Flexible(
                            child: Container(
                              color: plateNumber.isCompleted()
                                  ? widget.activeColor
                                  : widget.inactiveColor,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: RemoveButton(
                                  defaultRemoveIcon: widget.removeIcon,
                                  onPressed: () =>
                                      BlocProvider.of<PlateCardBloc>(context)
                                          .add(RemovePlateCard()),
                                  activeColor: widget.activeColor,
                                  inactiveColor: widget.inactiveColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
