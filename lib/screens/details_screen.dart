import 'package:flutter/material.dart';

import '../main.dart';
import '../models/movie.dart';

class DetailsScreen extends StatefulWidget {
  final Movie movie;
  const DetailsScreen({super.key, required this.movie});
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  void toggleWatchlist() {
    setState(() => widget.movie.isWatchlisted = !widget.movie.isWatchlisted);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.movie.isWatchlisted
              ? 'Saved to your watchlist'
              : 'Removed from your watchlist',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FILM NOTES',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            tooltip: movie.isWatchlisted
                ? 'Remove from watchlist'
                : 'Add to watchlist',
            onPressed: toggleWatchlist,
            icon: Icon(
              movie.isWatchlisted ? Icons.bookmark : Icons.bookmark_outline,
              color: MovieWatchlistApp.rust,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PosterFeature(movie: movie),
                  const SizedBox(height: 28),
                  const _SectionLabel(number: '01', label: 'THE STORY'),
                  const SizedBox(height: 12),
                  Text(
                    movie.synopsis,
                    style: const TextStyle(
                      fontFamily: 'sans-serif',
                      fontSize: 17,
                      height: 1.65,
                      color: Color(0xFF4F493F),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(color: Color(0xFFCFC3AF)),
                  const SizedBox(height: 22),
                  const _SectionLabel(number: '02', label: 'FEATURED CAST'),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: movie.cast
                        .asMap()
                        .entries
                        .map(
                          (entry) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFCFC3AF),
                              ),
                              color: const Color(0xFFFFFBF2),
                            ),
                            child: Text(
                              '${entry.key + 1}.  ${entry.value}',
                              style: const TextStyle(
                                fontFamily: 'sans-serif',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 34),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: toggleWatchlist,
                      style: FilledButton.styleFrom(
                        backgroundColor: movie.isWatchlisted
                            ? MovieWatchlistApp.olive
                            : MovieWatchlistApp.ink,
                        foregroundColor: MovieWatchlistApp.paper,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: const RoundedRectangleBorder(),
                      ),
                      icon: Icon(
                        movie.isWatchlisted
                            ? Icons.bookmark_remove_outlined
                            : Icons.bookmark_add_outlined,
                      ),
                      label: Text(
                        movie.isWatchlisted
                            ? 'REMOVE FROM MY LIST'
                            : 'SAVE TO MY LIST',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PosterFeature extends StatelessWidget {
  final Movie movie;
  const _PosterFeature({required this.movie});
  @override
  Widget build(BuildContext context) => Container(
    color: MovieWatchlistApp.ink,
    padding: const EdgeInsets.all(14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 5,
          child: AspectRatio(
            aspectRatio: .69,
            child: Image.asset(movie.posterPath, fit: BoxFit.cover),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 8, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ARCHIVE SELECTION',
                  style: TextStyle(
                    color: MovieWatchlistApp.rust,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  movie.title,
                  style: const TextStyle(
                    color: MovieWatchlistApp.paper,
                    fontSize: 27,
                    height: 1,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'A film for the permanent collection.',
                  style: TextStyle(
                    fontFamily: 'sans-serif',
                    color: Color(0xFFBDB4A5),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _SectionLabel extends StatelessWidget {
  final String number;
  final String label;
  const _SectionLabel({required this.number, required this.label});
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text(
        number,
        style: const TextStyle(
          color: MovieWatchlistApp.rust,
          fontWeight: FontWeight.w900,
        ),
      ),
      const SizedBox(width: 10),
      Text(
        label,
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.4,
        ),
      ),
    ],
  );
}
