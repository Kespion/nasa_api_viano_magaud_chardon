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
            decoration: BoxDecoration(color: Colors.deepOrange),
            child: Text("Choisissez un rover", style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
          ...["Curiosity", "Opportunity", "Spirit"].map((rover) => ListTile(
            title: Text(rover),
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