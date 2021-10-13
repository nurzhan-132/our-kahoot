import 'package:flutter/material.dart';
import '../platform_alert.dart';

class RegistrationScreen extends StatefulWidget {
  static const route = '/registration_screen';
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Center(
        child: _buildRegistrationForm(),
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Login'),
              validator: (text) => text!.isEmpty ? 'Enter your login' : null,
            ),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (text) => text!.isEmpty ? 'Enter your password' : null,
            ),
            TextFormField(
              //controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (text) =>
                  text!.isEmpty ? 'Passwords should be same' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _validate, child: const Text('Register')),
          ],
        ),
      ),
    );
  }

  void _validate() {
    final form = _formKey.currentState;
    if (!form!.validate()) {
      return;
    }

    final name = _nameController.text;
    final password = _passwordController.text;

    // check if model exists
    // if everything ok, create model with status and save it,
    final alert = PlatformAlert(
        title: 'Registration completed!',
        message: 'You successfully registered in app.');
    alert.show(context);
  }
}
