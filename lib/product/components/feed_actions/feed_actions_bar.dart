import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/radius/project_radius.dart';
import '../../theme/colors/app_colors.dart';

class FeedActionsBar extends StatelessWidget {
  final int likes;
  final int views;
  final bool liked;
  final bool showLikeButton;
  final VoidCallback? onLikeTap;

  const FeedActionsBar({
    super.key,
    required this.likes,
    required this.views,
    required this.liked,
    required this.showLikeButton,
    this.onLikeTap,
  });

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;
    return Row(
      children: [
        showLikeButton
            ? InkWell(
                onTap: onLikeTap,
                borderRadius: ProjectRadius.circular30(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        liked ? Icons.favorite : Icons.favorite_border,
                        color: liked ? AppColors.like : surfaceColor,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$likes',
                        style: TextStyle(
                          color: liked ? AppColors.like : surfaceColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.favorite, color: AppColors.like, size: 18),
                  const SizedBox(width: 6),
                  Text('$likes', style: TextStyle(color: surfaceColor)),
                ],
              ),
        const Spacer(),
        Icon(Icons.remove_red_eye_outlined,
            size: 16, color: surfaceColor.withValues(alpha: 0.6)),
        const SizedBox(width: 6),
        Text(
          '$views ${'views'.tr}',
          style: TextStyle(color: surfaceColor.withValues(alpha: 0.6), fontSize: 12),
        ),
      ],
    );
  }
}
