// lib/screens/detail/widgets/comments_section.dart

import 'package:flutter/material.dart';
import '../../../data/mock_data.dart';

class CommentsSection extends StatefulWidget {
  final String modelId;
  const CommentsSection({super.key, required this.modelId});

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  late List<MockComment> _comments;
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _comments = List.from(mockComments[widget.modelId] ?? []);
  }

  void _postComment() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _comments.add(
        MockComment(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          username: mockCurrentUsername,
          text: text,
          timestamp: DateTime.now(),
        ),
      );
    });
    _inputController.clear();
  }

  void _deleteComment(String id) {
    setState(() => _comments.removeWhere((c) => c.id == id));
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isGuest = mockCurrentUserRole == 'guest';
    final isAdmin = mockCurrentUserRole == 'admin';
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Comments',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 12),
          if (_comments.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'No comments yet.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            )
          else
            ..._comments.map((c) => _buildCommentTile(c, isAdmin)),
          const SizedBox(height: 8),
          if (!isGuest) _buildCommentInput() else _buildGuestPrompt(),
        ],
      ),
    );
  }

  Widget _buildCommentTile(MockComment comment, bool isAdmin) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7FB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                comment.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const Spacer(),
              Text(
                '${comment.timestamp.year}-${comment.timestamp.month.toString().padLeft(2, '0')}-${comment.timestamp.day.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              if (isAdmin) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _deleteComment(comment.id),
                  child: const Icon(
                    Icons.delete_outline,
                    size: 16,
                    color: Color(0xFFE94560),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            comment.text,
            style: const TextStyle(fontSize: 13, color: Color(0xFF444444)),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _inputController,
            decoration: InputDecoration(
              hintText: 'Write a comment...',
              hintStyle: const TextStyle(fontSize: 13),
              filled: true,
              fillColor: const Color(0xFFF0F0F8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
            ),
            style: const TextStyle(fontSize: 13),
            maxLines: 1,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: _postComment,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.send, color: Colors.white, size: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildGuestPrompt() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          Icon(Icons.lock_outline, size: 14, color: Colors.grey),
          SizedBox(width: 8),
          Text(
            'Log in to post a comment.',
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
