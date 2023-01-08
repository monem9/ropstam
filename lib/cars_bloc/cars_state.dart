part of 'cars_bloc.dart';

@immutable
abstract class CarsState {}

class CarsLoading extends CarsState {}

class CarsInitial extends CarsState {}

class CarsLoaded extends CarsState {
  final List<Cars> cars;

  CarsLoaded(this.cars);
}
