import 'package:fireapps/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LockPage extends StatefulWidget {
  const LockPage({super.key});

  @override
  State<LockPage> createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {
  TextEditingController signInController = TextEditingController();

  void dashboard() {
    const finalPass = 'myPa';
    dynamic password = signInController.text;
    if (finalPass == password) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password Matched Successfully!'),
      ));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something went wrong!'),
      ));
    }

    signInController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard Login',
          style: TextStyle(color: Colors.white),
        ),
        leading: const Icon(Icons.lock),
        backgroundColor: const Color.fromARGB(255, 13, 182, 100),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(50),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: signInController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Secret Password',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    dashboard();
                  },
                  child: const Text('Login to Dashboard'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
