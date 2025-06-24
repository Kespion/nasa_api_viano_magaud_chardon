import 'package:flutter/material.dart';
import 'package:nasa_api_viano_magaud_chardon/widgets/custom_list_tile.dart';
import 'package:nasa_api_viano_magaud_chardon/widgets/rover_card/rover_card.dart';
import 'package:provider/provider.dart';
import '../providers/rover_provider.dart';
import 'photos_page.dart';
import '../widgets/rover_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final int _batchSize = 50;
  int _visibleCount = 50;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final manifest =
        Provider.of<RoverProvider>(context, listen: false).manifest;
    if (manifest != null &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100) {
      setState(() {
        _visibleCount =
            (_visibleCount + _batchSize).clamp(0, manifest.photos.length);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final manifest = Provider.of<RoverProvider>(context).manifest;

    if (manifest == null || manifest.photos.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Aucune donnée disponible.")),
      );
    }

    final itemCount = (_visibleCount < manifest.photos.length)
        ? _visibleCount
        : manifest.photos.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Mars Rover Photos"),
        backgroundColor: Colors.orangeAccent,
      ),
      drawer: const RoverDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoverCard(manifest: manifest),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  final photoData = manifest.photos[index];
                  return CustomListTile(
                    photoData: photoData,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
