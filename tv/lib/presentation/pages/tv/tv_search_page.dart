import 'package:core/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tv_search/tv_search_bloc.dart';
import '../../widgets/tv_card_list.dart';

class TvSearchPage extends StatefulWidget {
  const TvSearchPage({super.key});

  @override
  State<TvSearchPage> createState() => _TvSearchPageState();
}

class _TvSearchPageState extends State<TvSearchPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                // Trigger the search
                context.read<TvSearchBloc>().add(OnQueryChangedEvent(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _buildSearchTv(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTv() {
    return BlocBuilder<TvSearchBloc, TvSearchState>(
      builder: (context, state) {
        if (state is TvSearchLoaded) {
          final result = state.tvList;
          if (result.isEmpty) {
            return _buildEmpty();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final tv = result[index];
              return TvCard(tv);
            },
            itemCount: result.length,
          );
        } else if (state is TvSearchError) {
          return Center(
            key: const Key('error_message'),
            child: Text(state.message),
          );
        } else if (state is TvSearchLoading) {
          return const Center(
            key: Key('loading'),
            child: CircularProgressIndicator(),
          );
        } else {
          return _buildInitial();
        }
      },
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Text('No tv series found.'),
    );
  }

  Widget _buildInitial() {
    return const Center(
      child: Text('Try searching tv series!'),
    );
  }
}
