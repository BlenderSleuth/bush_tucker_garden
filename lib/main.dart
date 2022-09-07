import 'package:flutter/material.dart';

void main() {
  runApp(const BushTuckerApp());
}

class BushTuckerApp extends StatelessWidget {
  const BushTuckerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Bush Tucker Garden',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const BushTuckerNavigation()
    );
  }
}

class BushTuckerNavigation extends StatefulWidget {
  const BushTuckerNavigation({super.key});

  @override
  State<BushTuckerNavigation> createState() => _BushTuckerNavigationState();
}

class _BushTuckerNavigationState extends State<BushTuckerNavigation> {
  void _pushAbout() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("About the garden"),
          ),
          body: const Center(child: Text("About")));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bush Tucker Garden'),
        actions: [
          IconButton(onPressed: _pushAbout, icon: const Icon(Icons.explore))
        ],
      ),
      body: const MapWidget(),
    );
  }
}

class PlantInfo {
  String name;

  PlantInfo(this.name);
}

class InfoButton {
  final double left;
  final double top;
  final IconData icon;
  final PlantInfo? plantInfo;

  const InfoButton(
      {required this.left,
      required this.top,
      required this.icon,
      this.plantInfo});
}

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final infoButtons = <InfoButton>[
    const InfoButton(left: 100, top: 100, icon: Icons.info),
    const InfoButton(left: 300, top: 500, icon: Icons.energy_savings_leaf),
  ];

  void _pushInfo() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Plant Info"),
          ),
          body: const Center(child: Text("Info")));
    }));
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[Image.asset('assets/images/map.png')];

    for (var infoButton in infoButtons) {
      children.add(Positioned(
          left: infoButton.left,
          top: infoButton.top,
          child: IconButton(
            onPressed: _pushInfo,
            icon: Icon(infoButton.icon),
            color: Colors.green,
          )));
    }

    return InteractiveViewer(
        child: Stack(fit: StackFit.expand, children: children));
  }
}
