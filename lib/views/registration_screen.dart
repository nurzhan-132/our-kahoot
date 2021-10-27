import 'package:flutter/material.dart';
import 'package:our_kahoot/views/login_screen.dart';
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
      /*appBar: AppBar(
        title: const Text('Registration'),
      ),*/
      body: _buildRegistrationForm(),
    );
  }

  Widget _buildRegistrationForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginScreen.route);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                Icon(Icons.person_outlined, color: Colors.grey[400], size: 140,),
                SizedBox(height: 13,),
                Text(
                  "Create account",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Create a new account', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400],
                ),),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
                    controller: _nameController,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.person_outlined, size: 30),
                      labelText: "Username",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    validator: (text) => text!.isEmpty ? 'Enter your login' : null,
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock, size: 30),
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    validator: (text) => text!.isEmpty ? 'Create password' : null,
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
                    obscureText: true,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock, size: 30),
                      labelText: "Confirm password",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    validator: (text) =>
                    text!.isEmpty ? 'Passwords should be same' : null,
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: FlatButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onPressed: () {_validate();},
                    child: Text('Create account'),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),

                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginScreen.route);
                      },
                      child: Text('Login',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),

          ),

        ),
      ),
    );
  }

  void _validate() {
    final form = _formKey.currentState;
    if (!form!.validate()) {
      return;
    }

    //final name = _nameController.text;
    //final password = _passwordController.text;

    // check if model exists
    // if everything ok, create model with status and save it,
    const alert = PlatformAlert(
        title: 'Registration completed!',
        message: 'You successfully registered in app.');
    alert.show(context);
  }
}
