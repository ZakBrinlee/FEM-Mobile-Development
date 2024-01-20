import 'package:coffee_masters_zak/datamanager.dart';
import 'package:coffee_masters_zak/pages/menupage.dart';
import 'package:coffee_masters_zak/pages/offerspage.dart';
import 'package:coffee_masters_zak/pages/orderspage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Greet extends StatefulWidget {
  const Greet({super.key});

  @override
  State<Greet> createState() => _GreetState();
}

class _GreetState extends State<Greet> {
  var name = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Hello $name"),
        TextField(
          onChanged: (value) => setState(() {
            name = value;
          }),
        ),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Masters',
      theme: ThemeData(
        primaryColor: Colors.brown,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var dataManager = DataManager();
  int _currentIndex = 0;
  // DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    late Widget currentPage;

    switch (_currentIndex) {
      case 0:
        currentPage = MenuPage(dataManager: dataManager);
        break;
      case 1:
        currentPage = const OffersPage();
        break;
      case 2:
        currentPage = OrderPage(dataManager: dataManager);
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Image(image: AssetImage('images/logo.png')),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 24,
        selectedItemColor: Colors.yellow.shade400,
        unselectedItemColor: Colors.brown.shade50,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Offers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Order',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: currentPage,
    );
  }
}

class HelloWorld extends StatelessWidget {
  const HelloWorld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Hello World');
  }
}
