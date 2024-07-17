import 'package:flutter/material.dart';
import 'package:we_chat/presentation/components/list_tile.dart';

class DrawerComponent extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOutTap;
  const DrawerComponent({
    super.key,
    required this.onProfileTap,
    required this.onSignOutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        children: [
          //header
          const DrawerHeader(
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 64,
            ),
          ),
          //home list
          ListTileUpd(
            icon: Icons.home,
            text: 'HOME',
            onTap: () => Navigator.pop(context),
          ),
          //profile list
          ListTileUpd(
            icon: Icons.person_4,
            text: 'PROFILE',
            onTap: onProfileTap,
          ),
          //logout list
          ListTileUpd(
            icon: Icons.logout,
            text: 'LOGOUT',
            onTap: onSignOutTap,
          ),
        ],
      ),
    );
  }
}
