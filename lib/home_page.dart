import 'package:flutter/material.dart';
import 'api_service.dart';
import 'model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<UserModel>> _futureUsers;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _futureUsers = _apiService.fetchUsers(); // Initialize _futureUsers
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: FutureBuilder<List<UserModel>>(
        future: _futureUsers,
        builder:
            (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load data: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    // height: 240,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.2), // Shadow color with opacity
                          offset:
                              Offset(0, 4), // Horizontal and vertical offset
                          blurRadius: 8, // Blur radius
                          spreadRadius: 2, // Spread radius
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailRow(
                            user: user,
                            label: "Name",
                            labelValue: user.name!,
                          ),
                          const Divider(thickness: 1),
                          DetailRow(
                            user: user,
                            label: "Email",
                            labelValue: user.email!,
                          ),
                          const Divider(thickness: 1),
                          DetailRow(
                            user: user,
                            label: "City",
                            labelValue: user.address!.city!,
                          ),
                          const Divider(thickness: 1),
                          DetailRow(
                            user: user,
                            label: "Phone",
                            labelValue: user.phone!,
                          ),
                          const Divider(thickness: 1),
                          DetailRow(
                            user: user,
                            label: "Website",
                            labelValue: user.website!,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label, labelValue;
  const DetailRow({
    super.key,
    required this.user,
    required this.label,
    required this.labelValue,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(
          labelValue,
          textAlign: TextAlign.start,
        )
      ],
    );
  }
}
