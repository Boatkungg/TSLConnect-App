import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:camera/camera.dart";
import "package:myapp/sign2thai.dart";
import "package:myapp/thai2sign.dart";
import "package:myapp/navigation.dart";

// camera
// late List<CameraDescription> cameras;

// navigator
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");
final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "shell");

// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart#L170
// https://stackoverflow.com/questions/71011598/how-to-work-with-navigationbar-in-go-router-flutter

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // camera
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print(e);
    return;
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: "/sign2thai",
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          return Navigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKey,
            routes: [
              GoRoute(
                path: "/sign2thai",
                builder: (BuildContext context, GoRouterState state) {
                  return const Sign2Thai();
                },
              ),
              GoRoute(
                path: "/thai2sign",
                builder: (BuildContext context, GoRouterState state) {
                  return const Thai2Sign();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "TSLConnect",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
      ),
      themeMode: ThemeMode.dark,
      routerConfig: _router,
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "TSLConnect",
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//       ),
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//         primarySwatch: Colors.red,
//       ),
//       themeMode: ThemeMode.dark,
//       home: const Aaa(),
//     );
//   }
// }

class Aaa extends StatelessWidget {
  const Aaa({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Translation"),
      ),
    );
  }
}

class Bbb extends StatelessWidget {
  const Bbb({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Translation2"),
      ),
    );
  }
}
