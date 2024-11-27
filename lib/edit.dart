
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart'; // مكتبة اختيار الملفات

class editpage extends StatefulWidget {
  @override
  State<editpage> createState() => _EditPageState();
}

class _EditPageState extends State<editpage> {
  late TextEditingController _nameController;
  String? _pdfPath; 
  File? _imageFile;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

   
    final currentValue = ModalRoute.of(context)!.settings.arguments as Map;
    _nameController = TextEditingController(text: currentValue['name']);
    _pdfPath = currentValue['pdf']; 
    if (currentValue['image'] != null) {
      _imageFile = File(currentValue['image']); 
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickPdfFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], 
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _pdfPath = result.files.single.path; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Page"),
        backgroundColor: const Color.fromARGB(146, 0, 0, 0),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 30),
        child: Form(
          child: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                  
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Edit Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                  
                    ElevatedButton(
                      onPressed: _pickPdfFile,
                      child: const Text("Change PDF"),
                    ),
                    const SizedBox(height: 10),

                   
                    Text(
                      _pdfPath != null ? "Selected PDF: $_pdfPath" : "No PDF Selected",
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 20),

                  
                    _imageFile != null
                        ? Image.file(
                            _imageFile!,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          )
                        : const Text("No image selected"),
                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text("Change Image"),
                    ),
                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                     
                        Navigator.pop(context, {
                          'name': _nameController.text,
                          'pdf': _pdfPath, 
                          'image': _imageFile?.path,
                        });
                      },
                      child: const Text("Save"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
