import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voguevoyage/features/auth_methods.dart';
import 'package:voguevoyage/screens/home.dart';
import 'package:voguevoyage/utils/selection.dart';
import 'package:voguevoyage/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final PageController _pageController;

  void _navigateToNextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void loginUser() async {
    setState(() {});
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home(initialPage: 1)),
            (route) => false);

        setState(() {});
      }
    } else {
      setState(() {});
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SelectionModel selectionModel = Provider.of<SelectionModel>(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.jpeg',
                    width: 200.0,
                    height: 200.0,
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    decoration: InputDecoration(labelText: 'Email'),
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          loginUser();
                        },
                        child: const Text('Login'),
                      ),
                      const SizedBox(width: 25.0),
                      TextButton(
                        onPressed: () async {
                          selectionModel.updateUserInfo(
                              email: _emailController.text,
                              password: _passwordController.text);
                          print(_emailController.text);
                          print(_passwordController.text);
                          Navigator.pushReplacementNamed(
                            context,
                            '/user_input',
                          );
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
