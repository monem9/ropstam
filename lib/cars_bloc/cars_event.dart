part of 'cars_bloc.dart';

@immutable
abstract class CarsEvent {}

// ignore: camel_case_types
class getCars extends CarsEvent {}

// ignore: must_be_immutable
class AddNewCars extends CarsEvent {
  BuildContext context;
  String name;
  String model;
  String make;
  String color;
  String regNum;

  AddNewCars(
      {required this.context,
      required this.name,
      required this.model,
      required this.color,
      required this.make,
      required this.regNum});
}

// ignore: must_be_immutable
class DeleteCars extends CarsEvent {
  final Cars cars;
  BuildContext context;

  DeleteCars({
    required this.cars,
    required this.context,
  });
}

// ignore: must_be_immutable
class EditCars extends CarsEvent {
  final Cars cars;
  BuildContext context;
  String name;
  String model;
  String make;
  String color;
  String regNum;

  EditCars({
    required this.cars,
    required this.context,
    required this.name,
    required this.model,
    required this.color,
    required this.make,
    required this.regNum,
  });
}
