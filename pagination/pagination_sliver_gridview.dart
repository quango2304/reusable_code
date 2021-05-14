import 'package:coffee_shop/widgets/pagination/pagination_helper.dart';
import 'package:flutter/material.dart';

///only used for vertical ListView
class PaginationSliverGridView extends StatefulWidget {
  ///your BLOC must be used this mixin [PaginationHelper]
  final PaginationHelper controller;
  ///pass into if you want to control another things exclude pagination
  final ScrollController scrollController;

  ///build your main item
  final IndexedWidgetBuilder itemBuilder;

  ///pass into if you don't wanna use the default loading indicator [VueCircularProgressIndicator]
  final WidgetBuilder? loadingIndicatorBuilder;

  ///have to pass into if [showInitialLoadingEffectItem] is true
  final IndexedWidgetBuilder? loadingEffectItemBuilder;

  final int loadingEffectItemCount;

  final double listPaddingStartAndEnd;

  final int crossAxisCount;

  final double mainAxisSpacing;

  final double crossAxisSpacing;

  final double childAspectRatio;

  final double offsetBeforeLoadMore;

  PaginationSliverGridView(
      {required this.controller,
      required this.itemBuilder,
      required this.scrollController,
      this.loadingIndicatorBuilder,
      this.loadingEffectItemBuilder,
      this.loadingEffectItemCount = 20,
      this.listPaddingStartAndEnd = 0,
      this.crossAxisCount = 2,
      this.mainAxisSpacing = 0,
      this.crossAxisSpacing = 0,
      this.childAspectRatio = 1,
      this.offsetBeforeLoadMore = 100})
      : assert(controller.limit % crossAxisCount == 0);

  // this assert make sure the load more and loading effect work well

  @override
  _PaginationSliverGridViewState createState() =>
      _PaginationSliverGridViewState();
}

class _PaginationSliverGridViewState extends State<PaginationSliverGridView> {
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
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          childAspectRatio: widget.childAspectRatio,
          crossAxisSpacing: widget.crossAxisSpacing,
          mainAxisSpacing: widget.mainAxisSpacing),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.only(
                  top: index <= (widget.crossAxisCount - 1)
                      ? widget.listPaddingStartAndEnd
                      : 0,
                  bottom: index >= widget.controller.items.length
                      ? widget.listPaddingStartAndEnd
                      : 0),
              child: buildItem(index));
        },
        childCount: listLength,
      ),
    );
  }

  int get listLength => widget.controller.isFirstLoad
      ? widget.loadingEffectItemCount
      : widget.controller.items.length + widget.crossAxisCount;
}
