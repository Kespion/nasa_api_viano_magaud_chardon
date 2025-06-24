import 'package:flutter/material.dart';
import 'package:nasa_api_viano_magaud_chardon/models/manifest.dart';
import 'package:nasa_api_viano_magaud_chardon/widgets/custom_text_style.dart';

class RoverCard extends StatelessWidget {
  final Manifest manifest;

  const RoverCard({super.key, required this.manifest});

  @override
  Widget build(BuildContext context) {
    List<String> labelList = [
      "Landing date:",
      "Launch date:",
      "Mission status:",
      "Max sol:",
      "Max date:",
      "Total photos:"
    ];

    List<String> dataList = [
      manifest.landingDate,
      manifest.launchDate,
      manifest.status,
      manifest.maxSol.toString(),
      manifest.maxDate,
      manifest.totalPhotos.toString()
    ];

    return Card(
      shadowColor: Colors.black,
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
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    labelList.length,
                    (index) => Text(
                      labelList[index],
                      style: CustomTextStyle.blackBold18
                    )
                  )
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(
                    dataList.length,
                    (index) => Text(
                      dataList[index],
                      style: CustomTextStyle.black18
                    )
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
