import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/provider/user_details_provider.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            Provider.of<UserDataProvider>(context, listen: false).initUserData(isrefresh: true),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Consumer<UserDataProvider>(
            builder: (context, userDataProvider, _) {
              if (userDataProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (userDataProvider.error != null && userDataProvider.userData.isEmpty) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.89,
                    child: Center(child: Text('${userDataProvider.error}')),
                  ),
                );
              } else if (userDataProvider.userData.isEmpty) {
                return const Center(child: Text('No data available'));
              } else {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: userDataProvider.userData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        leading: const CircleAvatar(
                          radius: 25,
                          child: Icon(Icons.person),
                        ),
                        title: Text(
                          userDataProvider.userData[index].name!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Email: ${userDataProvider.userData[index].email!}',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Username: ${userDataProvider.userData[index].username!}',
                              style: const TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return Container(
                                height: MediaQuery.of(context).size.height * 0.69,
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'User Details',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    _buildDetailRow(Icons.person, 'Name',
                                        userDataProvider.userData[index].name!),
                                    _buildDetailRow(Icons.account_circle, 'Username',
                                        userDataProvider.userData[index].username!),
                                    _buildDetailRow(Icons.email, 'Email',
                                        userDataProvider.userData[index].email!),
                                    _buildDetailRow(Icons.phone, 'Phone',
                                        userDataProvider.userData[index].phone!),
                                    _buildDetailRow(Icons.language, 'Website',
                                        userDataProvider.userData[index].website!),
                                    _buildDetailRow(Icons.location_on, 'Address',
                                        '${userDataProvider.userData[index].address!.street}, ${userDataProvider.userData[index].address!.suite}, ${userDataProvider.userData[index].address!.city}, ${userDataProvider.userData[index].address!.zipcode}'),
                                    _buildDetailRow(Icons.business, 'Company',
                                        userDataProvider.userData[index].company!.name!),
                                    _buildDetailRow(Icons.work, 'Company Phrase',
                                        userDataProvider.userData[index].company!.catchPhrase!),
                                    _buildDetailRow(Icons.article, 'Company Business',
                                        userDataProvider.userData[index].company!.bs!),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
