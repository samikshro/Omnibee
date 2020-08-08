import 'package:Henfam/bloc/blocs.dart';
import 'package:Henfam/models/models.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';

main() {
  group('BasketBloc', () {
    BasketBloc basketBloc;
    MenuItem superBlandTofu;

    setUp(() {
      basketBloc = BasketBloc();
      superBlandTofu = MenuItem('Super Bland Tofu', 100, []);
    });

    blocTest(
      'emits [] when nothing is added',
      build: () => basketBloc,
      expect: [],
    );

    blocTest(
      'BasketLoaded: emits BasketLoadSucess',
      build: () => basketBloc,
      act: (BasketBloc bloc) async => bloc.add(BasketLoaded()),
      expect: <BasketState>[
        BasketLoadSuccess([]),
      ],
    );

    blocTest(
      'MenuItemAdded: emits BasketLoadSucess([superBlandTofu])',
      build: () => basketBloc,
      act: (BasketBloc bloc) async =>
          bloc..add(BasketLoaded())..add(MenuItemAdded(superBlandTofu)),
      expect: <BasketState>[
        BasketLoadSuccess([]),
        BasketLoadSuccess([MenuItem('Super Bland Tofu', 100, [])]),
      ],
    );

    blocTest(
      'MenuItemDeleted: emits BasketLoadSucess([])',
      build: () => basketBloc,
      act: (BasketBloc bloc) async => bloc
        ..add(BasketLoaded())
        ..add(MenuItemAdded(superBlandTofu))
        ..add(MenuItemDeleted(superBlandTofu)),
      expect: <BasketState>[
        BasketLoadSuccess([]),
        BasketLoadSuccess([MenuItem('Super Bland Tofu', 100, [])]),
        BasketLoadSuccess([])
      ],
    );

    tearDown(() {
      basketBloc = null;
      superBlandTofu = null;
    });
  });
}
