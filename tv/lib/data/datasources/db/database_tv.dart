import 'dart:async';

import 'package:core/core.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tv/data/models/tv/tv_table.dart';

class DatabaseTv {
  final Future<Database?> database;

  DatabaseTv({required this.database});

  Future<int> insertWatchlistTv(TvTable tv) async {
    final db = await database;
    return await db!.insert(tableWatchlistTv, tv.toJson());
  }

  Future<int> removeWatchlistTv(TvTable tv) async {
    final db = await database;
    return await db!.delete(
      tableWatchlistTv,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await database;
    final results = await db!.query(
      tableWatchlistTv,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTv() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(tableWatchlistTv);

    return results;
  }
}
