import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final String _community = 'Select a community';

  @override
  Widget build(BuildContext context) {
    final canPost = _titleController.text.trim().isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Create post'),
        actions: [
          TextButton(
            onPressed: canPost
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Publicacion simulada creada')),
                    );
                    Navigator.pop(context);
                  }
                : null,
            child: Text(
              'Post',
              style: TextStyle(
                color: canPost ? AppColors.redditOrange : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.groups_outlined, size: 18),
              label: Text(_community),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              onChanged: (_) => setState(() {}),
              style: Theme.of(context).textTheme.headlineSmall,
              decoration: const InputDecoration(
                hintText: 'Start with a title',
                border: InputBorder.none,
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('Add tags & flair (optional)'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _bodyController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  hintText: 'Add some details',
                  border: InputBorder.none,
                ),
              ),
            ),
            const Row(
              children: [
                Icon(Icons.link),
                SizedBox(width: 20),
                Icon(Icons.image_outlined),
                SizedBox(width: 20),
                Icon(Icons.play_circle_outline),
                SizedBox(width: 20),
                Icon(Icons.poll_outlined),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
