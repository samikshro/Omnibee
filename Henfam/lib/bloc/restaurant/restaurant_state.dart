part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

class RestaurantLoadInProgress extends RestaurantState {}

class RestaurantLoadSuccess extends RestaurantState {
  final Restaurant restaurant;

  const RestaurantLoadSuccess(this.restaurant);

  @override
  List<Object> get props => [restaurant];

  @override
  String toString() => 'RestaurantLoadSuccess { restaurant: $restaurant }';
}

class RestaurantLoadFailure extends RestaurantState {}
