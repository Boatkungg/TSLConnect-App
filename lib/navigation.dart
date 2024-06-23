import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class Navigation extends StatefulWidget {
  const Navigation({
    required this.navigationShell,
    super.key
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndex = 0;

  List translateIcon = [
    const Row(
      children: [
        Icon(Icons.sign_language, size: 30),
        Icon(Icons.swap_horiz, size: 30),
        Icon(Icons.translate, size: 30),
      ],
    ),
    const Row(
      children: [
        Icon(Icons.translate, size: 30),
        Icon(Icons.swap_horiz, size: 30),
        Icon(Icons.sign_language, size: 30),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void changeTab() {
      setState(() {
        currentIndex = currentIndex == 0 ? 1 : 0;
      });

      switch (currentIndex) {
        case 0:
          context.go("/sign2thai");
          break;
        case 1:
          context.go("/thai2sign");
          break;
        default:
          context.go("/sign2thai");
          break;
      }
    }

    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: Container(
        height: 60,
        color: theme.colorScheme.surfaceContainer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, 
          children: [
            IconButton(
              icon: translateIcon[currentIndex],
              onPressed: () => changeTab(),
            ),
          ],
        ),
      ),
    );
  }
}