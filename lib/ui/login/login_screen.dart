import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:admin_v4/core/auth/auth_notifier.dart';
import 'dart:developer';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'master@mayankjoshi.in');
  final _passwordController = TextEditingController(text: 'M0rpheus@@22');
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    log('LoginScreen: Login button pressed');
    
    if (!_formKey.currentState!.validate()) {
      log('LoginScreen: Form validation failed');
      return;
    }

    setState(() => _isLoading = true);
    log('LoginScreen: Setting loading state to true');
    
    try {
      log('LoginScreen: Starting login process...');
      
      log('LoginScreen: Calling auth notifier loginViaEmailAndPassword...');
      // Update authentication state
      final isLoggedIn = await ref.read(authNotifierProvider.notifier).loginViaEmailAndPassword(_emailController.text, _passwordController.text);
      
      log('LoginScreen: Login completed successfully: $isLoggedIn');
      // Navigation should be handled automatically by GoRouter redirect
    } catch (e) {
      log('LoginScreen: Login error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
        log('LoginScreen: Setting loading state to false');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the auth state for debugging
    final isLoggedIn = ref.watch(authNotifierProvider);
    log('LoginScreen: Current auth state: $isLoggedIn');

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add debug info
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey[200],
                child: Text('Debug: isLoggedIn = $isLoggedIn'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter email';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter password';
                  return null;
                },
                onFieldSubmitted: (_) => _login(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : () {
                    log('LoginScreen: Button onPressed called');
                    _login();
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                ),
              ),
              TextButton(
                onPressed: () => context.go('/signup'),
                child: const Text('Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}