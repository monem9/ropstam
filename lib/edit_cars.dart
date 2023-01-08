import 'package:flutter/material.dart';

import 'Auth/constants.dart';
import 'Widgets/text_field.dart';
import 'cars_bloc/cars_bloc.dart';
import 'data/cars.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCarsScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final displayedCars;

  const EditCarsScreen({Key? key, required this.displayedCars})
      : super(key: key);

  @override
  State<EditCarsScreen> createState() => _EditCarsScreenState();
}

class _EditCarsScreenState extends State<EditCarsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController makeController = TextEditingController();
  TextEditingController regNumberController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  late CarsBloc _carsBloc;
  late List<Cars>? cars;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.displayedCars.name);
    modelController = TextEditingController(text: widget.displayedCars.model);
    makeController = TextEditingController(text: widget.displayedCars.make);
    regNumberController =
        TextEditingController(text: widget.displayedCars.regNumber);
    colorController = TextEditingController(text: widget.displayedCars.color);
    super.initState();
    _carsBloc = BlocProvider.of<CarsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Edit Cars'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              TextFieldWidget(
                controller: nameController,
                icon: (Icons.car_rental),
                hintText: 'Name',
              ),
              SizedBox(
                height: screenSize.height * 0.015,
              ),
              TextFieldWidget(
                controller: modelController,
                icon: (Icons.abc_rounded),
                hintText: 'Model',
              ),
              SizedBox(
                height: screenSize.height * 0.015,
              ),
              TextFieldWidget(
                controller: regNumberController,
                icon: (Icons.mode),
                hintText: 'Reg Number',
              ),
              SizedBox(
                height: screenSize.height * 0.015,
              ),
              TextFieldWidget(
                controller: colorController,
                icon: (Icons.color_lens_rounded),
                hintText: 'Color',
              ),
              SizedBox(
                height: screenSize.height * 0.015,
              ),
              TextFieldWidget(
                controller: makeController,
                icon: (Icons.add_circle_outline),
                hintText: 'Make',
              ),
              SizedBox(
                height: screenSize.height * 0.15,
              ),
              ElevatedButton(
                  onPressed: () {
                    _carsBloc.add(EditCars(
                      context: context,
                      name: nameController.text,
                      model: modelController.text,
                      make: makeController.text,
                      color: colorController.text,
                      regNum: regNumberController.text,
                      cars: widget.displayedCars,
                    ));
                  },
                  child: const Text('Submit')),
              SizedBox(
                height: screenSize.height * 0.015,
              ),
              ElevatedButton(
                  onPressed: () {
                    _carsBloc.add(DeleteCars(
                      context: context,
                      cars: widget.displayedCars,
                    ));
                  },
                  child: const Text('Delete'))
            ],
          ),
        ),
      )),
    );
  }
}
