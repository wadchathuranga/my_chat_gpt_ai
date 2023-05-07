import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/chat_provider.dart';
import './providers/models_provider.dart';
import './screens/chat_screen.dart';
import './utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: cardColor,
          ),
          scaffoldBackgroundColor: scaffoldBackgroundColor,
        ),
        home: const ChatScreen(),
      ),
    );
  }
}

