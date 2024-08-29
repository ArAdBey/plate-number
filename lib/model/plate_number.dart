class PlateNumber {
  final List values;
  final List valueTypes;

  PlateNumber({required this.values, required this.valueTypes});

  PlateNumber copyWith({List? values, List? valueTypes}) {
    return PlateNumber(
      values: values ?? this.values,
      valueTypes: valueTypes ?? this.valueTypes,
    );
  }
}

abstract final class SelectableString {
  const SelectableString();
}

enum PlateType {
  irBicycle,
  irCar,
}

extension Tool on PlateType {
  String vehicleType() {
    switch (this) {
      case PlateType.irBicycle:
        return 'bicycle';
      case PlateType.irCar:
        return 'car';
    }
  }

  String parseToString() {
    switch (this) {
      case PlateType.irBicycle:
        return 'irBicycle';
      case PlateType.irCar:
        return 'irCar';
    }
  }
}
