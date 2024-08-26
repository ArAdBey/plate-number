import 'package:flutter/cupertino.dart';

import '../constants.dart';

class LetterPicker extends StatefulWidget {
  const LetterPicker({
    super.key,
    this.initial,
    this.sizeScale = 100,
    this.textStyle,
    this.onSelectedItemChanged,
  });

  final String? initial;
  final double sizeScale;
  final TextStyle? textStyle;
  final ValueChanged<int>? onSelectedItemChanged;

  @override
  State<LetterPicker> createState() => _LetterPickerState();
}

class _LetterPickerState extends State<LetterPicker> {
  late FixedExtentScrollController controller;

  @override
  void initState() {
    controller = FixedExtentScrollController(
        initialItem: persianCarPlateLetters
            .indexOf(widget.initial ?? persianCarPlateLetters[0]));
    widget.onSelectedItemChanged!(persianCarPlateLetters
        .indexOf(widget.initial ?? persianCarPlateLetters[0]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      scrollController: controller,
      itemExtent: widget.sizeScale / 2,
      onSelectedItemChanged: widget.onSelectedItemChanged,
      children: List<Widget>.generate(
        persianCarPlateLetters.length,
        (index) => Text(
          persianCarPlateLetters[index],
          style: widget.textStyle,
        ),
      ),
    );
  }
}
