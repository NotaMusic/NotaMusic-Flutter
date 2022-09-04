// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nota_music/screens/main_page/search_page/search_page_cubit.dart';
import 'package:nota_music/screens/main_page/search_page/search_result_group.dart';
import 'package:nota_music/utils/rx_text_editing_controller.dart';
import 'package:yandex_music_api_flutter/search/search_data.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = RxTextEditingController();
    return Column(
      children: [
        const SizedBox(height: 16),
        SizedBox(
          width: 300,
          child: TextField(
            controller: textController,
          ),
        ),
        const SizedBox(height: 16),
        BlocBuilder<SearchPageCubit, SearchPageState>(
            bloc: SearchPageCubit()..setController(textController),
            builder: (context, state) {
              return state.when(
                  initial: () => const SizedBox.shrink(),
                  loaded: (result) => _buildResults(result),
                  emptyResp: (state) => const Center(
                        child: Text('Nothing found'),
                      ),
                  error: (err) => Center(
                        child: Text(err ?? 'Error when loads result'),
                      ));
            }),
      ],
    );
  }

  Widget _buildResults(SearchData result) {
    final groups = result
        .notNullResults()
        .map(
          (e) => SearchResultGroup(data: e),
        )
        .toList();
    return Expanded(
      child: ListView(
        children: groups,
      ),
    );
  }
}
