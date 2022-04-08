import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/repositories/dataRepository.dart';

class DataView extends StatefulWidget {
  const DataView({Key? key}) : super(key: key);

  @override
  State<DataView> createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  @override
  Widget build(BuildContext context) {
    final table = DataRepository.table;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text("NetRunner Database"),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int dta) {
            return ListTile(
              leading: Image.asset(table[dta].icon),
              title: Text(table[dta].name),
              trailing: Text(table[dta].price.toString()),
            );
          },
          padding: const EdgeInsets.all(8),
          separatorBuilder: (_, ___) => const Divider(),
          itemCount: table.length,
      ),
    );
  }
}
