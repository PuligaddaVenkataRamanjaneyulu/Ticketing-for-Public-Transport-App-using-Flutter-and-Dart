import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  String email = '', password = '';

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(height: 12),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              BackButton(color: primary),
              Text(isLogin ? 'Login' : 'Sign up', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(width: 48)
            ]),
            SizedBox(height: 24),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => v != null && v.contains('@') ? null : 'Enter a valid email',
                      onSaved: (v) => email = v ?? '',
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (v) => v != null && v.length >= 6 ? null : 'Min 6 chars',
                      onSaved: (v) => password = v ?? '',
                    ),
                    SizedBox(height: 18),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 48)),
                      child: Text(isLogin ? 'Login' : 'Create account'),
                    ),
                    SizedBox(height: 8),
                    TextButton(onPressed: () => setState(() => isLogin = !isLogin), child: Text(isLogin ? "Don’t have an account? Sign up" : 'Already have an account? Login'))
                  ]),
                ),
              ),
            ),
            Spacer(),
            Text('Fast · Secure · Contactless', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 12),
          ]),
        ),
      ),
    );
  }
}
