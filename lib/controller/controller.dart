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
      await DataBaseHelper().sortByLastest();
      sorted = SortBy.recent;
    } else {
      // await DataBaseHelper().getOrderedList();
      await DataBaseHelper().sortByOldest();
      sorted = SortBy.oldest;
    }

    await Future.delayed(Duration(seconds: 2));
    isLoading = false;
    notifyListeners();
  }
}
