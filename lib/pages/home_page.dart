import 'package:flutter/material.dart';
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
    final manifest = Provider.of<RoverProvider>(context, listen: false).manifest;
    if (manifest != null && _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      setState(() {
        _visibleCount = (_visibleCount + _batchSize).clamp(0, manifest.photos.length);
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

    final itemCount = (_visibleCount < manifest.photos.length) ? _visibleCount : manifest.photos.length;

    return Scaffold(
      appBar: AppBar(title: Text("Mission ${manifest.roverName}")),
      drawer: const RoverDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.brown.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        manifest.roverName,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Landing date:"),
                            Text("Launch date:"),
                            Text("Mission status:"),
                            Text("Max sol:"),
                            Text("Max date:"),
                            Text("Total photos:"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(manifest.landingDate),
                            Text(manifest.launchDate),
                            Text(manifest.status),
                            Text(manifest.maxSol.toString()),
                            Text(manifest.maxDate),
                            Text(manifest.totalPhotos.toString()),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("Explorer les sols disponibles :", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  final photoData = manifest.photos[index];
                  return ListTile(
                    title: Text("Sol ${photoData.sol} on ${photoData.earthDate}"),
                    trailing: Text("${photoData.totalPhotos}", style: const TextStyle(color: Colors.redAccent, fontSize: 16)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PhotosPage(sol: photoData.sol),
                        ),
                      );
                    },
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