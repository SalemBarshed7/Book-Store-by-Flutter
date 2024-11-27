
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/information.dart';

class ItemSearchDelegate extends SearchDelegate {
  final List element;

  ItemSearchDelegate(this.element);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null); 
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = element.where((item) {
      final itemName = item['name'] ?? '';
      return itemName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (results.isEmpty) {
      return const Center(
        child: Text(
          "No results found!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        final imagePath = item['image'];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListTile(
            leading: imagePath != null
                ? (imagePath.startsWith('assets')
                    ? Image.asset(
                        imagePath,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(imagePath),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ))
                : const Icon(Icons.image_not_supported),
            title: Text(
              item['name'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text("Tap to view the PDF"),
            onTap: () async {
              final pdfPath = results[index]['pdf'];
             if (pdfPath != null && pdfPath.startsWith('assets/pdf/')) {
             final localPath = await copyAssetToLocal(pdfPath);
             Navigator.push(
             context,
             MaterialPageRoute(
             builder: (context) => PdfViewerPage(pdfPath: localPath), 
                               ),
                            );
             } else if (pdfPath != null && pdfPath.isNotEmpty) {
             Navigator.push(
             context,
             MaterialPageRoute(
             builder: (context) => PdfViewerPage(pdfPath: pdfPath),
              ),
             );
           } else {
           ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text("No PDF available for this item")),
              );
           }

             
             
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = element.where((item) {
      final itemName = item['name'] ?? '';
      return itemName.toLowerCase().startsWith(query.toLowerCase());
    }).toList();

    if (suggestions.isEmpty) {
      return const Center(
        child: Text(
          "No suggestions available!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final item = suggestions[index];
        final imagePath = item['image'];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListTile(
            leading: imagePath != null
                ? (imagePath.startsWith('assets')
                    ? Image.asset(
                        imagePath,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(imagePath),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ))
                : const Icon(Icons.image_not_supported),
            title: Text(
              item['name'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              query = item['name'] ?? '';
              showResults(context);
            },
          ),
        );
      },
    );
  }
}





Future<String> copyAssetToLocal(String assetPath) async {
  final byteData = await rootBundle.load(assetPath); // تحميل الملف من `assets`
  final tempDir = await getTemporaryDirectory(); // تحديد المسار المؤقت
  final file = File('${tempDir.path}/${assetPath.split('/').last}'); // إنشاء ملف جديد في المسار المؤقت
  await file.writeAsBytes(byteData.buffer.asUint8List()); // نسخ البيانات إلى الملف الجديد
  return file.path; // إرجاع المسار الجديد للملف
}