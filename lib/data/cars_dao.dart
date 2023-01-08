import 'package:sembast/sembast.dart';

import 'app_database.dart';
import 'cars.dart';


class CarsDao {
  static const String CARS_STORE_NAME = 'cars';
  // A Store with int keys and Map<String, dynamic> values.
  final _carsStore = intMapStoreFactory.store(CARS_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Cars cars) async {
    await _carsStore.add(await _db, cars.toMap());
  }
// function of updating cars
  Future update(Cars cars) async {
    final finder = Finder(filter: Filter.byKey(cars.id));
    await _carsStore.update(
      await _db,
      cars.toMap(),
      finder: finder,
    );
  }
// function of deleting cars
  Future delete(Cars cars) async {
    final finder = Finder(filter: Filter.byKey(cars.id));
    await _carsStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<Cars>> getAllSortedByName() async {
    // Finder object can also sort data.
    final finder = Finder(sortOrders: [
      SortOrder('name'),
    ]);

    final recordSnapshots = await _carsStore.find(
      await _db,
      finder: finder,
    );

    return recordSnapshots.map((snapshot) {
      final cars = Cars.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      cars.id = snapshot.key;
      return cars;
    }).toList();
  }
}
