
import 'package:home_front_pk/src/features/new_requests/domain/request.dart';

final List<Request> ktestserviceRequests = [
  Request(
    id: '1',
    title: 'House Map Design',
    location: 'B-17, Islamabad',
    name: 'Ayesha Mahmood',
  ),
  Request(
    id: '2',
    title: '3D Interior Modeling',
    location: 'DHA Phase II, Islamabad',
    name: 'Faisal Khan',
  ),
  Request(
    id: '3',
    title: 'Residential Construction',
    location: 'Bahria Town, Islamabad',
    name: 'Hassan Raza',
  ),
  Request(
    id: '4',
    title: 'Commercial Building Design',
    location: 'G-11 Markaz, Islamabad',
    name: 'Sana Iqbal',
  ),
  Request(
    id: '5',
    title: 'Renovation Services',
    location: 'F-6 Sector, Islamabad',
    name: 'Khalid Mehmood',
  ),
];

// Function to regenerate IDs for the service requests
// void regenerateIDs() {
//   for (var request in serviceRequests) {
//     request.id = 'task#${Random().nextInt(9999) + 1}';
//   }
// }
