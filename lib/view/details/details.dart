import 'package:flutter/material.dart';
import 'package:playflutter/base/base_page_state.dart';
import 'package:playflutter/extensions/page_state_extensions.dart';
import 'package:playflutter/model/entity/details.dart';
import 'package:playflutter/theme/theme_dimens.dart';
import 'package:playflutter/theme/theme_strings.dart';
import 'package:playflutter/view/details/viewmodel/details_viewmodel.dart';
import 'package:playflutter/widget/common/app_popup_menu_divider.dart';
import 'package:share/share.dart';
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
        create: (context) => DetailsViewModel(context),
        viewBuild: (context, viewModel) => WillPopScope(
            onWillPop: viewModel.onBackChange,
            child: Scaffold(
              appBar: AppBar(
                title: Text(widget.detailsData.title),
                actions: [buildActionMenu()],
                leading: BackButton(onPressed: () => {Navigator.pop(context)}),
              ),
              body: buildWebPage(viewModel),
            )));
  }

  /// 构建更多菜单按钮弹窗
  Widget buildActionMenu() {
    return PopupMenuButton(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(ThemeDimens.offset_radius_medium)),
        constraints: const BoxConstraints(maxWidth: 75),
        offset: const Offset(0, ThemeDimens.toolbar_height),
        itemBuilder: (context) => [
              PopupMenuItem(
                  height: 30,
                  onTap: () => {},
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(ThemeStrings.menu_collect),
                  )),
              AppPopupMenuDivider(
                  height: 1, color: Theme.of(context).primaryColorLight),
              PopupMenuItem(
                  height: 30,
                  onTap: () => {
                        Share.share(
                            "${widget.detailsData.title}:${widget.detailsData.link}")
                      },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(ThemeStrings.menu_share),
                  ))
            ]);
  }

  /// 构建webView页面
  Widget buildWebPage(DetailsViewModel viewModel) {
    return Stack(
      children: [
        WebView(
          initialUrl: widget.detailsData.link,
          javascriptMode: JavascriptMode.unrestricted,
          gestureNavigationEnabled: true,
          onProgress: viewModel.onProgress,
          onPageFinished: viewModel.onPageFinished,
          navigationDelegate: (NavigationRequest request) {
            // 处理简书页面,掘金页面 scheme intent跳转原生逻辑
            if (request.url.startsWith("jianshu://")) {
              return NavigationDecision.prevent;
            } else if (request.url.startsWith("bytedance://")) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onWebViewCreated: (controller) {
            viewModel.viewStates.webViewController = controller;
          },
        ),
        Visibility(
            visible: viewModel.viewStates.progressVisible,
            child: LinearProgressIndicator(
              value: (viewModel.viewStates.progress / 100),
            ))
      ],
    );
  }
}
