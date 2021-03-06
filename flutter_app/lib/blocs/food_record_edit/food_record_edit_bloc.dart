///*
// * Copyright (c) 2019. Dennis Krasnov. All rights reserved.
// * Use of this source code is governed by the MIT license that can be found in the LICENSE file.
// */
//
//import 'package:bloc/bloc.dart';
//import 'package:meta/meta.dart';
//
//import 'package:diet_driven/blocs/food_record_edit/food_record_edit.dart';
//import 'package:diet_driven/models/models.dart';
//import 'package:diet_driven/repositories/repositories.dart';
//
//class FoodRecordEditBloc extends Bloc<FoodRecordEditEvent, FoodRecordEditState> {
//  final FoodRecord initialFoodRecord;
//  final String userId;
//  final int daysSinceEpoch;
//  final DiaryRepository diaryRepository;
//  // TODO: final boolean live instead of final void Function(FoodRecord) saveAction;
//
//  FoodRecordEditBloc({
//    @required this.initialFoodRecord,
//    @required this.userId,
//    @required this.daysSinceEpoch,
//    @required this.diaryRepository,
//  }) :
//    assert(initialFoodRecord != null),
//    assert(userId != null),
//    assert(daysSinceEpoch >= 0),
//    assert(diaryRepository != null);
//
//  @override
//  FoodRecordEditState get initialState => FoodRecordEditState((b) => b..foodRecord = initialFoodRecord.toBuilder());
//
//  @override
//  Stream<FoodRecordEditState> mapEventToState(FoodRecordEditEvent event) async* {
//    if (event is UpdateQuantity) {
//      // TOTEST
//      assert(event.grams.isFinite);
//      assert(event.grams <= 100000);
//      if (event.grams.isNegative || event.grams == 0) {
//        yield state.rebuild((b) => b
//          ..quantityError = "Grams must be positive"
//        );
//      }
//      else {
//        yield state.rebuild((b) => b..
//          foodRecord = state.foodRecord.rebuild((b) => b
//            ..grams = event.grams // TODO: round here instead!? - function in bloc utils
//          ).toBuilder()
//          ..quantityError = null
//        );
////        logger.i("Grams updated to ${event.grams}");
//      }
//    }
//
//    if (event is DeleteFoodRecord) {
////      try {
////        diaryRepository.deleteFoodRecord(userId, daysSinceEpoch, currentState.foodRecord);
////        event.completer?.complete();
////
//////        logger.i("${currentState.foodRecord} deleted");
////      } on Exception catch(e) {
////        event.completer?.completeError(e);
////      }
//    }
//
//    if (event is SaveFoodRecord) {
////      logger.i("save food record does nothing!");
//      // Can't edit unchanged food record
////      if (initialFoodRecord != currentState.foodRecord) {
////        saveAction(currentState.foodRecord);
////      }
//      // OPTIMIZE: I can't check != here since I also use this for single add, could be same if didn't change anything!
////      saveAction(currentState.foodRecord);
//
//    }
//  }
//}
//
//
