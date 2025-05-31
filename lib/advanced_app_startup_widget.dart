import 'package:admin_v4/core/notifiers/app_startup_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Advanced widget class to manage asynchronous app initialization with retry capability
class AdvancedAppStartupWidget extends ConsumerWidget {
  const AdvancedAppStartupWidget({super.key, required this.onLoaded});
  
  final WidgetBuilder onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Eagerly initialize appStartupNotifierProvider
    final appStartupState = ref.watch(appStartupNotifierProvider);
    
    return appStartupState.when(
      // Loading state
      loading: () => const AppStartupLoadingWidget(),
      // Error state with advanced retry logic
      error: (e, st) => AppStartupErrorWidget(
        message: 'Could not load or sync data. Check your Internet connection '
            'and retry or contact support if the issue persists.',
        error: e.toString(),
        onRetry: () async {
          // Use the notifier's retry method for more sophisticated error handling
          await ref.read(appStartupNotifierProvider.notifier).retry();
        },
      ),
      // Success - now load the main app
      data: (_) => onLoaded(context),
    );
  }
}

/// Enhanced loading widget with progress indication
class AppStartupLoadingWidget extends StatefulWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  State<AppStartupLoadingWidget> createState() => _AppStartupLoadingWidgetState();
}

class _AppStartupLoadingWidgetState extends State<AppStartupLoadingWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: Icon(
                  Icons.admin_panel_settings,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Portfolio Admin',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Initializing application...',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Enhanced error widget with better error display and retry functionality
class AppStartupErrorWidget extends StatelessWidget {
  const AppStartupErrorWidget({
    super.key,
    required this.message,
    required this.error,
    required this.onRetry,
  });

  final String message;
  final String error;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 80,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 24),
                Text(
                  'Initialization Failed',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SelectableText(
                    'Error Details:\n$error',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          await onRetry();
                        } catch (e) {
                          // Error handling is managed by the provider
                        }
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton.icon(
                      onPressed: () {
                        // In a real app, you might want to show more detailed logs
                        // or provide a way to contact support
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Need Help?'),
                            content: const Text(
                              'If this problem persists, please contact support '
                              'with the error details shown above.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.help_outline),
                      label: const Text('Help'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 