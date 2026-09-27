import 'package:flutter/material.dart';

import '../data/movies_data.dart';
import '../main.dart';
import '../models/movie.dart';
import 'details_screen.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});
  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  Future<void> openDetails(Movie movie) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailsScreen(movie: movie)),
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final saved = sampleMovies.where((movie) => movie.isWatchlisted).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MY FILM SHELF',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
      ),
      body: saved.isEmpty
          ? const _EmptyWatchlist()
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 40),
              itemCount: saved.length + 1,
              separatorBuilder: (_, _) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${saved.length.toString().padLeft(2, '0')} SAVED FILMS',
                          style: const TextStyle(
                            color: MovieWatchlistApp.rust,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.8,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Your personal\ncinema shelf.',
                          style: TextStyle(
                            fontSize: 34,
                            height: 1,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                final movie = saved[index - 1];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => openDetails(movie),
                    child: SizedBox(
                      height: 128,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 90,
                            child: Image.asset(
                              movie.posterPath,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    movie.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      height: 1.05,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(height: 9),
                                  Text(
                                    movie.cast.take(2).join('  /  '),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontFamily: 'sans-serif',
                                      color: Color(0xFF71695E),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 14),
                            child: Icon(
                              Icons.arrow_forward,
                              color: MovieWatchlistApp.rust,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _EmptyWatchlist extends StatelessWidget {
  const _EmptyWatchlist();
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(34),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 112,
            height: 112,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: MovieWatchlistApp.rust, width: 2),
            ),
            child: const Icon(
              Icons.movie_filter_outlined,
              size: 48,
              color: MovieWatchlistApp.rust,
            ),
          ),
          const SizedBox(height: 26),
          const Text(
            'YOUR SHELF IS EMPTY',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Browse the archive and save the films you want to watch next.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'sans-serif',
              fontSize: 16,
              height: 1.5,
              color: Color(0xFF665F55),
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: MovieWatchlistApp.ink,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              shape: const RoundedRectangleBorder(),
            ),
            icon: const Icon(Icons.arrow_back),
            label: const Text(
              'EXPLORE THE ARCHIVE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}
