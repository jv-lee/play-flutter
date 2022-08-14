import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/model/entity/details.dart';
import 'package:playflutter/model/http/constants/api_constants.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/details/viewmodel/details_viewmodel.dart';
import 'package:playflutter/widget/common/app_popup_menu_divider.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// @author jv.lee
/// @date 2022/6/28
/// @description 内容详情页
class DetailsPage extends StatefulWidget {
  final DetailsData detailsData;

  const DetailsPage({super.key, required this.detailsData});

  @override
  State<StatefulWidget> createState() => _DetailsState();
}

class _DetailsState extends BasePageState<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return buildViewModel<DetailsViewModel>(
        create: (context) =>
            DetailsViewModel(context, detailsData: widget.detailsData),
        viewBuild: (context, viewModel) => WillPopScope(
            onWillPop: viewModel.onBackChange,
            child: Scaffold(
                appBar: AppBar(
                    title: Text(viewModel.detailsData.title),
                    actions: [buildActionMenu(viewModel)],
                    leading:
                        BackButton(onPressed: () => Navigator.pop(context))),
                body: buildWebPage(viewModel))));
  }

  /// 构建更多菜单按钮弹窗
  Widget buildActionMenu(DetailsViewModel viewModel) {
    return PopupMenuButton(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(ThemeDimens.offsetRadiusMedium)),
        constraints: const BoxConstraints(maxWidth: 75),
        offset: const Offset(0, ThemeDimens.toolbarHeight),
        itemBuilder: (context) => [
              PopupMenuItem(
                  height: 30,
                  onTap: () => viewModel.onCollect(),
                  child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text(ThemeStrings.menuCollect))),
              AppPopupMenuDivider(
                  height: 1, color: Theme.of(context).primaryColorLight),
              PopupMenuItem(
                  height: 30,
                  onTap: () => viewModel.onShare(),
                  child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text(ThemeStrings.menuShare)))
            ]);
  }

  /// 构建webView页面
  Widget buildWebPage(DetailsViewModel viewModel) {
    return Stack(children: [
      WebView(
          initialUrl: viewModel.detailsData.link,
          javascriptMode: JavascriptMode.unrestricted,
          gestureNavigationEnabled: true,
          onProgress: viewModel.onProgress,
          onPageFinished: viewModel.onPageFinished,
          navigationDelegate: (NavigationRequest request) {
            // 处理scheme intent跳转原生逻辑
            for (var scheme in ApiConstants.WEB_SCHEME_LIST) {
              if (request.url.startsWith(scheme)) {
                return NavigationDecision.prevent;
              }
            }
            return NavigationDecision.navigate;
          },
          onWebViewCreated: (controller) =>
              viewModel.viewStates.webViewController = controller),
      Visibility(
          visible: viewModel.viewStates.progressVisible,
          child: LinearProgressIndicator(
              value: (viewModel.viewStates.progress / 100)))
    ]);
  }
}
