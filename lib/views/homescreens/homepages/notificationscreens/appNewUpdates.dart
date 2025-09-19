import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localmarket/allpaths.dart';
import 'package:localmarket/riverpad/firebaseriverpad/firebaseproviders.dart';
import 'package:localmarket/riverpad/firebaseriverpad/profileproviders.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationscreensState();
}

class _NotificationscreensState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    AddUserData().seenNotification();
  }


  void _onDismissed(String notificationId, int index, List notifications) {
    final deletedMessage = notifications[index];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notification removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {

          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final firebaseda = ref.watch(firebasedata);
    final userEmail = ref.watch(profileproviders);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: firebaseda.when(
          data: (valu) {
            final userData = valu.docs.where((e) => e["useremail"] == userEmail.value).toList();
            if (userData.isEmpty || userData[0]["notification"].isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_off_outlined, size: 80, color: Colors.grey),
                    SizedBox(height: 20),
                    Text(
                      "No notifications yet",
                      style: TextStyle(fontFamily: "title", fontSize: 20, color: Colors.grey),
                    ),
                  ],
                ),
              );
            } else {
              final userNotifications = userData[0]["notification"] as List;
              return ListView.separated(
                itemCount: userNotifications.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final message = userNotifications[index];
                  return _buildNotificationWidget(message, index, userNotifications);
                },
              );
            }
          },
          error: (err, sta) => Center(
            child: Text(err.toString()),
          ),
          loading: () => const Center(
            child: CupertinoActivityIndicator(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationWidget(Map<String, dynamic> message, int index, List notifications) {
    return Dismissible(
      key: ValueKey(message["id"]),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction){
        AddUserData().deleteNotification(message["id"]);
        _onDismissed(message["id"], index, notifications);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Theme.of(context).brightness == Brightness.dark
        ? AppColors.containerDarkMode
        : AppColors.containerLightMode, // تھیم سے رنگ لیں
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.notifications_active, color: Colors.white),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message["title"] ?? "No Title",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "title",
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      message["body"] ?? "No body",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontFamily: "body_p",
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                message["datetime"],
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: "body_c",
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}