import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/rover_provider.dart';

class RoverDrawer extends StatelessWidget {
  const RoverDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Column(
              children: [
                Icon(Icons.rocket_launch, size: 50, color: Colors.pink),
                Text("Mars Rovers", style: TextStyle(color: Colors.black, fontSize: 24)),
              ],
            ),
          ),
          ...["Curiosity", "Opportunity", "Spirit"].map((rover) => ListTile(
            title: Text(rover, style: TextStyle(color: Colors.black, fontSize: 24),),
            onTap: () async {
              final provider = Provider.of<RoverProvider>(context, listen: false);
              Navigator.pop(context);
              await provider.fetchManifest(rover);
            },
          )),
        ],
      ),
    );
  }
}