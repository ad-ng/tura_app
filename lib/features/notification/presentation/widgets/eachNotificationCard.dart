import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popover/popover.dart';
import 'package:tura_app/features/notification/data/datasource/notificationApiService.dart';
import 'package:tura_app/features/notification/data/model/notificationModel.dart';
import 'package:tura_app/features/notification/presentation/cubit/allnotiCubit.dart';
import 'package:tura_app/features/notification/presentation/cubit/unreadCubit.dart';

class Eachnotificationcard extends StatefulWidget {
  final NotificationModel notification;
  const Eachnotificationcard({super.key, required this.notification});

  @override
  State<Eachnotificationcard> createState() => _EachnotificationcardState();
}

class _EachnotificationcardState extends State<Eachnotificationcard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: (widget.notification.isRead!)
          ? Colors.black54
          : Theme.of(context).colorScheme.secondary,
      margin: EdgeInsets.only(
        left: 6,
        right: 6,
        top: 6,
      ),
      child: ListTile(
        key: ValueKey(widget.notification.id),
        minVerticalPadding: 5,
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
        leading: Container(
          height: 40,
          width: 40,
          color: Colors.amber,
        ),
        title: Text(
          widget.notification.title!,
          style: TextStyle(color: Theme.of(context).colorScheme.surface),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${widget.notification.message!.substring(0, 50)}.....',
              style: TextStyle(
                  color: (widget.notification.isRead!)
                      ? Colors.white
                      : Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.notification.createdAt!.substring(0, 10)}',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.surface),
                ),
                Text(
                  '${widget.notification.createdAt!.substring(11, 16)}',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.surface),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            showPopover(
              context: context,
              height: 100,
              arrowHeight: 0,
              width: MediaQuery.of(context).size.width * 0.5,
              direction: PopoverDirection.bottom,
              bodyBuilder: (context) {
                return Column(
                  children: [
                    Container(
                      color: Colors.amber,
                      height: 50,
                      width: 300,
                      child: ListTile(
                        onTap: () async {
                          await NotificationApiService()
                              .readNotification(widget.notification.id!);
                          BlocProvider.of<UnreadCubit>(context)
                              .fetchUnreadNotifications();
                          BlocProvider.of<AllNotiCubit>(context)
                              .fetchAllNotifications();
                          Navigator.pop(context);
                        },
                        title: Text('Mark as read'),
                        trailing: Icon(Icons.open_in_browser_outlined),
                      ),
                    ),
                    Container(
                      color: Colors.blue,
                      height: 50,
                      width: 300,
                      child: ListTile(
                        onTap: () async {
                          await NotificationApiService()
                              .deleteNotification(widget.notification.id!);
                          BlocProvider.of<UnreadCubit>(context)
                              .fetchUnreadNotifications();
                          BlocProvider.of<AllNotiCubit>(context)
                              .fetchAllNotifications();
                          Navigator.pop(context);
                        },
                        title: Text(
                          'Delete',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          },
          icon: Icon(
            Icons.more_vert_outlined,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
