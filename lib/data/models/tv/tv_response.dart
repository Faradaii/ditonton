import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:equatable/equatable.dart';

class TvResponse extends Equatable{
  final List<TvSeriesModel> tvList;

  TvResponse({
    required this.tvList,
  });

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
    tvList: List<TvSeriesModel>.from((json["results"] as List)
    .map((tv) => TvSeriesModel.fromJson(tv))
    .where((element) => element.posterPath != null))
  );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['results'] = tvList.map((tv)=>tv.toJson()).toList();
    return _data;
  }

  @override
  List<Object?> get props => [tvList];
}

