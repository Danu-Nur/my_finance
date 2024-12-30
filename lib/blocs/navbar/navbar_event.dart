abstract class NavBarEvent {}

class ChangeTabIndex extends NavBarEvent {
  final int index;

  ChangeTabIndex(this.index);
}
