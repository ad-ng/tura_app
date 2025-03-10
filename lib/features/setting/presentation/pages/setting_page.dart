import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tura_app/core/theme/theme_cubit.dart';
import 'package:tura_app/features/Setting/presentation/pages/updateProfile.dart';
import 'package:tura_app/features/login/data/datasources/local/userPreferences.dart';
import 'package:tura_app/features/profile/presentaion/bloc/userCubit.dart';
import 'package:tura_app/features/setting/presentation/pages/changePassword.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isDarkMode = false;
  bool notificationEnabled = true;
  bool emailEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          'Settings',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                print('Loading properties...');
                return Center(child: CircularProgressIndicator.adaptive());
              }
              if (state is UserSuccess) {
                return Card(
                  margin: EdgeInsets.all(12),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        state.response.profileImg!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(state.response.fullname!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    subtitle: Text(
                      'Edit Personal Details',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return UpdateProfile(
                                fullnameController: TextEditingController(
                                  text: state.response.fullname,
                                ),
                                addressController: TextEditingController(
                                  text: state.response.address,
                                ),
                                dateController: TextEditingController(
                                  text: state.response.dob,
                                ),
                                emailController: TextEditingController(
                                  text: state.response.email,
                                ),
                                genderController: TextEditingController(
                                  text: state.response.gender,
                                ),
                                phoneNumberController: TextEditingController(
                                  text: state.response.phoneNumber,
                                ),
                                usernameController: TextEditingController(
                                  text: state.response.username,
                                ),
                                user: state.response,
                              );
                            },
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              leading: Image.asset(
                '././lib/images/moon.png',
                width: 35,
              ),
              title: Text(
                'Dark Mode',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) {
                  BlocProvider.of<ThemeCubit>(context).toggleTheme();
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 15),
            child: Text(
              'Notifications',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
            child: Column(
              children: [
                ListTile(
                  leading: Image.asset(
                    '././lib/images/bell.png',
                    width: 27,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    'Notification',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Switch(
                    value: notificationEnabled,
                    onChanged: (value) {
                      setState(() {
                        notificationEnabled = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.email_outlined,
                    size: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    'Emails',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Switch(
                    value: emailEnabled,
                    onChanged: (value) {
                      setState(() {
                        emailEnabled = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 15),
            child: Text(
              'Account',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Changepassword(),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.lock_person_outlined,
                      size: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    title: Text(
                      'Change Password',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 15),
            child: Text(
              'Regional',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.language,
                    color: Theme.of(context).colorScheme.primary,
                    size: 30,
                  ),
                  title: Text('Change Language',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.star,
                    color: Theme.of(context).colorScheme.primary,
                    size: 30,
                  ),
                  title: Text(
                    'Rate Us',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await Share.share(
                      'check out https://www.turaestates.com',
                      subject: 'Real estate app',
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.share,
                      color: Theme.of(context).colorScheme.primary,
                      size: 30,
                    ),
                    title: Text(
                      'Share App',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await UserPreferences().removeLocalUser();
                    Navigator.pushReplacementNamed(context, 'loginPage');
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.logout_outlined,
                      color: Theme.of(context).colorScheme.primary,
                      size: 30,
                    ),
                    title: Text('Log Out',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
