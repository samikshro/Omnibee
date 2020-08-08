import 'package:Henfam/bloc/blocs.dart';
import 'package:Henfam/models/models.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';

main() {
  group('BasketBloc', () {
    BasketBloc basketBloc;
    MenuItem superBlandTofu;
    MenuItem extraTofu;

    setUp(() {
      basketBloc = BasketBloc();
      extraTofu = MenuItem('Extra Tofu', 0, []);
      superBlandTofu = MenuItem('Super Bland Tofu', 100, [extraTofu]);
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
              100,
              [MenuItem('Extra Tofu', 0, [])],
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
              100,
              [MenuItem('Extra Tofu', 0, [])],
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

    tearDown(() {
      basketBloc = null;
      superBlandTofu = null;
      extraTofu = null;
    });
  });
}
