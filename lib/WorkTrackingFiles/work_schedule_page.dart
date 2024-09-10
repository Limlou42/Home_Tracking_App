import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../ScaffoldItems/scaffold_drawer.dart';

class WorkSchedulePage extends StatefulWidget {
  const WorkSchedulePage({super.key});

  @override
  State<WorkSchedulePage> createState() => _WorkSchedulePageState();
}

class _WorkSchedulePageState extends State<WorkSchedulePage> {
  File? selectedMedia;
  Map ashSchedule = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Work Tracker"),
      ),
      drawer: const DrawerForMainScaffold(),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<MediaFile>? media = await GalleryPicker.pickMedia(
              context: context, singleMedia: true);
          if (media != null && media.isNotEmpty) {
            var data = await media.first.getFile();
            setState(() {
              selectedMedia = data;
            });
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  Widget _buildUI() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _imageView(),
        _extractTextView(),
      ],
    );
  }

  Widget _imageView() {
    if (selectedMedia == null) {
      return const Center(
        child: Text("Select an image"),
      );
    }
    return Center(
      child: Image.file(
        selectedMedia!,
        width: 200,
      ),
    );
  }

  Widget _extractTextView() {
    String test = "";

    if (selectedMedia == null) {
      return const Center(
        child: Text("No Result"),
      );
    }
    return FutureBuilder(
      future: _extractText(selectedMedia!),
      builder: (context, snapshot) {
        test = snapshot.data.toString();
        extractAshSchedule(test);
        return Text(
          snapshot.data ?? "",
          style: const TextStyle(fontSize: 5),
        );
      }
    );
  }

  void extractAshSchedule(String extractedText) {
    String normalizedText =
        extractedText.replaceAll(RegExp(r'\s+'), ' ').trim();
        
    final RegExp ashRegExp = RegExp(
      r'ASH\s+(?<sun>\d{1,2}\s*-\s*\d{1,2}|OFF|HOL|O\s*FF|OF\s*F)\s+(?<mon>\d{1,2}\s*-\s*\d{1,2}|OFF|HOL|O\s*FF|OF\s*F)\s+(?<tue>\d{1,2}\s*-\s*\d{1,2}|OFF|HOL|O\s*FF|OF\s*F)\s+(?<wed>\d{1,2}\s*-\s*\d{1,2}|OFF|HOL|O\s*FF|OF\s*F)\s+(?<thu>\d{1,2}\s*-\s*\d{1,2}|OFF|HOL|O\s*FF|OF\s*F)\s+(?<fri>\d{1,2}\s*-\s*\d{1,2}|OFF|HOL|O\s*FF|OF\s*F)\s+(?<sat>\d{1,2}\s*-\s*\d{1,2}|OFF|HOL|O\s*FF|OF\s*F)',
      caseSensitive: false,
    );

    final match = ashRegExp.firstMatch(normalizedText);
    if (match != null) {
      final ashSchedule = {
        "SUN": match.namedGroup('sun')?.trim(),
        "MON": match.namedGroup('mon')?.trim(),
        "TUE": match.namedGroup('tue')?.trim(),
        "WED": match.namedGroup('wed')?.trim(),
        "THU": match.namedGroup('thu')?.trim(),
        "FRI": match.namedGroup('fri')?.trim(),
        "SAT": match.namedGroup('sat')?.trim(),
      };

      // Replace any empty or whitespace-only slots with "OFF"
      ashSchedule.updateAll(
          (day, time) => time == null || time.isEmpty ? "OFF" : time);

    //   // Output or use the schedule as needed
    //   print("ASH's Schedule:");
    //   ashSchedule.forEach((day, time) {
    //     print("$day: $time");
    //   });
    // } else {
    //   print("Could not find ASH's schedule.");
    }
  }

  Future<String?> _extractText(File file) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String text = recognizedText.text;
    textRecognizer.close();
    return text;
  }
}
