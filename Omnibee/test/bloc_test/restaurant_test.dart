import 'package:Omnibee/bloc/blocs.dart';
import 'package:Omnibee/models/models.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';

void restaurantBlocTests() {
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
      'RestaurantLoaded: emits RestaurantLoadSuccess when RestaurantLoaded added',
      build: () => restaurantBloc,
      act: (RestaurantBloc bloc) async => bloc.add(RestaurantLoaded()),
      expect: <RestaurantState>[
        RestaurantLoadSuccess(Restaurant()),
      ],
    );

    blocTest(
      'RestaurantUpdated: emits helloRestaurant when helloRestaurant added',
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
      'RestaurantReset: emits empty restaurant when reset',
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
      restaurantBloc?.close();
    });
  });
}

main() {
  restaurantBlocTests();
}
