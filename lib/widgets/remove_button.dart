import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plate_number/tools.dart';

import '../bloc/plate_card_bloc.dart';

class RemoveButton extends StatelessWidget {
  const RemoveButton(
      {super.key,
      required this.defaultRemoveIcon,
      this.onPressed,
      this.activeColor,
      this.inactiveColor});

  final Widget? defaultRemoveIcon;
  final VoidCallback? onPressed;
  final Color? activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: BlocBuilder<PlateCardBloc, PlateCardState>(
        builder: (BuildContext context, PlateCardState state) {
          return defaultRemoveIcon ??
              Icon(
                Icons.delete_forever,
                color: (state.plateNumber.isCompleted()
                        ? inactiveColor
                        : activeColor) ??
                    Colors.red,
              );
        },
      ),
    );
  }
}
