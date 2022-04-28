import 'package:bntu_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

class EntryWithHeader extends StatefulWidget {
  final double? height;
  final String? headerText;
  final int? maxLines;
  final Function(String)? onSubmitted;
  final bool isReadOnly;
  final bool? isNullCheckEnabeled;
  final ValueChanged<bool?>? validated;
  final bool? valid;
  final TextEditingController? textController;

  EntryWithHeader({
    this.height,
    this.headerText,
    this.onSubmitted,
    this.isReadOnly = false,
    this.isNullCheckEnabeled = false,
    this.validated,
    this.textController,
    this.valid,
    this.maxLines,
  });

  @override
  _EntryWithHeaderState createState() =>
      _EntryWithHeaderState(textController ?? TextEditingController());
}

class _EntryWithHeaderState extends State<EntryWithHeader>
    with WidgetsBindingObserver {
  _EntryWithHeaderState(this.textController);
  TextEditingController textController;
  FocusNode? _focus;
  Color? textColor = Constants.mainColor;
  bool? isValid;

  @override
  void initState() {
    super.initState();
    isValid = true;
    WidgetsBinding.instance!.addObserver(this);
    _focus = FocusNode();
    // textColor = ColorThemes.coolGrayColor;
    _focus!.addListener(() {
      // if (_focus!.hasFocus) {
      //   setState(() {
      //     textColor = ColorThemes.blue;
      //   });
      //   widget.keyboardOpened?.call();
      // } else {
      //   setState(() {
      //     textColor = ColorThemes.coolGrayColor;
      //   });
      // }
    });

    textController.addListener(() {
      try {
        if (widget.isNullCheckEnabeled!) {
          widget.validated!(isValid);
        }
      } on Exception catch (_) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    if (textController.text.isEmpty && widget.isReadOnly) {
      textController.text = '—';
    }
    if (!widget.isReadOnly && textController.text == '—') {
      textController.text = '';
    }
    return Stack(
      children: [
        Container(
          height: widget.height ?? 43.5,
          //width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
            top: 9.0,
          ),
          child: Stack(
            children: [
              TextField(
                // style: TextStyle(color: Constants.mainColor),
                autofocus: false,
                enabled: !widget.isReadOnly,
                textInputAction: widget.maxLines != null
                    ? TextInputAction.newline
                    : TextInputAction.next,
                controller: textController,
                focusNode: _focus,
                cursorColor: Constants.mainColor,
                onSubmitted: (_) => {widget.onSubmitted},
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.only(left: 10, right: 10, top: 16),
                  disabledBorder: InputBorder.none,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Constants.mainColor,
                      width: 1.3,
                    ),
                  ),
                  enabledBorder: isValidToBorderColor(),
                ),
              ),
            ],
          ),
        ),

        // Header

        Container(
          margin: const EdgeInsets.only(left: 6),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 4,
              right: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  textDirection: TextDirection.ltr,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.headerText ?? '',
                        style: TextStyle(
                          fontFamily: 'RobotoCondensed',
                          fontWeight: FontWeight.w300,
                          color: _focus!.hasFocus
                              ? Constants.mainColor
                              : isValid!
                                  ? textColor
                                  : Colors.red,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

//unfocus entry when keyboard is dismissed (back button pressed)
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final value = WidgetsBinding.instance!.window.viewInsets.bottom;
    if (value == 0) {
      // _focus?.unfocus();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _focus!.dispose();
    //textController.dispose();
    super.dispose();
  }

  OutlineInputBorder isValidToBorderColor() {
    if (widget.isNullCheckEnabeled!) {
      if (textController.text.isEmpty) {
        setState(() {
          isValid = false;
        });
        return const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.3),
        );
      } else {
        setState(() {
          isValid = true;
        });
        return const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.3),
        );
      }
    } else {
      setState(() {
        isValid = true;
      });
      return const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.3),
      );
    }
  }
}
