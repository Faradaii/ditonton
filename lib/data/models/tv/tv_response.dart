import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesResponse extends Equatable {
  final List<TvSeriesModel> tvList;

  TvSeriesResponse({
    required this.tvList,
  });

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesResponse(
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

