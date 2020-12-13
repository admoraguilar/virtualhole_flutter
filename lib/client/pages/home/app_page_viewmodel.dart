import 'package:virtualhole_flutter/common/common.dart';

class AppPageViewModel extends ViewModel {
  int get currentIndex => _currentIndex;
  set currentIndex(int value) {
    _currentIndex = value;
    setState();
  }

  int _currentIndex;
}
