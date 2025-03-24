import 'package:arequipa_bus/pages/feedback/translations/ab_feedback_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:trufi_core/base/utils/packge_info_platform.dart';

class ABFeedbackPage extends StatelessWidget {
  static const String route = "/Feedback";
  final String urlFeedback;
  final Widget Function(BuildContext) drawerBuilder;

  const ABFeedbackPage({
    super.key,
    required this.drawerBuilder,
    required this.urlFeedback,
  });

  @override
  Widget build(BuildContext context) {
    final localizationF = ABFeedbackLocalization.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [Text(localizationF.menuFeedback)]),
      ),
      drawer: drawerBuilder(context),
      body: Scrollbar(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          children: <Widget>[
            Text(
              localizationF.feedbackTitle,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 20,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                localizationF.feedbackContent,
                style: theme.textTheme.bodyMedium,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String version = await PackageInfoPlatform.version();
          final uri = Uri.parse("https://arequipabus.app/form")
              .replace(queryParameters: {"AppVersion": version});
          await launchUrl(uri);
        },
        heroTag: null,
        child: const Icon(Icons.feedback),
      ),
    );
  }
}
