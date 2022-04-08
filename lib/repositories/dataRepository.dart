import 'package:flutter_boilerplate/models/data.dart';

class DataRepository {
  static List<DataValue> table = [
    DataValue(
        icon: 'assets/fade2black.png',
        name: 'Fade2Black',
        id: 'fade',
        price: 100,
    ),
    DataValue(
      icon: 'assets/advminer.png',
      name: 'AdvancedMiner',
      id: 'advminer',
      price: 50,
    ),
    DataValue(
      icon: 'assets/fmemory.png',
      name: 'FormatMemory',
      id: 'fmemory',
      price: 200,
    ),
    DataValue(
      icon: 'assets/massweak.png',
      name: 'MassiveVunerability',
      id: 'massweak',
      price: 150,
    ),
  ];
}