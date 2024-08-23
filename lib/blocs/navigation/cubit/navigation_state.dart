part of 'navigation_cubit.dart';

sealed class NavigationState extends Equatable {
  const NavigationState(this.selectedIndex);

  final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];
}

final class NavigationInitial extends NavigationState {
  const NavigationInitial() : super(0);
}

final class NavigationUpdated extends NavigationState {
  const NavigationUpdated(super.selectedIndex);
}
