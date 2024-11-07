import '../widgets/app_bar_gone.dart';
import '../widgets/header.dart';
import 'dart:convert';
import 'package:floob/data/models/location.dart';
import 'package:floob/data/models/user.dart';
import 'package:floob/states/controllers/location_controller.dart';
import 'package:floob/states/controllers/user_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

/// This is just an example on how to use the Floob api
class ApiExampleScreen extends ConsumerWidget {
  const ApiExampleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarGone(),

      body: Material(
        color: Theme.of(context).colorScheme.surface,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            const Header(text: 'app_name'),
            Column(children: <Widget>[
              // Getting all users from api on page load
              const Text('Get all users'),
              FutureBuilder<List<User>>(
                future: ref.watch(userControllerProvider).getUsers(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
                  print('Rendering future builder');
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No users found');
                  }

                  // Show the data
                  return Text(jsonEncode(snapshot.data));
                },
              ),

              const SizedBox(height: 16),

              // Getting user with id 1 from api on page load
              const Text('Get user with id 1'),
              FutureBuilder<User?>(
                future: ref.watch(userControllerProvider).getUser('1'),
                builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return const Text('No users found');
                  }

                  // Show the data
                  return Text(jsonEncode(snapshot.data));
                },
              ),

              const Padding(
                padding: EdgeInsets.all(16),
                child: Divider(),
              ),

              // Getting all locations from api on page load
              const Text('Get all locations'),
              FutureBuilder<List<Location>>(
                future: ref.watch(locationControllerProvider).getLocations(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Location>> snapshot) {
                  print('Rendering future builder');
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No locations found');
                  }

                  // Show the data
                  return Text(jsonEncode(snapshot.data));
                },
              ),

              const SizedBox(height: 16),

              // Getting location with id 1 from api on page load
              const Text('Get locations with id 1'),
              FutureBuilder<Location?>(
                future: ref.watch(locationControllerProvider).getLocation('1'),
                builder:
                    (BuildContext context, AsyncSnapshot<Location?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return const Text('No locations found');
                  }

                  // Show the data
                  return Text(jsonEncode(snapshot.data));
                },
              ),
            ]),
            const SizedBox(height: 36),
          ],
        ),
      ),

      // bottomNavigationBar: const BottomNavBar(),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
