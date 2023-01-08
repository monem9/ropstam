import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Auth/constants.dart';
import 'add_cars_screen.dart';
import 'cars_bloc/cars_bloc.dart';
import 'data/cars.dart';
import 'edit_cars.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // ignore: library_private_types_in_public_api
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CarsBloc _carsBloc;
  late List<Cars>? cars;

  @override
  void initState() {
    super.initState();
    _carsBloc = BlocProvider.of<CarsBloc>(context);
    _carsBloc.add(getCars());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('DashBoard'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddCarsScreen()));
        },
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder(
      bloc: _carsBloc,
      // Whenever there is a new state emitted from the bloc, builder runs.
      builder: (BuildContext context, CarsState state) {
        if (state is CarsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CarsLoaded) {
          return ListView.builder(
            itemCount: state.cars.length,
            itemBuilder: (context, index) {
              final displayedCars = state.cars[index];
              return Card(
                color: kPrimaryLightColor,
                elevation: 7,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.transparent)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            displayedCars.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text('#${displayedCars.regNumber}'),
                              const SizedBox(
                                width: 15,
                              ),
                              Text('Model : ${displayedCars.model}'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Make : ${displayedCars.make}'),
                              const SizedBox(
                                width: 15,
                              ),
                              Text('Color : ${displayedCars.color}'),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_downward_outlined),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditCarsScreen(
                                      displayedCars: displayedCars)));
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
