import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false); // Default theme is light (false)

  void toggleTheme() {
    emit(!state); // Toggle between true (dark) and false (light)
  }
}
