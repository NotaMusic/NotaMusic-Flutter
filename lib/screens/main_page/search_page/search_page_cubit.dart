import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nota_music/utils/rx_text_editing_controller.dart';
import 'package:yandex_music_api_flutter/search/search_data.dart';
import 'package:yandex_music_api_flutter/search/search_req_arg.dart';
import 'package:yandex_music_api_flutter/yandex_music_api_flutter.dart';
import 'package:rxdart/rxdart.dart';

part 'search_page_state.dart';
part 'search_page_cubit.freezed.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit() : super(const SearchPageState.initial());

  Future<void> doSearch(String str) async {
    try {
      final resp = await Client.instance.search(SearchReqArg(text: str));
      if (resp == null) {
        emit(SearchPageState.emptyResp(data: resp));
        return;
      }
      emit(SearchPageState.loaded(data: resp));
    } catch (ex, trace) {
      if (kDebugMode) {
        print(ex);
        print(trace);
      }
      emit(SearchPageState.error(error: ex.toString()));
    }
  }

  void setController(RxTextEditingController textController) =>
      textController.getUpdates().debounceTime(const Duration(seconds: 1))
        ..listen((e) {
          if (e.isNotEmpty) {
            doSearch(e);
          }
        });
}
