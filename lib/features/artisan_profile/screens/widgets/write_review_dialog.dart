import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/artisan_profile_bloc.dart';

class WriteReviewDialog extends StatefulWidget {
  final String handymanId;

  const WriteReviewDialog({
    super.key,
    required this.handymanId,
  });

  @override
  State<WriteReviewDialog> createState() => _WriteReviewDialogState();
}

class _WriteReviewDialogState extends State<WriteReviewDialog> {
  int _rating = 5;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Write a Review',
              style: theme.textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            // Rating Section
            Text(
              'Rating',
              style: theme.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.star,
                      size: 30,
                      color: index < _rating
                          ? Colors.amber
                          : Colors.grey.shade300,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            
            // Comment Section
            Text(
              'Comment',
              style: theme.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Share your experience...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Action Buttons
            BlocConsumer<ArtisanProfileBloc, ArtisanProfileState>(
              listener: (context, state) {
                if (state.status == ArtisanProfileStatus.reviewCreated) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Review submitted successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (state.status == ArtisanProfileStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage ?? 'Failed to submit review'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: state.status == ArtisanProfileStatus.creatingReview
                          ? null
                          : () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: state.status == ArtisanProfileStatus.creatingReview ||
                              _commentController.text.trim().isEmpty
                          ? null
                          : () {
                              context.read<ArtisanProfileBloc>().add(
                                CreateReview(
                                  handymanId: widget.handymanId,
                                  rating: _rating,
                                  comment: _commentController.text.trim(),
                                ),
                              );
                            },
                      child: state.status == ArtisanProfileStatus.creatingReview
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Submit'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
