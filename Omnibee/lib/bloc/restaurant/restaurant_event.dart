part of 'restaurant_bloc.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class RestaurantLoaded extends RestaurantEvent {}

class RestaurantUpdated extends RestaurantEvent {
  final Restaurant restaurant;

  const RestaurantUpdated(this.restaurant);

  @override
  List<Object> get props => [restaurant];

  @override
  String toString() => 'LocationUpdated { restaurant: $restaurant }';
}

class RestaurantReset extends RestaurantEvent {}
