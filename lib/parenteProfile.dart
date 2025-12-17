import 'package:flutter/material.dart';

class ParenteProfile extends StatefulWidget {
  const ParenteProfile({super.key});

  @override
  State<ParenteProfile> createState() => _ParentProfileState();
}

class _ParentProfileState extends State<ParenteProfile> {
  bool isEditing = false;

  // البيانات المبدئية (لاحقاً تجيبيها من الـ Database)
  TextEditingController nameController = TextEditingController(
    text: "Ahmed Ali",
  );
  TextEditingController emailController = TextEditingController(
    text: "ahmed@gmail.com",
  );
  TextEditingController phoneController = TextEditingController(
    text: "0599123456",
  );
  TextEditingController passwordController = TextEditingController(
    text: "12345678",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parent Profile"),
        leading: IconButton(icon: const Icon(Icons.person), onPressed: () {}),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (isEditing) {
                // عند الحفظ 👇
                saveDataToDatabase();
              }

              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Parent Information",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            buildField("Name", nameController),
            const SizedBox(height: 20),

            buildField("Email", emailController),
            const SizedBox(height: 20),

            buildField("Phone Number", phoneController),
            const SizedBox(height: 20),

            buildField("Password", passwordController, isPassword: true),
          ],
        ),
      ),
    );
  }

  Widget buildField(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      enabled: isEditing,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  // يمكنك تعديلها لاحقاً للـ Firebase أو أي DB
  void saveDataToDatabase() {
    print("Saving data...");
    print("Name: ${nameController.text}");
    print("Email: ${emailController.text}");
    print("Phone: ${phoneController.text}");
    print("Password: ${passwordController.text}");

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Data saved successfully ✔️")));
  }
}
