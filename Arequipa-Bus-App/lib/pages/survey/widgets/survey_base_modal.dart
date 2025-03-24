import 'package:flutter/material.dart';

class SurveyBaseModal extends StatelessWidget {
  const SurveyBaseModal({
    super.key,
    required this.title,
    required this.content,
    this.errorText,
    this.cancelText,
    required this.cancelOnPressed,
    this.expandCancelButton = true,
    this.acceptText,
    required this.acceptOnPressed,
    this.expandAcceptButton = true,
  });
  final String title;
  final Widget content;
  final String? errorText;
  final String? cancelText;
  final VoidCallback cancelOnPressed;
  final bool expandCancelButton;
  final String? acceptText;
  final VoidCallback acceptOnPressed;
  final bool expandAcceptButton;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: isPortrait ? 30 : 60,
            vertical: isPortrait ? 60 : 10,
          ),
          constraints: const BoxConstraints(
            minHeight: 50,
            maxHeight: 800,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: theme.brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black.withOpacity(0.2),
                offset: const Offset(0, 4),
                blurRadius: 20,
              ),
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 4,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Text(
                          title,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: IconButton(
                          tooltip: "close",
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        content,
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Text(
                  errorText != null ? errorText! : "",
                  style: TextStyle(color: theme.colorScheme.error),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: expandCancelButton ? 1 : 0,
                      child: OutlinedButton(
                        onPressed: cancelOnPressed,
                        child: Text(
                          cancelText ?? "Cancel",
                          style: TextStyle(
                            color: theme.colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      flex: expandAcceptButton ? 1 : 0,
                      child: ElevatedButton(
                        onPressed: acceptOnPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.secondary,
                        ),
                        child: Text(
                          acceptText ?? "Accept",
                          style: TextStyle(
                            color: theme.colorScheme.onSecondary,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
