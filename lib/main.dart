import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Kasir App';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: KasirScreen(),
      ),
    );
  }
}

class KasirScreen extends StatefulWidget {
  const KasirScreen({super.key});

  @override
  _KasirScreenState createState() => _KasirScreenState();
}

class _KasirScreenState extends State<KasirScreen> {
  Map<String, int> items = {
    'Beras': 0,
    'Gula': 0,
    'Minyak': 0,
    'Kopi': 0,
    'Teh': 0,
  };
  Map<String, num> itemPrices = {
    'Beras': 10.0,
    'Gula': 9.0,
    'Minyak': 8.0,
    'Kopi': 7.0,
    'Teh': 5.0,
  };
  double totalPrice = 0.0;

  void updateItemCount(String item, int value) {
    setState(() {
      items[item] = value;
      calculateTotalPrice();
    });
  }

  void calculateTotalPrice() {
    double total = 0.0;
    items.forEach((item, quantity) {
      total += quantity * (itemPrices[item] ?? 0);
    });

    setState(() {
      totalPrice = total;
    });
  }

  void resetItems() {
    setState(() {
      items = {
        'Beras': 0,
        'Gula': 0,
        'Minyak': 0,
        'Kopi': 0,
        'Teh': 0,
      };
      totalPrice = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 20),
        Column(
          children: items.keys.map((item) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$item =  ',
                  style: const TextStyle(fontSize: 30),
                ),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: items[item].toString(),
                    onChanged: (value) {
                      int newValue = int.tryParse(value) ?? 0;
                      updateItemCount(item, newValue);
                    },
                  ),
                ),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: resetItems,
          child: const Text('Reset'),
        ),
        const SizedBox(height: 20),
        Text(
          'Total Harga: \$${totalPrice.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
