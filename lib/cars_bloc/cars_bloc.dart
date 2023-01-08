import 'dart:async';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/toast.dart';
import '../data/cars.dart';
import '../data/cars_dao.dart';
import '../home_page.dart';

part 'cars_event.dart';

part 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  final CarsDao _carsDao = CarsDao();

  CarsBloc() : super(CarsInitial());

  @override
  Stream<CarsState> mapEventToState(
    CarsEvent event,
  ) async* {
    if (event is getCars) {
      yield CarsLoading();
      yield* _reloadCars();
    } else if (event is AddNewCars) {
      if (event.name == '') {
        ToastClass().toastFunction(Colors.red, "Please Enter Car's Name");
      } else if (event.model == '') {
        ToastClass().toastFunction(Colors.red, "Please Enter Car's Model");
      } else if (event.regNum == '') {
        ToastClass().toastFunction(Colors.red, "Please Enter Car's Reg Number");
      } else if (event.color == '') {
        ToastClass().toastFunction(Colors.red, "Please Enter Car's Color");
      } else if (event.make == '') {
        ToastClass().toastFunction(Colors.red, "Please Enter Car's Make");
      } else {
        //here is add the car in the list
        await _carsDao.insert(
          Cars(
              name: event.name,
              color: event.color,
              model: event.model,
              regNumber: event. // ignore: use_build_context_synchronously
                  regNum,
              make: event.make),
        );
        ToastClass().toastFunction(Colors.green, "Car Successfully Added");
        // ignore: use_build_context_synchronously
        Navigator.push(
            event.context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      yield* _reloadCars();
    } else if (event is DeleteCars) {
      // here car is deleted from the list
      await _carsDao.delete(event.cars);
      ToastClass().toastFunction(Colors.green, "Car Successfully Deleted");
      // ignore: use_build_context_synchronously
      Navigator.push(
          event.context, MaterialPageRoute(builder: (context) => HomePage()));

      yield* _reloadCars();
    } else if (event is EditCars) {
      if (event.name == '') {
        ToastClass().toastFunction(Colors.red, "Please Enter Car's Name");
      } else if (event.model == '') {
        ToastClass().toastFunction(Colors.red, "Please Enter Car's Model");
      } else if (event.regNum == '') {
        ToastClass().toastFunction(Colors.red, "Please Enter Car's Reg Number");
      } else if (event.color == '') {
        ToastClass().toastFunction(Colors.red, "Please Enter Car's Color");
      } else if (event.make == '') {
        ToastClass().toastFunction(Colors.red, "Please Enter Car's Make");
      } else {
        final newCars = Cars(
            name: event.name,
            color: event.color,
            model: event.model,
            regNumber: event.regNum,
            make: event.make);
        newCars.id = event.cars.id;
        // here is update the car details
        await _carsDao.update(newCars);
        ToastClass().toastFunction(Colors.green, "Car Successfully Edited");
        // ignore: use_build_context_synchronously
        Navigator.push(
            event.context, MaterialPageRoute(builder: (context) => HomePage()));
      }

      yield* _reloadCars();
    }
  }

  Stream<CarsState> _reloadCars() async* {
    final cars = await _carsDao.getAllSortedByName();
    yield CarsLoaded(cars);
  }
}
