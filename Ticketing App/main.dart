import 'package:flutter/material.dart';

// Import screens
import 'screens/splash_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/ticket_booking_screen.dart';
import 'screens/qr_ticket_screen.dart';
import 'screens/live_tracking_screen.dart';
import 'screens/topup_wallet_screen.dart';
import 'screens/history_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/setting_screen.dart';

// Import app theme
import 'screens/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ETicketingApp());
}

class ETicketingApp extends StatelessWidget {
  const ETicketingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Ticketing App',
      theme: AppTheme.lightTheme, // use your theme

      // Initial route
      home: const SplashScreen(),

      // Named routes
      routes: {
        '/auth': (_) => const AuthScreen(),
        '/home': (_) => const HomeScreen(),
        '/booking': (_) => const TicketBookingScreen(),
        '/qr': (_) => const QRTicketScreen(),
        '/live': (_) => const LiveTrackingScreen(),
        '/topup': (_) => const TopUpWalletScreen(),
        '/history': (_) => const HistoryScreen(),
        '/profile': (_) => const ProfileScreen(),
        '/settings': (_) => const SettingsScreen(),
      },
    );
  }
}
