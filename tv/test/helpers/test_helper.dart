import 'package:core/helper/database_helper.dart';
import 'package:core/helper/network_helper.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:tv/data/datasources/db/database_tv.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseTv,
  NetworkHelper,
  DatabaseHelper,
], customMocks: [
  MockSpec<IOClient>(as: #MockIOClient)
])
void main() {}
