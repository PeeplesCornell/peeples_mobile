import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:peeples/models/HistoryModel.dart';
import 'package:peeples/widgets/history_card.dart';

import '../utils/authentication.dart';

class HistoryListViewState extends ConsumerStatefulWidget {
  @override
  _HistoryListViewState createState() => _HistoryListViewState();
}

class _HistoryListViewState extends ConsumerState<HistoryListViewState> {
  static const _pageSize = 20;

  final PagingController<int, HistoryModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await ref
          .read(firebaseProvider.notifier)
          .getHistorys(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      // no item in the list
      _pagingController.appendPage([], 0);
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) => PagedListView<int, HistoryModel>(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<HistoryModel>(
          itemBuilder: (context, item, index) => HistoryCard(history: item),
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    // ref.read(firebaseProvider.notifier).resetLastHistory();
    super.dispose();
  }
}
