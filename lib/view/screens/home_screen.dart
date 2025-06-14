import 'package:flutter/material.dart';
import 'package:password_manager_app/providers/password_provider.dart';
import 'package:password_manager_app/theme/colors.dart';
import 'package:password_manager_app/theme/text_manager.dart';
import 'package:password_manager_app/view/widgets/App_bar_icon.dart';
import 'package:password_manager_app/view/widgets/password_container_widget.dart';
import 'package:password_manager_app/view/widgets/profile_widgerapp_bar.dart';
import 'package:password_manager_app/view/widgets/search_wdget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwords = ref.watch(passwordsProvider);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => bottomModal(context),
        backgroundColor: Constants.fabBackground,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProfileWidgerappBar(),
                AppBarIcon(icon: Icons.notifications_none),
              ],
            ),
            SizedBox(height: 16),
            SearchWidget(),
            SizedBox(height: 8),
            Text(
              TextManger.Categorytit,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: passwords.length,
                itemBuilder: (context, index) {
                  final password = passwords[index];
                  return PasswordCard(password: password);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
