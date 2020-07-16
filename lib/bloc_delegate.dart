import 'package:flutter_bloc/flutter_bloc.dart';

class GeneralBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }
}
