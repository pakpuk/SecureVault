import 'package:flutter/material.dart';
import 'package:password_manager_app/theme/colors.dart';
import 'package:password_manager_app/theme/text_manager.dart';

class ProfileWidgerappBar extends StatelessWidget {
  const ProfileWidgerappBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: ColorsManager.kgrey,
          child: CircleAvatar(
            backgroundColor: ColorsManager.kwhite,
            radius: 27.5,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage(""),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Column(
          children: [
            Text(
              "Hi ${TextManger.Username}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              "Good Morning",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: ColorsManager.kgrey),
            )
          ],
        )
      ],
    );
  }
}
