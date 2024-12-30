abstract class NavBarState {}

class NavBarInitial extends NavBarState {}

class NavBarTabChanged extends NavBarState {
  final int currentIndex;

  NavBarTabChanged(this.currentIndex);
}
