import 'package:virtualhole_flutter/common/common.dart';
import 'counter_viewmodel.dart';

class CounterController {
  CounterController({CounterViewModel counterViewModel})
      : counterViewModel = counterViewModel ??
            ViewModelContainer.instance.get<CounterViewModel>() {
    this.counterViewModel.onIncrement.add(onIncrement);
    this.counterViewModel.onDecrement.add(onDecrement);
  }

  final CounterViewModel counterViewModel;

  void dispose() {
    counterViewModel.onIncrement.remove(onIncrement);
    counterViewModel.onDecrement.remove(onDecrement);
  }

  void onIncrement() {
    counterViewModel.counter++;
  }

  void onDecrement() {
    counterViewModel.counter--;
  }
}
