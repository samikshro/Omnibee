import 'package:Henfam/bloc/blocs.dart';
import 'package:Henfam/models/models.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';

main() {
  group('RestaurantBloc', () {
    RestaurantBloc restaurantBloc;

    setUp(() {
      restaurantBloc = RestaurantBloc();
    });

    blocTest(
      'emits [] when nothing is added',
      build: () => RestaurantBloc(),
      expect: [],
    );

    blocTest(
      'emits BasketLoadSuccess when BasketLoaded added',
      build: () => restaurantBloc,
      act: (RestaurantBloc bloc) async => bloc.add(RestaurantLoaded()),
      expect: <BasketState>[
        BasketLoadSuccess([]),
      ],
    );

    blocTest(
      'emits BasketLoadSuccess([tofu]) when tofu added',
      build: () => restaurantBloc,
      act: (RestaurantBloc bloc) async => bloc
        ..add(RestaurantLoaded())
        ..add(RestaurantUpdated(Restaurant(name: 'hello'))),
      expect: <RestaurantState>[
        RestaurantLoadSuccess(Restaurant()),
        RestaurantLoadSuccess(Restaurant(name: 'hello')),
      ],
    );

    blocTest(
      'MenuItemDeleted: emits [] when menu item is added then deleted',
      build: () => restaurantBloc,
      act: (RestaurantBloc bloc) async => bloc
        ..add(RestaurantLoaded())
        ..add(RestaurantUpdated(Restaurant(name: 'hello')))
        ..add(RestaurantReset()),
      expect: <RestaurantState>[
        RestaurantLoadSuccess(Restaurant()),
        RestaurantLoadSuccess(Restaurant(name: 'hello')),
        RestaurantLoadSuccess(Restaurant()),
      ],
    );

    tearDown(() {
      restaurantBloc = null;
    });
  });
}
