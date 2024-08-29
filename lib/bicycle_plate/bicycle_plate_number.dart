import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/plate_card_bloc.dart';
import '../tools.dart';
import '../widgets/plate_items.dart';
import '../widgets/remove_button.dart';
import '../widgets/special_clipper.dart';

class BicyclePlateNumber extends StatefulWidget {
  const BicyclePlateNumber({
    super.key,
    required this.activeColor,
    required this.inactiveColor,
    required this.backgroundColor,
    this.spacingScale = 6,
    this.removeIcon,
    this.textStyle,
    this.itemBorderRadius,
  });

  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final double spacingScale;
  final Widget? removeIcon;
  final TextStyle? textStyle;
  final BorderRadius? itemBorderRadius;

  @override
  State<BicyclePlateNumber> createState() => _BicyclePlateNumberState();
}

class _BicyclePlateNumberState extends State<BicyclePlateNumber> {
  List<FocusNode> focusNodes = [];
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    final plateNumber =
        BlocProvider.of<PlateCardBloc>(context).state.plateNumber;
    final valueTypes = plateNumber.valueTypes;
    for (int i = 0; i < valueTypes.length; i++) {
      final controller = TextEditingController();
      controller.text = (plateNumber.values[i] ?? '').toString();
      controllers.add(controller);
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
            vertical: widget.spacingScale * 2.5,
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
                  width: widget.spacingScale,
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
                          SizedBox(width: widget.spacingScale * 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: widget.spacingScale),
                              Row(
                                children: [
                                  IntegerPlateItem(
                                    activeColor: widget.activeColor,
                                    inactiveColor: widget.inactiveColor,
                                    borderRadius: widget.itemBorderRadius,
                                    textStyle: widget.textStyle,
                                    focusNode: focusNodes[2],
                                    controller: controllers[2],
                                    onCompleted: () =>
                                        focusNodes[3].requestFocus(),
                                    onChanged: (value) =>
                                        BlocProvider.of<PlateCardBloc>(context)
                                            .add(ValueIsChanged(
                                                index: 2, value: value)),
                                    onRemoved: () {
                                      BlocProvider.of<PlateCardBloc>(context)
                                          .add(ValueIsChanged(
                                              index: 2, value: ''));
                                    },
                                  ),
                                  SizedBox(width: widget.spacingScale * 2),
                                  IntegerPlateItem(
                                    activeColor: widget.activeColor,
                                    inactiveColor: widget.inactiveColor,
                                    borderRadius: widget.itemBorderRadius,
                                    textStyle: widget.textStyle,
                                    focusNode: focusNodes[1],
                                    controller: controllers[1],
                                    onCompleted: () =>
                                        focusNodes[2].requestFocus(),
                                    onChanged: (value) =>
                                        BlocProvider.of<PlateCardBloc>(context)
                                            .add(
                                      ValueIsChanged(index: 1, value: value),
                                    ),
                                    onRemoved: () {
                                      BlocProvider.of<PlateCardBloc>(context)
                                          .add(ValueIsChanged(
                                              index: 1, value: ''));
                                    },
                                  ),
                                  SizedBox(width: widget.spacingScale * 2),
                                  IntegerPlateItem(
                                    activeColor: widget.activeColor,
                                    inactiveColor: widget.inactiveColor,
                                    borderRadius: widget.itemBorderRadius,
                                    textStyle: widget.textStyle,
                                    focusNode: focusNodes[0],
                                    controller: controllers[0],
                                    onCompleted: () =>
                                        focusNodes[1].requestFocus(),
                                    onChanged: (value) =>
                                        BlocProvider.of<PlateCardBloc>(context)
                                            .add(ValueIsChanged(
                                                index: 0, value: value)),
                                    onRemoved: () {
                                      BlocProvider.of<PlateCardBloc>(context)
                                          .add(ValueIsChanged(
                                              index: 0, value: ''));
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: widget.spacingScale / 2),
                              Row(
                                children: [
                                  IntegerPlateItem(
                                    activeColor: widget.activeColor,
                                    inactiveColor: widget.inactiveColor,
                                    borderRadius: widget.itemBorderRadius,
                                    textStyle: widget.textStyle,
                                    focusNode: focusNodes[7],
                                    controller: controllers[7],
                                    onCompleted: () => focusNodes[7].unfocus(),
                                    onChanged: (value) =>
                                        BlocProvider.of<PlateCardBloc>(context)
                                            .add(ValueIsChanged(
                                                index: 7, value: value)),
                                    onRemoved: () {
                                      BlocProvider.of<PlateCardBloc>(context)
                                          .add(ValueIsChanged(
                                              index: 7, value: ''));
                                    },
                                  ),
                                  SizedBox(width: widget.spacingScale * 2),
                                  IntegerPlateItem(
                                    activeColor: widget.activeColor,
                                    inactiveColor: widget.inactiveColor,
                                    borderRadius: widget.itemBorderRadius,
                                    textStyle: widget.textStyle,
                                    focusNode: focusNodes[6],
                                    controller: controllers[6],
                                    onCompleted: () =>
                                        focusNodes[7].requestFocus(),
                                    onChanged: (value) =>
                                        BlocProvider.of<PlateCardBloc>(context)
                                            .add(ValueIsChanged(
                                                index: 6, value: value)),
                                    onRemoved: () {
                                      BlocProvider.of<PlateCardBloc>(context)
                                          .add(ValueIsChanged(
                                              index: 6, value: ''));
                                    },
                                  ),
                                  SizedBox(width: widget.spacingScale * 2),
                                  IntegerPlateItem(
                                    activeColor: widget.activeColor,
                                    inactiveColor: widget.inactiveColor,
                                    borderRadius: widget.itemBorderRadius,
                                    textStyle: widget.textStyle,
                                    focusNode: focusNodes[5],
                                    controller: controllers[5],
                                    onCompleted: () =>
                                        focusNodes[6].requestFocus(),
                                    onChanged: (value) =>
                                        BlocProvider.of<PlateCardBloc>(context)
                                            .add(ValueIsChanged(
                                                index: 5, value: value)),
                                    onRemoved: () {
                                      BlocProvider.of<PlateCardBloc>(context)
                                          .add(ValueIsChanged(
                                              index: 5, value: ''));
                                    },
                                  ),
                                  SizedBox(width: widget.spacingScale * 2),
                                  IntegerPlateItem(
                                    activeColor: widget.activeColor,
                                    inactiveColor: widget.inactiveColor,
                                    borderRadius: widget.itemBorderRadius,
                                    textStyle: widget.textStyle,
                                    focusNode: focusNodes[4],
                                    controller: controllers[4],
                                    onCompleted: () =>
                                        focusNodes[5].requestFocus(),
                                    onChanged: (value) =>
                                        BlocProvider.of<PlateCardBloc>(context)
                                            .add(ValueIsChanged(
                                                index: 4, value: value)),
                                    onRemoved: () {
                                      BlocProvider.of<PlateCardBloc>(context)
                                          .add(ValueIsChanged(
                                              index: 4, value: ''));
                                    },
                                  ),
                                  SizedBox(width: widget.spacingScale * 2),
                                  BlocBuilder<PlateCardBloc, PlateCardState>(
                                    builder: (BuildContext context, state) {
                                      return IntegerPlateItem(
                                        activeColor: widget.activeColor,
                                        inactiveColor: widget.inactiveColor,
                                        borderRadius: widget.itemBorderRadius,
                                        textStyle: widget.textStyle,
                                        focusNode: focusNodes[3],
                                        controller: controllers[3],
                                        onCompleted: () =>
                                            focusNodes[4].requestFocus(),
                                        onChanged: (value) =>
                                            BlocProvider.of<PlateCardBloc>(
                                                    context)
                                                .add(ValueIsChanged(
                                                    index: 3, value: value)),
                                        onRemoved: () {
                                          BlocProvider.of<PlateCardBloc>(
                                                  context)
                                              .add(ValueIsChanged(
                                                  index: 3, value: ''));
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: widget.spacingScale),
                            ],
                          ),
                          SizedBox(width: widget.spacingScale * 8),
                          Expanded(
                            child: Container(
                              color: plateNumber.isCompleted()
                                  ? widget.activeColor
                                  : widget.inactiveColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  RemoveButton(
                                    defaultRemoveIcon: widget.removeIcon,
                                    onPressed: () =>
                                        BlocProvider.of<PlateCardBloc>(context)
                                            .add(RemovePlateCard()),
                                    activeColor: widget.activeColor,
                                    inactiveColor: widget.inactiveColor,
                                  ),
                                ],
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
