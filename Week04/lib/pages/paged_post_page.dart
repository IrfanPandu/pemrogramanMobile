import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/network_errors.dart';
import '../data/paged_posts.dart';
import '../widgets/post_tile.dart';

class PagedPostPage extends ConsumerStatefulWidget {
  const PagedPostPage({super.key});

  @override
  ConsumerState<PagedPostPage> createState() => _PagedPostPageState();
}

class _PagedPostPageState extends ConsumerState<PagedPostPage> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (!_controller.hasClients) return;

      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 200) {
        ref.read(pagedPostsProvider.notifier).loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pagedPostsProvider);

    if (state.error != null && state.items.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Posts Paged'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  friendlyErrorMessage(state.error!),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () =>
                      ref.read(pagedPostsProvider.notifier).loadFirstPage(),
                  child: const Text('Coba lagi'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts Paged'),
        actions: [
          IconButton(
            tooltip: 'Kembali',
            icon: const Icon(Icons.home),
            onPressed: () => context.go('/'),
          ),
        ],
      ),
      body: ListView.builder(
        controller: _controller,
        itemCount: state.items.length + 1,
        itemBuilder: (context, index) {
          if (index == state.items.length) {
            if (!state.hasMore && !state.isLoadingMore) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text('Semua data termuat.'),
                ),
              );
            }

            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final post = state.items[index];

          return PostTile(
            post: post,
            onTap: () => context.go('/post/${post.id}'),
          );
        },
      ),
    );
  }
}
