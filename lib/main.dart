import 'package:flutter/material.dart';

const appName = "Bush Tucker Garden";

void main() {
  runApp(const BushTuckerApp());
}

class BushTuckerApp extends StatelessWidget {
  const BushTuckerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Georgia',
      ),
      home: const DefaultTabController(
        length: 3,
        child: BushTuckerNavigation(),
      ),
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
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("About the garden"),
            ),
            body: const Center(
              child: Text("About"),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        /*actions: [
          IconButton(
            onPressed: _pushAbout,
            icon: const Icon(Icons.explore),
          )
        ],*/
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.explore)),
            Tab(icon: Icon(Icons.search)),
            Tab(icon: Icon(Icons.info)),
          ],
        ),
      ),
      body: const TabBarView(children: [
        MapWidget(),
        PlantList(),
        AboutPage(),
      ]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
              ),
              child: const Text(appName),
            ),
            ListTile(
              title: const Text("About the Garden"),
              onTap: () {
                print("Tapped Item 1");
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PlantInfo {
  final String name;

  const PlantInfo({required this.name});
}

class InfoButton {
  final double left;
  final double top;
  final IconData icon;
  final PlantInfo? plantInfo;

  const InfoButton({
    required this.left,
    required this.top,
    required this.icon,
    this.plantInfo,
  });
}

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final infoButtons = <InfoButton>[
    const InfoButton(
      left: 100,
      top: 100,
      icon: Icons.info,
      plantInfo: PlantInfo(name: "Geranium"),
    ),
    const InfoButton(
      left: 300,
      top: 500,
      icon: Icons.location_on,
      plantInfo: PlantInfo(name: "Pin"),
    ),
    const InfoButton(
      left: 600,
      top: 400,
      icon: Icons.local_florist,
      plantInfo: PlantInfo(name: "Flower"),
    ),
  ];

  void _pushInfo() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Plant Info"),
            ),
            body: const Center(child: Text("Info")),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[Image.asset('assets/images/map.png')];

    for (var infoButton in infoButtons) {
      children.add(
        Positioned(
          left: infoButton.left,
          top: infoButton.top,
          child: IconButton(
            onPressed: _pushInfo,
            icon: Icon(infoButton.icon),
            color: Colors.green,
            tooltip: infoButton.plantInfo?.name ?? "Plant",
          ),
        ),
      );
    }

    return InteractiveViewer(
      child: Stack(
        fit: StackFit.expand,
        children: children,
      ),
    );
  }
}

class PlantList extends StatefulWidget {
  const PlantList({super.key});

  @override
  State<PlantList> createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

const aboutBethGott =
    """Dr Beth Gott graduated in Botany from Melbourne University, later studying the life-cycle of Rye cereals at London University. On her return to Melbourne, she conducted research on wheat varieties grown in Australia before turning her attention to ‘ethnobotany’ and the study of the traditional uses of native plants.

Since the 1980’s Beth has assembled extensive databases of plants used by the Aborigines of south-eastern Australia, while also documenting the landscapes created by Aboriginal management, including the use of fire. Dr Gott created and curates the Aboriginal Educational Garden at Monash University. Click here for further information about the Aboriginal Garden at Monash and to download a plant list

In 2017 Beth was made a Member of the Order of Australia for "significant service to the biological sciences as an ethnobotanist specialising in the study of the use of native plants by Indigenous people".""";

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(1),
      children: [
        Center(
          child: Text(
            "Dr Beth Gott AM",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Image.asset("images/Gott1.jpg"),
        const Text(aboutBethGott),
      ],
    );
  }
}
