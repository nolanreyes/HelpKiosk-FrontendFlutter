import 'package:flutter/material.dart';

class ChatBotWidget extends StatefulWidget {
  @override
  _ChatBotWidgetState createState() => _ChatBotWidgetState();
}

class _ChatBotWidgetState extends State<ChatBotWidget> {
  final String _greetingMessage = 'Hello, how can I help you today?';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0), // Set the corners as rounded
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Chat messages
            Expanded(
              child: ListView(
                // TODO: Populate with actual chat messages
                children: [],
              ),
            ),
            // Microphone button and greeting message
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Microphone button
                  IconButton(
                    icon: Icon(Icons.mic),
                    iconSize: 90.0,
                    onPressed: () {
                      // TODO: Handle voice input
                    },
                  ),
                  // Greeting message
                  Expanded(
                    child: Text(
                      _greetingMessage,
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}