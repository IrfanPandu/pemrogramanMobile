import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 3 - Navigation'),
        actions: [
          IconButton(
            tooltip: 'ToDo',
            onPressed: () => context.go('/todo'),
            icon: const Icon(Icons.checklist),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          final id = index + 1;

          return ListTile(
            leading: CircleAvatar(child: Text('$id')),
            title: Text('Item $id'),
            subtitle: const Text('Buka halaman detail'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/detail/$id'),
          );
        },
      ),
    );
  }
}
