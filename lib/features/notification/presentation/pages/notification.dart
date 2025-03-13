import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/notification/presentation/cubit/allnotiCubit.dart';
import 'package:tura_app/features/notification/presentation/widgets/eachNotificationCard.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllNotiCubit, NotificationState>(
      builder: (context, state) {
        if (state is NotificationLoading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is NotificationError) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is NotificationSuccess) {
          return ListView.builder(
              itemCount: state.response.length,
              itemBuilder: (BuildContext context, int index) {
                return Eachnotificationcard(
                  notification: state.response[index],
                );
              });
        }
        return SizedBox.shrink();
      },
    );
  }
}
