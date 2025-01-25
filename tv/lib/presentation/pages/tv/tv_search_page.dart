import 'package:core/common/constants.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/tv/tv_search_notifier.dart';
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
              onSubmitted: (query) {
                // Trigger the search
                Provider.of<TvSearchNotifier>(context, listen: false)
                    .fetchTvSearch(query);
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
    return Consumer<TvSearchNotifier>(
      builder: (context, data, child) {
        if (data.state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.state == RequestState.loaded) {
          final result = data.searchResult;
          if (result.isEmpty) return _buildEmpty();
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final tv = data.searchResult[index];
              return TvCard(tv);
            },
            itemCount: result.length,
          );
        } else {
          return _buildEmpty();
        }
      },
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Text('No tv series found.'),
    );
  }
}
