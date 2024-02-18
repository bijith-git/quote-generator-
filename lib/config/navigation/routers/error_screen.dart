import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_generator/config/config.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Oops, Something went wrong!',
          style: textTheme.headlineMedium,
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go(RouteLocation.createdByYou),
          child: Text(
            'Go to home screen',
            style: textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
