// Future<void> _resetQuoteIndex() async {
//   final box = await Hive.openBox('auto_change');
//   await box.put('quote_index', 0);
// }


// Future<int> _getAndIncrementIndex(int listLength) async {
//   final box = await Hive.openBox('auto_change');
//   int current = box.get('quote_index', defaultValue: 0) as int;
//   final next = (current + 1) % listLength;
//   await box.put('quote_index', next);
//   return current;
// }
