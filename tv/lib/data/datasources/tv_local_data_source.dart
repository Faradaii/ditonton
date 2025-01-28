import 'package:core/common/exception.dart';

import '../models/tv/tv_table.dart';
import 'db/database_tv.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlist(TvTable tv);

  Future<String> removeWatchlist(TvTable tv);

  Future<TvTable?> getTvById(int id);

  Future<List<TvTable>> getWatchlistTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseTv databaseTv;

  TvLocalDataSourceImpl({required this.databaseTv});

  @override
  Future<String> insertWatchlist(TvTable tv) async {
    try {
      await databaseTv.insertWatchlistTv(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvTable tv) async {
    try {
      await databaseTv.removeWatchlistTv(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await databaseTv.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result.first!);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTv() async {
    final result = await databaseTv.getWatchlistTv();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }
}
