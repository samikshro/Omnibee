import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:Henfam/models/models.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantLoadInProgress());

  @override
  Stream<RestaurantState> mapEventToState(
    RestaurantEvent event,
  ) async* {
    if (event is RestaurantLoaded) {
      yield* _mapRestaurantLoadedToState();
    } else if (event is RestaurantUpdated) {
      yield* _mapRestaurantUpdatedToState(event);
    } else if (event is RestaurantReset) {
      yield* _mapRestaurantResetToState();
    }
  }

  Stream<RestaurantState> _mapRestaurantLoadedToState() async* {
    try {
      yield RestaurantLoadSuccess(Restaurant());
    } catch (_) {
      yield RestaurantLoadFailure();
    }
  }

  Stream<RestaurantState> _mapRestaurantUpdatedToState(
    RestaurantUpdated event,
  ) async* {
    if (state is RestaurantLoadSuccess) {
      yield RestaurantLoadSuccess(event.restaurant);
    }
  }

  Stream<RestaurantState> _mapRestaurantResetToState() async* {
    if (state is RestaurantLoadSuccess) {
      yield RestaurantLoadSuccess(Restaurant());
    }
  }
}
