import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:diet_driven/blocs/blocs.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:diet_driven/blocs/food_logging/food_logging.dart';
import 'package:diet_driven/models/models.dart';
import 'package:diet_driven/repositories/repositories.dart';

///
class FoodLoggingBloc extends Bloc<FoodLoggingEvent, FoodLoggingState> {
  final Logger _log = new Logger("food logging bloc");
  final FoodRepository foodRepository;
  final String userId;
  final int mealIndex;
  final bool startWithMultiSelect;
  final FoodDiaryLoaded foodDiaryLoaded;

  FoodLoggingBloc({
    @required this.foodRepository,
    @required this.userId,
    this.mealIndex: 0, // TODO: guess from time using
    @required this.startWithMultiSelect,
    @required this.foodDiaryLoaded
  }) {
    assert(foodRepository != null);
    assert(userId != null && userId.isNotEmpty);
    assert(0 <= mealIndex && mealIndex <= 6);

    assert(foodDiaryLoaded != null);
  }

  @override
  FoodLoggingState get initialState => FoodLoggingState((b) => b
    ..mealIndex = mealIndex
    ..multiSelect = startWithMultiSelect
    ..selectedFoodRecords = ListBuilder([])
    ..diaryFoodRecords = foodDiaryLoaded.foodDiaryDay.foodRecords.toBuilder()
  );

  @override
  Stream<FoodLoggingState> mapEventToState(FoodLoggingEvent event) async* {
    if (event is ChangeMeal) {
      yield currentState.rebuild((b) => b
        ..mealIndex = event.mealIndex
        ..selectedFoodRecords = ListBuilder(currentState.selectedFoodRecords.map((foodRecord) =>
          foodRecord.rebuild((b) => b
            ..mealIndex = mealIndex
          )
        ))
      );
    }

    if (event is AddToSelection) {
      assert(currentState.multiSelect);

      yield currentState.rebuild((b) => b
        ..selectedFoodRecords = currentState.selectedFoodRecords.rebuild((b) =>
          b.add(event.foodRecord.rebuild((b) => b
            ..mealIndex = mealIndex
          ))
        ).toBuilder()
      );
    }

    if (event is RemoveFromSelection) {
      assert(currentState.multiSelect);
      assert(currentState.selectedFoodRecords.contains(event.foodRecord));

      bool selectionWillBecomeEmpty = currentState.selectedFoodRecords.length == 1;

      yield currentState.rebuild((b) => b
        ..multiSelect = !selectionWillBecomeEmpty
        ..selectedFoodRecords = currentState.selectedFoodRecords.rebuild((b) => b.remove(event.foodRecord)).toBuilder()
      );
    }

    if (event is ReplaceSelected) {
      assert(currentState.multiSelect);

      if (event.oldRecord != event.newRecord) {
        // OPTIMIZE: find more elegant way of mutating array twice.
        yield currentState.rebuild((b) => b
          ..selectedFoodRecords = currentState.selectedFoodRecords.rebuild((b) => b
            .remove(event.oldRecord)
          ).rebuild((b) => b
            .add(event.newRecord)
          ).toBuilder()
        );
      }
    }

    if (event is StartMultiSelect) {
      assert(!currentState.multiSelect);
      assert(currentState.selectedFoodRecords.isEmpty);

      yield currentState.rebuild((b) => b
        ..multiSelect = true
      );
    }

    if (event is CancelMultiSelect) {
      assert(currentState.multiSelect);

      yield currentState.rebuild((b) => b
        ..multiSelect = false
        ..selectedFoodRecords = ListBuilder([])
      );
    }
  }
}


