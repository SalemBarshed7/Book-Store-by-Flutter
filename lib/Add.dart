
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _controller = TextEditingController();
  File? _selectedImage;
  File? _selectedPdf;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        _selectedPdf = File(result.files.single.path!);
      });
    }
  }

  void _saveAndNavigate() {
    if (_controller.text.isNotEmpty && _selectedImage != null && _selectedPdf != null) {
      Navigator.pop(
        context,
        {
          'name': _controller.text,
          'image': _selectedImage!.path,
          'pdf': _selectedPdf!.path,
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى إدخال قيمة صحيحة واختيار صورة وملف PDF")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة عنصر"),
        backgroundColor: const Color.fromARGB(146, 0, 0, 0),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          child: Column(
            children: [
              // حقل النص
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'أدخل الاسم',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),

      
              ElevatedButton.icon(
                onPressed: pickImage,
                icon: const Icon(Icons.image),
                label: const Text("اختر صورة"),
              ),
              const SizedBox(height: 20),

            
              _selectedImage != null
                  ? Image.file(
                      _selectedImage!,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    )
                  : const Text("لم يتم اختيار صورة"),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: pickPdf,
                child: const Text("اختر ملف PDF"),
              ),

      
              if (_selectedPdf != null)
                Text(
                  "PDF مختار: ${_selectedPdf!.path.split('/').last}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 20),

             
              ElevatedButton(
                onPressed: _saveAndNavigate,
                child: const Text("إضافة"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
