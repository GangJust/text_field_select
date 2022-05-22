import 'package:flutter/material.dart';

import 'kit_card.dart';

typedef TextFieldSelectCallBack = void Function(TextEditingController controller, int index);

typedef TextFieldSelectRefresh = List<int> Function(String text);

class TextFieldSelect extends StatefulWidget {
  const TextFieldSelect({
    Key? key,
    this.controller,
    this.boxDecoration,
    this.inputDecoration,
    this.textAlignVertical = const TextAlignVertical(y: 0.1),
    this.scrollPhysics = const BouncingScrollPhysics(),
    this.readOnly = false,
    this.disableSelect = false,
    this.style,
    this.emptyWidget,
    required this.itemCount,
    required this.itemBuilder,
    this.onSelected,
    this.selectedClosed = true,
    this.onShowing,
    this.onBackClosed = false,
  })  : assert(itemCount > 0),
        super(key: key);

  final TextEditingController? controller;

  ///
  final BoxDecoration? boxDecoration;

  ///
  final InputDecoration? inputDecoration;

  ///
  final TextAlignVertical? textAlignVertical;

  ///
  final ScrollPhysics? scrollPhysics;

  ///
  final bool readOnly;

  /// 禁用悬浮, 当[true]时。
  final bool disableSelect;

  /// 文本样式，只对 [TextField] 生效
  final TextStyle? style;

  /// 空列表占位组件
  final Widget? emptyWidget;

  /// 构建数量
  final int itemCount;

  /// 通过该方法构建悬浮列表框
  final IndexedWidgetBuilder itemBuilder;

  /// 选择列表项回调
  final TextFieldSelectCallBack? onSelected;

  /// 选择列表项后是否关闭悬浮，如果为[true]则关闭，否则不做处理。
  final bool selectedClosed;

  /// 显示指定下标, 该方法通过响应[onChange]方法, 会对选项列表进行重构,
  /// 返回一个[List<int>]对应的是 itemBuilder 中的下标,
  /// [List<int>]的默认长度决定于[itemCount],
  /// [List<int>]的最大长度决定于[itemCount],
  final TextFieldSelectRefresh? onShowing;

  /// 当按下返回键时, 是否首先关闭悬浮, 如果为[true]则关闭悬浮, 消耗返回事件, 如果为[false]则返回的同时关闭悬浮。
  final bool onBackClosed;

  @override
  State<TextFieldSelect> createState() => _TextFieldSelectState();
}

class _TextFieldSelectState extends State<TextFieldSelect> with SingleTickerProviderStateMixin {
  late TextEditingController _controller;
  late AnimationController _animationController;
  late List<int> _onShowingIndexes;

  final FocusNode _focusNode = FocusNode();
  final LayerLink _selectViewLayerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  // 监听编辑框点击
  void _onTap() {
    if (_overlayEntry != null) {
      _overlayEntry?.markNeedsBuild();
      return;
    }
    _showSelectView();
  }

  // 监听编辑框内容的改变
  void _onChanged(String text) {
    if (widget.onShowing != null) {
      _onShowingIndexes = widget.onShowing!(text);
    }
    if (_overlayEntry != null) {
      _overlayEntry?.markNeedsBuild();
      return;
    }
    _showSelectView();
  }

  // 监听下拉列表项点击
  void _onSelected(int index) async {
    if (widget.onSelected != null) {
      if (widget.selectedClosed) await _dismissSelectView();
      widget.onSelected?.call(_controller, index);
    }
  }

  // 空列表占位组件
  Widget get _getEmptyWidget {
    return widget.emptyWidget ??
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: const Text("没有找到该标签"),
        );
  }

  // 构建下拉悬浮
  void _buildSelectView() {
    final RenderBox renderBox = context.findRenderObject()! as RenderBox; // 取到当前对象

    _overlayEntry = OverlayEntry(
      opaque: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            CompositedTransformFollower(
              link: _selectViewLayerLink,
              showWhenUnlinked: false,
              offset: Offset(0, renderBox.size.height), // 悬浮在当前对象的正下方
              child: FadeTransition(
                opacity: _animationController.view,
                child: KitCard(
                  elevation: 8.0,
                  shadowColor: Colors.black38,
                  width: renderBox.size.width, // 宽度为当前对象的宽度
                  constraints: const BoxConstraints(maxHeight: 150.0),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    removeLeft: true,
                    removeRight: true,
                    removeBottom: true,
                    child: _onShowingIndexes.isEmpty
                        ? _getEmptyWidget
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: widget.itemCount,
                            itemBuilder: (context, index) {
                              if (_onShowingIndexes.contains(index)) {
                                return GestureDetector(
                                  onTap: () => _onSelected(index),
                                  child: widget.itemBuilder(context, index),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    _overlayEntry?.addListener(_overlayEntryListener);
  }

  // 显示下拉框
  void _showSelectView() async {
    if (widget.disableSelect) return; // 如果悬浮被禁用, 则不显示

    await _dismissSelectView(); // 清空之前
    _buildSelectView();
    Overlay.of(context, rootOverlay: true)?.insert(_overlayEntry!);
    _animationController.forward();
  }

  // 关闭下拉框
  Future _dismissSelectView() async {
    if (_overlayEntry != null) {
      await _animationController.reverse();
      _overlayEntry?.remove();
      _overlayEntry?.removeListener(_overlayEntryListener);
      _overlayEntry = null;
    }
  }

  // 悬浮监听
  void _overlayEntryListener() {

  }

  // 焦点监听
  void _focusNodeListener() {
    // 失去焦点, 关闭悬浮
    if (!_focusNode.hasFocus) _dismissSelectView();
  }

  // 返回事件监听
  Future<bool> _onWillPop() async {
    if (widget.onBackClosed) {
      var res = _overlayEntry != null ? false : true;
      _dismissSelectView();
      return res;
    }
    _dismissSelectView();
    return true;
  }

  BoxDecoration get _getDecoration {
    if (widget.boxDecoration != null) return widget.boxDecoration!;
    return BoxDecoration(
      color: Colors.grey[50],
      borderRadius: BorderRadius.circular(4.0),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _animationController = AnimationController(duration: SelectionOverlay.fadeDuration, vsync: this);
    _focusNode.addListener(_focusNodeListener);
    _onShowingIndexes = List.generate(widget.itemCount, (index) => index);
  }

  @override
  void dispose() {
    _dismissSelectView();
    _focusNode.removeListener(_focusNodeListener);
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: CompositedTransformTarget(
        link: _selectViewLayerLink,
        child: Container(
          decoration: _getDecoration,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            onTap: _onTap,
            onChanged: _onChanged,
            readOnly: widget.readOnly,
            style: (widget.style ?? Theme.of(context).textTheme.bodyMedium)
                ?.copyWith(color: widget.readOnly ? Theme.of(context).disabledColor : null),
            scrollPhysics: widget.scrollPhysics,
            textAlignVertical: widget.textAlignVertical,
            decoration: widget.inputDecoration,
          ),
        ),
      ),
    );
  }
}
