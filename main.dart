void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Initialize secure storage
  final secureStorage = FlutterSecureStorage();
  
  runApp(
    ProviderScope(
      overrides: [
        secureStorageProvider.overrideWithValue(secureStorage),
      ],
      child: const SecureApp(),
    ),
  );
}

class SecureApp extends ConsumerWidget {
  const SecureApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    
    return MaterialApp(
      title: 'Secure Encryption App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: authState.status == AuthStatus.authenticated
          ? const HomePage()
          : const AuthPage(),
    );
  }
}
