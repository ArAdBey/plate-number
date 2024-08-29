import 'dart:ffi';

import 'package:bloc/bloc.dart';

import '../model/plate_number.dart';

part 'plate_card_event.dart';

part 'plate_card_state.dart';

class PlateCardBloc extends Bloc<PlateCardEvent, PlateCardState> {
  final PlateType plateType;

  PlateCardBloc(this.plateType)
      : super(PlateCardState.emptyPlateCardState(plateType)) {
    on<ValueIsChanged>((ValueIsChanged event, Emitter emit) {
      final previousPlate = state.plateNumber;
      List newValues = [];
      for (int i = 0; i < previousPlate.values.length; i++) {
        if (i == event.index) {
          newValues.add(event.value);
        } else {
          newValues.add(previousPlate.values[i]);
        }
      }
      emit(
        state.copyWith(
          plateNumber: previousPlate.copyWith(
            values: newValues,
          ),
        ),
      );
    });
    on<RemovePlateCard>((RemovePlateCard event, Emitter emit) {
      emit(PlateCardState.emptyPlateCardState(state.plateType));
    });
    on<TypeIsChanged>((TypeIsChanged event, Emitter emit) {
      emit(PlateCardState.emptyPlateCardState(event.type));
    });
  }
}
