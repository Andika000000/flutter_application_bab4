import 'dart:ffi';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController etInput = TextEditingController();
  List<String> listSatuanSuhu = ["Kelvin", "Reamur", "Fahrenheit"];
  String selectedDropdown = "Kelvin";
  double hasilPerhitungan = 0.0;
  List<String> listHasil = [];

  get value => null;

  void _incrementCounter() {
    setState(() {
      selectedDropdown = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            TextField(
              controller: etInput,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Celcius',
                border: OutlineInputBorder(),
                hintText: 'Enter the temparature in celcius',
              ),
            ),
            SizedBox(
              height: 8,
            ),
            DropdownButton(
              value: selectedDropdown,
              items: listSatuanSuhu.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                onDropdownChanged(value);
              },
            ),
            const SizedBox(height: 10),
            Text(
              'Hasil',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "$hasilPerhitungan",
              style: TextStyle(fontSize: 33),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (etInput.text.isNotEmpty) {
                          switch (selectedDropdown) {
                            case "Kelvin":
                              hasilPerhitungan =
                                  int.parse(etInput.text) + 273.15;
                              break;
                            case "Reamur":
                              hasilPerhitungan =
                                  int.parse(etInput.text) * 4 / 5;
                              break;
                            case "Fahrenheit":
                              hasilPerhitungan =
                                  (int.parse(etInput.text) * 9 / 5) + 32;
                          }
                          listHasil.add(" Konversi Dari " +
                              etInput.text +
                              " Celcius " +
                              selectedDropdown +
                              " Dengan Hasil : " +
                              hasilPerhitungan.toString());
                        }
                      });
                    },
                    child: Text("Konversi Suhu"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "Riwayat Konversi",
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: listHasil.length,
                    itemBuilder: (context, index) {
                      return Text(listHasil[index]);
                    }))
          ],
        ),
      ),
    );
  }

  void onDropdownChanged(String? value) {
    return setState(() {
      selectedDropdown = value.toString();
    });
  }
}
