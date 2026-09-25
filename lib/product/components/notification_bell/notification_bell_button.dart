import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/controller/fragment_controller.dart';
import 'package:im2alone/core/helpers/caching_manager.dart';
import 'package:im2alone/views/account/friend_requests/friend_request_view.dart';

class NotificationBellButton extends StatefulWidget {
  const NotificationBellButton({super.key});

  @override
  State<NotificationBellButton> createState() =>
      _NotificationBellButtonState();
}

class _NotificationBellButtonState extends State<NotificationBellButton>
    with SingleTickerProviderStateMixin, CachingManager {
  final FragmentController fragmentController =
      Get.find(tag: "fragmentmanager");
  Set<String> seenIds = {};
  late final AnimationController pulseController;

  @override
  void initState() {
    super.initState();
    pulseController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
    _loadSeenIds();
  }

  @override
  void dispose() {
    pulseController.dispose();
    super.dispose();
  }

  Future<void> _loadSeenIds() async {
    final ids = await getSeenNotificationIds();
    if (mounted) {
      setState(() {
        seenIds = ids.toSet();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final unreadCount = fragmentController.notifications
          .where((notification) => !seenIds.contains(notification.id ?? ""))
          .length;
      return IconButton(
        onPressed: () async {
          await Get.to(() => const FriendRequestView());
          _loadSeenIds();
        },
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.notifications_outlined),
            if (unreadCount > 0)
              Positioned(
                top: -1,
                right: -1,
                child: AnimatedBuilder(
                  animation: pulseController,
                  builder: (context, child) {
                    final scale = 1 + pulseController.value * 0.8;
                    final ringOpacity =
                        (1 - pulseController.value).clamp(0.0, 1.0);
                    return Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Transform.scale(
                          scale: scale,
                          child: Opacity(
                            opacity: ringOpacity,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.fromBorderSide(
                                  BorderSide(color: Colors.white, width: 1.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      );
    });
  }
}
