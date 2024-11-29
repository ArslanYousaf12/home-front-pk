// lib/src/features/welcome/presentation/welcome_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/routing/app_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE7F9F9), // Light mint
              Colors.white,
              Color(0xFFABEDD8), // Soft mint
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              // Welcome Text with Animation
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F6B69),
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please Select',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 40),
              // Main Action Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _WelcomeButton(
                      title: 'Buy Service',
                      subtitle: 'Find the perfect service provider',
                      icon: Icons.shopping_bag_outlined,
                      onTap: () => context.goNamed(AppRoute.signInClient.name),
                      gradientColors: const [
                        Color(0xFF46CDCF),
                        Color(0xFF3D84A8),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _WelcomeButton(
                      title: 'Sell Service',
                      subtitle: 'Start earning as a service provider',
                      icon: Icons.construction,
                      onTap: () => context.goNamed(AppRoute.seller.name),
                      gradientColors: const [
                        Color(0xFF48466D),
                        Color(0xFF3D84A8),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Bottom Design Element
              Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0),
                      const Color(0xFFABEDD8).withOpacity(0.3),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    'Find the perfect match for your project',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final List<Color> gradientColors;

  const _WelcomeButton({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradientColors[0].withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
