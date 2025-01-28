import 'dart:async';

import 'package:core/core.dart';

import '../../models/tv/tv_table.dart';

class DatabaseTv {
  final DatabaseHelper databaseHelper;

  DatabaseTv({required this.databaseHelper});

  Future<int> insertWatchlistTv(TvTable tv) async {
    final db = databaseHelper;
    return await db.insert(tableWatchlistTv, tv.toJson());
  }

  Future<int> removeWatchlistTv(TvTable tv) async {
    final db = databaseHelper;
    return await db.delete(
      tableWatchlistTv,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<List<Map<String, dynamic>?>?> getTvById(int id) async {
    final db = databaseHelper;
    final results = await db.queryGetOne(
      tableWatchlistTv,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results != null && results.isNotEmpty) {
      return results;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTv() async {
    final db = databaseHelper;
    final List<Map<String, dynamic>> results = await db.query(tableWatchlistTv);

    return results;
  }
}
