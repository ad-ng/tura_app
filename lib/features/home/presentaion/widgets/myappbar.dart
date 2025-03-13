import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popover/popover.dart';
import 'package:tura_app/features/home/presentaion/widgets/myFilter.dart';
import 'package:tura_app/features/notification/presentation/cubit/unreadCubit.dart';
import 'package:tura_app/features/notification/presentation/pages/notification.dart';

class myappbar extends StatefulWidget {
  const myappbar({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  State<myappbar> createState() => _myappbarState();
}

class _myappbarState extends State<myappbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: Image.asset(
                '././lib/images/menu.png',
                color: Theme.of(context).colorScheme.secondary,
                height: widget.screenHeight * 0.045,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          SizedBox(),
          Image.asset(
            '././lib/images/logo.png',
            color: Theme.of(context).colorScheme.secondary,
            height: widget.screenHeight * 0.07,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => showPopover(
                  context: context,
                  height: MediaQuery.of(context).size.height * 0.38,
                  width: MediaQuery.of(context).size.width * 0.9,
                  direction: PopoverDirection.top,
                  contentDxOffset: MediaQuery.of(context).size.width * 0.6,
                  bodyBuilder: (context) {
                    return MyFilter();
                  },
                ),
                icon: Image.asset(
                  '././lib/images/options.png',
                  color: Theme.of(context).colorScheme.secondary,
                  height: widget.screenHeight * 0.025,
                ),
              ),
              IconButton(
                onPressed: () {
                  showPopover(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    context: context,
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.93,
                    direction: PopoverDirection.top,
                    contentDxOffset: MediaQuery.of(context).size.width * 0.8,
                    bodyBuilder: (context) {
                      return NotificationPage();
                    },
                  );
                },
                icon: Badge(
                  backgroundColor: Colors.amber,
                  label: BlocBuilder<UnreadCubit, UnreadNotificationState>(
                    builder: (context, state) {
                      if (state is UnreadNotificationSuccess) {
                        return Text(
                          '${state.response.length}',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        );
                      }

                      return Text('');
                    },
                  ),
                  child: Image.asset(
                    '././lib/images/bell.png',
                    color: Theme.of(context).colorScheme.secondary,
                    height: widget.screenHeight * 0.03,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
