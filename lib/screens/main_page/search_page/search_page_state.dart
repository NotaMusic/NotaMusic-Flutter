part of 'search_page_cubit.dart';

@freezed
class SearchPageState with _$SearchPageState {
  const factory SearchPageState.initial() = _InitialState;
  const factory SearchPageState.loaded({required SearchData data}) = _LoadedState;
  const factory SearchPageState.emptyResp({SearchData? data}) = _EmptyState;
  const factory SearchPageState.error({String? error}) = _ErrorState;
}
