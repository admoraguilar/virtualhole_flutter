import 'package:virtualhole_flutter/midnight_flutter/midnight_flutter.dart';
import 'counter_viewmodel.dart';

class CounterController extends ViewModelController {
  CounterController({CounterViewModel counterViewModel})
      : counterViewModel =
            counterViewModel ?? ViewModel.get<CounterViewModel>() {
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
