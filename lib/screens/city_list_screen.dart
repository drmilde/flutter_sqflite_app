import 'package:flutter/material.dart';
import 'package:flutter_sqflite_app/database/city_database.dart';

class CityListScreen extends StatelessWidget {
  late CityDatabase cdb;

  CityListScreen(CityDatabase this.cdb);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alle Städte"),
      ),
      body: FutureBuilder(
        future: cdb.getStaedte(),
        // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
          // Fall 1: keine Daten geladen
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            return Container(color: Colors.red);
          }
          // Fall 2: Daten werden noch geladen
          if (!snapshot.hasData) {
            return Container(color: Colors.blue);
          } else {
            // Fall 3: Daten wurden geladen und können angezeigt werden
            List<Map> result = snapshot.data as List<Map>;
            print(result);
            return ListView.builder(
                itemCount: result.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (Container(
                      height: 100,
                      width: 200,
                      color: Colors.blue,
                      child: Text(result[index]["name"]),
                    )),
                  );
                });
          }
        },
      ),
    );
  }
}
