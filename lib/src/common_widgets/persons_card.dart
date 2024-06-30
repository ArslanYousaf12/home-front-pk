import 'package:flutter/material.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({
    super.key,
    required this.id,
    required this.title,
    required this.name,
    required this.location,
    required this.contact,
  });

  final String id;
  final String title;
  final String name;
  final String location;
  final VoidCallback contact;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Worker#$id',
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.black54),
            ),
            gapH12,
            Text(
              title,
              style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 72, 143, 75)),
            ),
            Expanded(
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: const Icon(Icons.location_on),
                title: Text(
                  location,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: const Icon(Icons.person),
                title: Text(
                  name,
                  style: const TextStyle(fontSize: 17),
                ),
              ),
            ),
            gapH12,
            Expanded(
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Detail',
                        style: TextStyle(fontSize: 12),
                      )),
                  gapW16,
                  ElevatedButton(
                      onPressed: contact,
                      child: const Text(
                        'Contact',
                        style: TextStyle(fontSize: 12),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
