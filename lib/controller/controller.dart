import 'package:flutter/material.dart';

import 'database.dart';

enum SortBy { oldest, recent }

class Controller extends ChangeNotifier {
  bool isLoading = false;
  SortBy sorted = SortBy.oldest;
  sortBy(
    Object value,
  ) async {
    isLoading = true;
    if (value == 'Sort by Recent') {
      isLoading = true;
      await DataBaseHelper().sortByOldest();

      sorted = SortBy.recent;
      notifyListeners();
    } else {
      await DataBaseHelper().sortByLastest();
      sorted = SortBy.oldest;
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }
}
