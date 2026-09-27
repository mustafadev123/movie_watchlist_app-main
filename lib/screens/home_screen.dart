import 'package:flutter/material.dart';

import '../data/movies_data.dart';
import '../main.dart';
import 'details_screen.dart';
import 'watchlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> openDetails(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailsScreen(movie: sampleMovies[index]),
      ),
    );
    if (mounted) setState(() {});
  }

  Future<void> openWatchlist() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const WatchlistScreen()),
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final count = sampleMovies.where((movie) => movie.isWatchlisted).length;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        titleSpacing: 20,
        title: const Row(
          children: [
            Icon(Icons.local_movies_outlined, color: MovieWatchlistApp.rust),
            SizedBox(width: 10),
            Text(
              'REEL ARCHIVE',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.2,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Badge(
              label: Text('$count'),
              isLabelVisible: count > 0,
              backgroundColor: MovieWatchlistApp.rust,
              child: IconButton(
                onPressed: openWatchlist,
                tooltip: 'View watchlist',
                icon: const Icon(Icons.bookmark_outline),
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _Masthead(movieCount: sampleMovies.length)),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 110),
            sliver: SliverLayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.crossAxisExtent >= 850
                    ? 3
                    : constraints.crossAxisExtent >= 560
                    ? 2
                    : 1;
                return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: columns == 1 ? 1.62 : .72,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _MovieCard(
                      index: index,
                      onTap: () => openDetails(index),
                    ),
                    childCount: sampleMovies.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: openWatchlist,
        backgroundColor: MovieWatchlistApp.ink,
        foregroundColor: MovieWatchlistApp.paper,
        icon: const Icon(Icons.bookmarks_outlined),
        label: const Text(
          'MY LIST',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
    );
  }
}

class _Masthead extends StatelessWidget {
  final int movieCount;
  const _Masthead({required this.movieCount});
  @override
  Widget build(BuildContext context) => Container(
    color: MovieWatchlistApp.ink,
    padding: const EdgeInsets.fromLTRB(20, 34, 20, 32),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CURATED / VOL. 01',
                style: TextStyle(
                  color: Color(0xFFC8BFAE),
                  fontSize: 12,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Stories worth\nwatching.',
                style: TextStyle(
                  color: MovieWatchlistApp.paper,
                  fontSize: 38,
                  height: .98,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        Text(
          '$movieCount FILMS',
          style: const TextStyle(
            color: MovieWatchlistApp.rust,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ],
    ),
  );
}

class _MovieCard extends StatelessWidget {
  final int index;
  final VoidCallback onTap;
  const _MovieCard({required this.index, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final movie = sampleMovies[index];
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(movie.posterPath, fit: BoxFit.cover),
                  Positioned(
                    left: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      color: MovieWatchlistApp.paper,
                      child: Text(
                        '${index + 1}'.padLeft(2, '0'),
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      movie.title.toUpperCase(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        height: 1.05,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 32,
                      height: 3,
                      color: MovieWatchlistApp.rust,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      movie.synopsis,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'sans-serif',
                        fontSize: 12.5,
                        height: 1.4,
                        color: Color(0xFF625B50),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          movie.isWatchlisted
                              ? Icons.bookmark
                              : Icons.arrow_forward,
                          size: 17,
                          color: MovieWatchlistApp.rust,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          movie.isWatchlisted ? 'SAVED' : 'VIEW FILM',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
