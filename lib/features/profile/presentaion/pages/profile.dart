import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/home/presentaion/widgets/myappbar.dart';
import 'package:tura_app/features/profile/presentaion/bloc/userCubit.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    //double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.01,
          ),
          myappbar(screenHeight: screenHeight),
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                print('Loading properties...');
                return Center(child: CircularProgressIndicator.adaptive());
              }
              if (state is UserSuccess) {
                print('Properties loaded successfully!');
                final user = state.response;
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: screenHeight * 0.03,
                        bottom: screenHeight * 0.01,
                      ),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: Image.network(
                            user.profileImg!,
                            fit: BoxFit.cover,
                            height: screenHeight * 0.15,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        user.fullname!,
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Joined:   ${user.createdAt.split('-')[0]} / ${user.createdAt.split('-')[1]} / ${user.createdAt.split('-')[2].substring(0, 2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text(
                              'username',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                              ),
                            ),
                            trailing: Text(
                              '@${user.username!}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.verified),
                            title: Text(
                              'Verification',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                              ),
                            ),
                            trailing: Text(
                              '${user.isVerified}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text(
                              'Email',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                              ),
                            ),
                            trailing: Text(
                              user.email!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text(
                              'Phone',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                              ),
                            ),
                            trailing: Text(
                              user.phoneNumber!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.home_work_rounded),
                            title: Text(
                              'Address',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                              ),
                            ),
                            trailing: Text(
                              user.address!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.calendar_month_rounded),
                            title: Text(
                              'Born',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                              ),
                            ),
                            trailing: Text(
                              '${user.dob!.split('-')[0]} - ${user.dob!.split('-')[1]} - ${user.dob!.split('-')[2].substring(0, 2)}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.male),
                            title: Text(
                              'Gender',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                              ),
                            ),
                            trailing: Text(
                              user.gender!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.settings),
                            title: Text(
                              'Role',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                              ),
                            ),
                            trailing: Text(
                              user.role!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
              if (state is UserError) {
                print('Error: ${state.message}');
                return Center(child: Text('Error: ${state.message}'));
              }
              print('user myData()');
              return SizedBox.shrink(); // Default case (initial state, etc.)
            },
          )
        ],
      ),
    );
  }
}
