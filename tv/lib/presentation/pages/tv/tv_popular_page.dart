import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/tv/tv_popular_notifier.dart';
import '../../widgets/tv_card_list.dart';

class TvPopularPage extends StatefulWidget {
  const TvPopularPage({super.key});

  @override
  State<TvPopularPage> createState() => _TvPopularPageState();
}

class _TvPopularPageState extends State<TvPopularPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvPopularNotifier>(context, listen: false)
            .fetchPopularTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvPopularNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tv[index];
                  return TvCard(tv);
                },
                itemCount: data.tv.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
