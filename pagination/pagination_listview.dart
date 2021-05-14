import 'package:coffee_shop/widgets/pagination/pagination_helper.dart';
import 'package:flutter/material.dart';

///only used for vertical ListView
class PaginationListView extends StatefulWidget {
  ///your BLOC must be used this mixin [PaginationHelper]
  final PaginationHelper controller;
  ///pass into if you want to control another things exclude pagination
  final ScrollController? scrollController;

  ///build your main item
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;

  ///pass into if you don't wanna use the default loading indicator [VueCircularProgressIndicator]
  final WidgetBuilder? loadingIndicatorBuilder;

  ///have to pass into if [showInitialLoadingEffectItem] is true
  final IndexedWidgetBuilder? loadingEffectItemBuilder;

  final int loadingEffectItemCount;

  final double listPaddingStartAndEnd;

  final Axis scrollDirection;

  final double offsetBeforeLoadMore;

  PaginationListView(
      {required this.controller,
      required this.itemBuilder,
      this.separatorBuilder,
      this.scrollController,
      this.loadingIndicatorBuilder,
      this.loadingEffectItemBuilder,
      this.loadingEffectItemCount = 10,
      this.listPaddingStartAndEnd = 0,
      this.scrollDirection = Axis.vertical,
      this.offsetBeforeLoadMore = 100});

  @override
  _PaginationListViewState createState() => _PaginationListViewState();
}

class _PaginationListViewState extends State<PaginationListView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(() {
      checkScrollPosition(_scrollController.position);
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

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
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
    final bool isVertical = widget.scrollDirection == Axis.vertical;
    return RefreshIndicator(
      onRefresh: () async {
        await widget.controller.refresh();
      },
      child: ListView.separated(
          scrollDirection: widget.scrollDirection,
          controller: _scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                top: isVertical
                    ? (index == 0 ? widget.listPaddingStartAndEnd : 0)
                    : 0,
                bottom: isVertical
                    ? (index == listLength - 1
                        ? widget.listPaddingStartAndEnd
                        : 0)
                    : 0,
                left: isVertical
                    ? 0
                    : (index == 0 ? widget.listPaddingStartAndEnd : 0),
                right: isVertical
                    ? 0
                    : (index == listLength - 1
                        ? widget.listPaddingStartAndEnd
                        : 0),
              ),
              child: buildItem(index),
            );
          },
          separatorBuilder: (context, index) =>
          widget.separatorBuilder?.call(context, index) ?? SizedBox(),
          itemCount: listLength),
    );
  }

  int get listLength => widget.controller.isFirstLoad
      ? widget.loadingEffectItemCount
      : widget.controller.items.length + 1;
}
