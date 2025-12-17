import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'homepage.dart';

class AddChild extends StatefulWidget {
  const AddChild({super.key});

  @override
  State<AddChild> createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  File? pickedImage;
  String? selectedGender;

  final ImagePicker _picker = ImagePicker();

  // اختيار صورة من المعرض
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Add Child",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              // صورة الطفل
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue.shade100,
                  backgroundImage: pickedImage != null
                      ? FileImage(pickedImage!)
                      : null,
                  child: pickedImage == null
                      ? const Icon(
                          Icons.camera_alt,
                          size: 35,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),

              const SizedBox(height: 20),

              // نموذج الادخال
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Form(
                  child: Column(
                    children: [
                      // اسم الطفل
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Child Name',
                            hintText: 'Enter name',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            return value!.isEmpty ? 'Please enter name' : null;
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // العمر
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Age",
                          ),
                          items: const [
                            DropdownMenuItem(value: "7", child: Text("7")),
                            DropdownMenuItem(value: "8", child: Text("8")),
                            DropdownMenuItem(value: "8", child: Text("9")),
                            DropdownMenuItem(value: "8", child: Text("10")),
                            DropdownMenuItem(value: "8", child: Text("11")),
                            DropdownMenuItem(value: "8", child: Text("12")),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // رقم الهوية
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'ID',
                            hintText: 'Enter ID number',
                            prefixIcon: Icon(Icons.credit_card),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            return value!.isEmpty ? 'Please enter ID' : null;
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // اختيار جنس الطفل
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Gender",
                          ),
                          items: const [
                            DropdownMenuItem(value: "Boy", child: Text("male")),
                            DropdownMenuItem(
                              value: "Girl",
                              child: Text("female"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 30),

                      // زر الإضافة
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Homepage(),
                              ),
                            );
                          },
                          color: const Color.fromARGB(255, 183, 223, 255),
                          textColor: Colors.white,
                          child: const Text('Add Child'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
