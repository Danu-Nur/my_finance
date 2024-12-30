import 'package:bloc/bloc.dart';
import 'package:my_finance/blocs/navbar/navbar_event.dart';
import 'package:my_finance/blocs/navbar/navbar_state.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  NavBarBloc() : super(NavBarInitial()) {
    on<ChangeTabIndex>(_onTabIndexChanged);
  }

  Future<void> _onTabIndexChanged(
      ChangeTabIndex event, Emitter<NavBarState> emit) async {
    emit(NavBarTabChanged(event.index));
  }
}
