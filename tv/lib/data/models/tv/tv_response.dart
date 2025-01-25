import 'package:tv/data/models/tv/tv_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesResponse extends Equatable {
  final List<TvSeriesModel> tvList;

  const TvSeriesResponse({
    required this.tvList,
  });

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesResponse(
          tvList: List<TvSeriesModel>.from((json["results"] as List)
              .map((tv) => TvSeriesModel.fromJson(tv))
              .where((element) => element.posterPath != null)));

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['results'] = tvList.map((tv) => tv.toJson()).toList();
    return data;
  }

  @override
  List<Object?> get props => [tvList];
}
