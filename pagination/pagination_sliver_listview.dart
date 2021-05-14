import 'package:coffee_shop/widgets/pagination/pagination_helper.dart';
import 'package:flutter/material.dart';

///only used for vertical ListView
class PaginationSliverListView extends StatefulWidget {
  ///your BLOC must be used this mixin [PaginationHelper]
  final PaginationHelper controller;

  ///build your main item
  final IndexedWidgetBuilder itemBuilder;

  final IndexedWidgetBuilder? separatorBuilder;

  final ScrollController scrollController;

  ///pass into if you don't wanna use the default loading indicator [VueCircularProgressIndicator]
  final WidgetBuilder? loadingIndicatorBuilder;

  ///have to pass into if [showInitialLoadingEffectItem] is true
  final IndexedWidgetBuilder? loadingEffectItemBuilder;

  final int loadingEffectItemCount;

  final double listPaddingStartAndEnd;

  final double offsetBeforeLoadMore;

  PaginationSliverListView(
      {required this.controller,
      required this.itemBuilder,
      this.loadingIndicatorBuilder,
      this.loadingEffectItemBuilder,
      this.loadingEffectItemCount = 10,
      this.listPaddingStartAndEnd = 0,
      required this.scrollController,
      this.offsetBeforeLoadMore = 100,
      this.separatorBuilder});

  @override
  _PaginationSliverListViewState createState() =>
      _PaginationSliverListViewState();
}

class _PaginationSliverListViewState extends State<PaginationSliverListView> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      checkScrollPosition(widget.scrollController.position);
    });
  }

  //to check has the list reach end to load more
  void checkScrollPosition(ScrollMetrics scrollPosition) {
    if (scrollPosition.pixels >=
        scrollPosition.maxScrollExtent - widget.offsetBeforeLoadMore) {
      if (!widget.controller.isLoading && widget.controller.canLoadMore) {
        widget.controller.loadMore();
      }
    }
  }

  Widget buildItem(int index) {
    //loading items
    if (widget.controller.isFirstLoad) {
      return widget.loadingEffectItemBuilder?.call(context, index) ??
          SizedBox();
    }
    //normal item
    if (index < widget.controller.items.length) {
      return widget.itemBuilder.call(context, index);
    }

    //bottom indicator
    if (widget.controller.isLoading) {
      return widget.loadingIndicatorBuilder?.call(context) ??
          widget.loadingEffectItemBuilder?.call(context, index) ??
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CircularProgressIndicator(),
          );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((_, index) {
      return Padding(
        padding: EdgeInsets.only(
            top: (index == 0 ? widget.listPaddingStartAndEnd : 0),
            bottom:
                (index == listLength - 1 ? widget.listPaddingStartAndEnd : 0)),
        child: index != listLength
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildItem(index),
                  widget.separatorBuilder?.call(_, index) ?? SizedBox(),
                ],
              )
            : buildItem(index),
      );
    }, childCount: listLength));
  }

  int get listLength => widget.controller.isFirstLoad
      ? widget.loadingEffectItemCount
      : widget.controller.items.length + 1;
}
