import 'package:meta/meta.dart';

// PopResult
class PopWithResults<T> {
  // pop until this page
  final String toPage;

  // results
  final Map<String, T> results;

  // constructor
  PopWithResults({@required this.toPage, this.results});
}
