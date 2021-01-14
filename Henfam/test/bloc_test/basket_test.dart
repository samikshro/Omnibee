import 'package:Henfam/bloc/blocs.dart';
import 'package:Henfam/models/models.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';

void basketBlocTests() {
  group('BasketBloc', () {
    BasketBloc basketBloc;
    MenuItem superBlandTofu;

    setUp(() {
      basketBloc = BasketBloc();
      superBlandTofu = MenuItem(
        'Super Bland Tofu',
        "",
        100,
        ["Extra Tofu"],
        modifiersChosen: [],
      );
    });

    blocTest(
      'emits [] when nothing is added',
      build: () => basketBloc,
      expect: [],
    );

    blocTest(
      'BasketLoaded: emits BasketLoadSuccess',
      build: () => basketBloc,
      act: (BasketBloc bloc) async => bloc.add(BasketLoaded()),
      expect: <BasketState>[
        BasketLoadSuccess([], []),
      ],
    );

    blocTest(
      'MenuItemAdded: emits BasketLoadSuccess([superBlandTofu])',
      build: () => basketBloc,
      act: (BasketBloc bloc) async =>
          bloc..add(BasketLoaded())..add(MenuItemAdded(superBlandTofu)),
      expect: <BasketState>[
        BasketLoadSuccess([], []),
        BasketLoadSuccess(
          [
            MenuItem(
              'Super Bland Tofu',
              "",
              100,
              ['Extra Tofu'],
            ),
          ],
          [
            {
              'name': 'Super Bland Tofu',
              'price': 100.0,
              'add_ons': ['Extra Tofu'],
            }
          ],
        ),
      ],
    );

    blocTest(
      'MenuItemDeleted: emits BasketLoadSuccess([])',
      build: () => basketBloc,
      act: (BasketBloc bloc) async => bloc
        ..add(BasketLoaded())
        ..add(MenuItemAdded(superBlandTofu))
        ..add(MenuItemDeleted(superBlandTofu)),
      expect: <BasketState>[
        BasketLoadSuccess([], []),
        BasketLoadSuccess(
          [
            MenuItem(
              'Super Bland Tofu',
              "",
              100,
              ['Extra Tofu'],
            ),
          ],
          [
            {
              'name': 'Super Bland Tofu',
              'price': 100.0,
              'add_ons': ['Extra Tofu'],
            }
          ],
        ),
        BasketLoadSuccess([], [])
      ],
    );

    blocTest(
      'MenuItemReset: emits BasketLoadSuccess([])',
      build: () => basketBloc,
      act: (BasketBloc bloc) async => bloc
        ..add(BasketLoaded())
        ..add(MenuItemAdded(superBlandTofu))
        ..add(MenuItemAdded(superBlandTofu))
        ..add(BasketReset()),
      expect: <BasketState>[
        BasketLoadSuccess([], []),
        BasketLoadSuccess(
          [
            MenuItem(
              'Super Bland Tofu',
              "",
              100,
              ["Extra Tofu"],
            ),
          ],
          [
            {
              'name': 'Super Bland Tofu',
              'price': 100.0,
              'add_ons': ['Extra Tofu'],
            }
          ],
        ),
        BasketLoadSuccess(
          [
            MenuItem(
              'Super Bland Tofu',
              "",
              100,
              ["Extra Tofu"],
            ),
            MenuItem(
              'Super Bland Tofu',
              "",
              100,
              ["Extra Tofu"],
            ),
          ],
          [
            {
              'name': 'Super Bland Tofu',
              'price': 100.0,
              'add_ons': ['Extra Tofu'],
            },
            {
              'name': 'Super Bland Tofu',
              'price': 100.0,
              'add_ons': ['Extra Tofu'],
            }
          ],
        ),
        BasketLoadSuccess([], [])
      ],
    );

    tearDown(() {
      basketBloc?.close();
      superBlandTofu = null;
    });
  });
}

main() {
  basketBlocTests();
}
