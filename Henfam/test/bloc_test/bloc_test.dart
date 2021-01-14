import 'auth_test.dart';
import 'restaurant_test.dart';
import 'basket_test.dart';

void blocTests() {
  basketBlocTests();
  restaurantBlocTests();
  authBlocTests();
}

main() {
  blocTests();
}
