import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Treasure Hunt',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color notTreasure = const Color(0xffFF0000);
  Color treasure = const Color(0xff2196f3);
  Color empty = const Color(0xff9e9e9e);
  List<Color> gridColors = List.generate(64, (_) => const Color(0xff9e9e9e));
  List<Color> changedGridColors =
      List.generate(64, (_) => const Color(0xff9e9e9e));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Treasure Hunt'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 2 / 1.5,
                ),
                itemCount: 64,
                itemBuilder: (context, index) {
                  return newMethod(index);
                }),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Container newMethod(int index) {
    return Container(
      color: countColorChanged() >= 5
          ? changedGridColors[index]
          : gridColors[index],
      child: InkWell(
        onTap: () {
          if (countColorChanged() >= 5) {
            if (changedGridColors[index] == gridColors[index]) {
              setState(() {
                changedGridColors[index] = notTreasure;
              });
            }
            if (changedGridColors[index] != gridColors[index] &&
                gridColors[index] == treasure) {
              setState(() {
                changedGridColors[index] = treasure;
              });
            }
            if (changedGridColors
                        .where((element) => element == treasure)
                        .length ==
                    5 ||
                changedGridColors
                        .where((element) => element == notTreasure)
                        .length ==
                    59) {
              setState(() {
                changedGridColors =
                    List.generate(64, (_) => const Color(0xff9e9e9e));
                gridColors = List.generate(64, (_) => const Color(0xff9e9e9e));
              });
            }
          } else {
            setState(() {
              gridColors[index] = treasure;
            });
          }
        },
        child: Center(
          child: Text('$index'),
        ),
      ),
    );
  }

  int countColorChanged() {
    return gridColors.where((element) => element == treasure).length;
  }
}
