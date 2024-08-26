import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/plate_card_bloc.dart';
import '../model/plate_number.dart';
import '../tools.dart';

class ShowPlate extends StatelessWidget {
  const ShowPlate({super.key, this.emptyPlate, this.textStyle});

  final Widget? emptyPlate;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlateCardBloc, PlateCardState>(
      builder: (context, state) {
        if (state.plateNumber.isEmpty()) {
          return emptyPlate ?? const Text('Default Empty Value');
        }
        if (state.plateType == PlateType.irCar) {
          return IrCarShow(
            values: state.plateNumber.values,
            textStyle: textStyle,
          );
        }
        if (state.plateType == PlateType.irBicycle) {
          return IrBicycleShow(
            values: state.plateNumber.values,
            textStyle: textStyle,
          );
        }
        return const Placeholder();
      },
    );
  }
}

class IrCarShow extends StatelessWidget {
  const IrCarShow({super.key, required this.values, this.textStyle});

  final List values;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: textStyle ?? const TextStyle(color: Colors.black),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (values[7] != null || values[6] != null)
              Text('IR ${values[6] ?? ""}${values[7] ?? ""}'),
            Text('${values[3] ?? ""}${values[4] ?? ""}${values[5] ?? ""}'),
            Text(values[2] ?? ""),
            Text('${values[0] ?? ""}${values[1] ?? ""}', style: textStyle),
          ],
        ),
      ),
    );
  }
}

class IrBicycleShow extends StatelessWidget {
  const IrBicycleShow({super.key, this.textStyle, required this.values});

  final TextStyle? textStyle;
  final List values;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: textStyle ?? const TextStyle(color: Colors.black),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List<Text>.generate(
            8,
            (index) => Text(values[7 - index] ?? ""),
          ),
        ),
      ),
    );
  }
}
