import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tura_app/features/home/presentaion/widgets/myappbar.dart';
import 'package:tura_app/features/profile/presentaion/bloc/userCubit.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
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
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.01),
                        height: screenHeight * 0.21,
                        width: screenWidth,
                        child: Image.network(
                          user.coverImg!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: screenHeight * 0.13,
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
                    ],
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
                  Container(
                    color: Theme.of(context).colorScheme.background,
                    child: DataTable(
                      dividerThickness: 0,
                      columns: <DataColumn>[
                        DataColumn(label: Text('Information')),
                        DataColumn(label: Text('value'))
                      ],
                      rows: <DataRow>[
                        DataRow(cells: [
                          DataCell(Text('username')),
                          DataCell(Text(user.username!))
                        ]),
                        DataRow(cells: [
                          DataCell(Text('email')),
                          DataCell(Text('${user.email}'))
                        ]),
                        DataRow(cells: [
                          DataCell(Text('gender')),
                          DataCell(Text('${user.gender}'))
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Phone Number')),
                          DataCell(Text('${user.phoneNumber}'))
                        ]),
                        DataRow(cells: [
                          DataCell(Text('address')),
                          DataCell(Text('${user.address}'))
                        ]),
                        DataRow(cells: [
                          DataCell(Text('born at')),
                          DataCell(Text(
                              '${user.dob!.split('-')[0]} - ${user.dob!.split('-')[1]} - ${user.dob!.split('-')[2].substring(0, 2)}'))
                        ]),
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
    ));
  }
}
