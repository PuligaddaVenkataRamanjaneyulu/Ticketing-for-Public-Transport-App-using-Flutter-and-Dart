// lib/screens/login_screen.dart
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  /// Call with Navigator.pushNamed(context, '/auth') or set as route.
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _name = '';
  bool _obscure = true;
  bool _loading = false;

  void _toggleMode() => setState(() => _isLogin = !_isLogin);

  Future<void> _submit() async {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;
    _formKey.currentState?.save();

    setState(() => _loading = true);

    // Simulate network/auth delay - replace with real auth call
    await Future.delayed(const Duration(milliseconds: 900));

    setState(() => _loading = false);

    // On success, navigate to home. In real app: check auth result.
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _forgotPassword() {
    // Simple dialog demonstration — replace with real flow
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Reset password'),
        content: const Text('A password reset link would be sent to your email (demo).'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }

  Widget _socialButton(IconData icon, String label, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        minimumSize: const Size.fromHeight(44),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // logo
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
                  child: const Icon(Icons.directions_bus, size: 56, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Text(_isLogin ? 'Welcome back' : 'Create account',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(_isLogin ? 'Login to continue' : 'Sign up to get started', style: TextStyle(color: Colors.grey[700])),

                const SizedBox(height: 20),

                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        if (!_isLogin) ...[
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Full name', prefixIcon: Icon(Icons.person)),
                            textInputAction: TextInputAction.next,
                            onSaved: (v) => _name = v?.trim() ?? '',
                            validator: (v) {
                              if (_isLogin) return null;
                              if (v == null || v.trim().length < 2) return 'Enter your name';
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                        ],

                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email)),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onSaved: (v) => _email = v?.trim() ?? '',
                          validator: (v) {
                            if (v == null || !v.contains('@')) return 'Enter a valid email';
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),

                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                          ),
                          obscureText: _obscure,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submit(),
                          onSaved: (v) => _password = v ?? '',
                          validator: (v) {
                            if (v == null || v.length < 6) return 'Password must be 6+ chars';
                            return null;
                          },
                        ),

                        const SizedBox(height: 14),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _forgotPassword,
                            child: const Text('Forgot password?'),
                          ),
                        ),

                        const SizedBox(height: 6),

                        _loading
                            ? const SizedBox(height: 48, child: Center(child: CircularProgressIndicator()))
                            : ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                                child: Text(_isLogin ? 'Login' : 'Create account'),
                              ),

                        const SizedBox(height: 8),

                        TextButton(
                          onPressed: _toggleMode,
                          child: Text(_isLogin ? "Don't have an account? Sign up" : 'Already have an account? Login'),
                        ),
                      ]),
                    ),
                  ),
                ),

                const SizedBox(height: 14),
                const Text('or continue with', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: _socialButton(Icons.g_mobiledata, 'Google', () {
                        // TODO: integrate Google sign-in
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Google sign-in (demo)')));
                      }),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _socialButton(Icons.apple, 'Apple', () {
                        // TODO: integrate Apple sign-in
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Apple sign-in (demo)')));
                      }),
                    ),
                  ],
                ),

                const SizedBox(height: 18),
                Text('By continuing you agree to our Terms & Privacy', style: TextStyle(color: Colors.grey[600], fontSize: 12), textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
