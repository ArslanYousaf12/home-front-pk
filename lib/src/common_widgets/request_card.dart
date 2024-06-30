import 'package:flutter/material.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';

class NewRequestCard extends StatelessWidget {
  const NewRequestCard(
      {super.key,
      required this.id,
      required this.title,
      required this.name,
      required this.location});

  final String id;
  final String title;
  final String name;
  final String location;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Theme(
        data: ThemeData(
            textTheme: const TextTheme()
                .copyWith()
                .apply(bodyColor: Colors.black, displayColor: Colors.black)),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Task#$id',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54),
                ),
                gapH4,
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 72, 143, 75)),
                ),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(
                    location,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                gapH12,
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(
                    name,
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
                gapH20,
                Row(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Detail',
                          style: TextStyle(fontSize: 20),
                        )),
                    gapW32,
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Accept',
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
