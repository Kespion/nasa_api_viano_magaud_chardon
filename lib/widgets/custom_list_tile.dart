import 'package:flutter/material.dart';
import 'package:nasa_api_viano_magaud_chardon/models/photo_summary.dart';
import 'package:nasa_api_viano_magaud_chardon/widgets/custom_text_style.dart';

import '../pages/photos_page.dart';

class CustomListTile extends StatelessWidget {
  final PhotoSummary photoData;

  const CustomListTile({super.key, required this.photoData});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: Border(
        bottom: BorderSide(color: Colors.black, width: 1),
      ),
      title: Text("Sol ${photoData.sol} on ${photoData.earthDate}",
          style: CustomTextStyle.black18),
      trailing: Text("${photoData.totalPhotos}", style: CustomTextStyle.red18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PhotosPage(sol: photoData.sol),
          ),
        );
      },
    );
  }
}
