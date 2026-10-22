import 'package:flutter/material.dart';

/// A chat tab widget for the Insights screen that allows users
/// to interact with the Fundsy AI financial assistant.
class InsightsChatTab extends StatefulWidget {
  const InsightsChatTab({super.key});

  @override
  State<InsightsChatTab> createState() => _InsightsChatTabState();
}

class _InsightsChatTabState extends State<InsightsChatTab> {
  final TextEditingController _messageController = TextEditingController();

  // Sample chat messages list
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hello! I am your Fundsy AI assistant. How can I help you analyze your finances today?",
      isUser: false,
      timestamp: "10:30 AM",
    ),
    ChatMessage(
      text: "What was my highest expense category last month?",
      isUser: true,
      timestamp: "10:31 AM",
    ),
    ChatMessage(
      text: "Based on your records, your highest expense category last month was Food & Dining, totaling ₱8,400.00 (34% of your total spending).",
      isUser: false,
      timestamp: "10:31 AM",
    ),
  ];

  // Quick prompt suggestions for the user
  final List<String> _quickSuggestions = [
    "How much did I save this month?",
    "Analyze my budget",
    "Upcoming bills due",
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isUser: true,
          timestamp: "Just now",
        ),
      );
    });

    _messageController.clear();

    // Simulate AI response after a short delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _messages.add(
            ChatMessage(
              text: "I'm analyzing your request regarding \"$text\". Your financial health is stable this period!",
              isUser: false,
              timestamp: "Just now",
            ),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Chat messages list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              return _buildMessageBubble(message);
            },
          ),
        ),

        // Quick suggestion chips
        SizedBox(
          height: 42,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: _quickSuggestions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ActionChip(
                  label: Text(
                    _quickSuggestions[index],
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1A0B8C)),
                  ),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.grey.shade200, width: 1.2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () => _sendMessage(_quickSuggestions[index]),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),

        // Chat input text field area
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1.0)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Ask Fundsy AI anything...',
                    hintStyle: TextStyle(fontSize: 13.5, color: Colors.grey.shade400),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  onSubmitted: _sendMessage,
                ),
              ),
              GestureDetector(
                onTap: () => _sendMessage(_messageController.text),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1A0B8C),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.send_rounded, color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Helper widget to build individual message bubbles that wrap naturally based on text length
  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75, // Limits bubble width up to 75% of the screen
        ),
        decoration: BoxDecoration(
          color: message.isUser ? const Color(0xFF1A0B8C) : Colors.white,
          borderRadius: BorderRadius.circular(18.0),
          border: message.isUser ? null : Border.all(color: Colors.grey.shade100, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
                color: message.isUser ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                message.timestamp,
                style: TextStyle(
                  fontSize: 10,
                  color: message.isUser ? Colors.white70 : Colors.grey.shade400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Model class for chat messages
class ChatMessage {
  final String text;
  final bool isUser;
  final String timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}