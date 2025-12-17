import 'package:flutter/material.dart';
import 'package:helping_hand/auth/signup/signup1.dart';
import 'package:helping_hand/homepage.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String value) => {},
                          validator: (value) {
                            return value!.isEmpty ? 'Please enter email' : null;
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter password',
                            prefixIcon: Icon(Icons.password),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String value) => {},
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Please enter password'
                                : null;
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Homepage(),
                              ),
                            );
                          },
                          child: Text('Login'),
                          color: Colors.blue,
                          textColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Signup1()),
                            );
                          },
                          child: Text('Signup'),
                          color: const Color.fromARGB(255, 183, 223, 255),
                          textColor: Colors.white,
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
