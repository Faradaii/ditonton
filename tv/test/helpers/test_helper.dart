import 'package:tv/data/datasources/db/database_helper.dart';
import 'package:tv/data/datasources/network/network_helper.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelper,
  NetworkHelper,
], customMocks: [
  MockSpec<IOClient>(as: #MockIOClient)
])
void main() {}
