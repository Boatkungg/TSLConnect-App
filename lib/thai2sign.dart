import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class Thai2Sign extends StatefulWidget {
  const Thai2Sign({super.key});

  @override
  State<Thai2Sign> createState() => _Thai2SignState();
}

class _Thai2SignState extends State<Thai2Sign> {
  final TextEditingController textController = TextEditingController();
  bool haveText = false;
  bool isProcessing = false;

  void translate() async {
    final translation = await getTranslation(textController.text);
    if (mounted) {
      context.go("/thai2sign/result/$translation");
    }
  }

  Future<String> getTranslation(String text) async {
    setState(() {
      isProcessing = true;
    });
    const translation = "asasdasdasd";
    // sleep
    await Future.delayed(const Duration(seconds: 2));
    //final translation = await uploadVideo(videoPath);
    setState(() {
      isProcessing = false;
    });
    print(translation);
    return translation;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        body: Container(
            padding: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
            ),
            child: Column(children: [
              SingleChildScrollView(
                  child: TextField(
                controller: textController,
                onChanged: (value) {
                  setState(() {
                    haveText = value.isNotEmpty;
                  });
                },
                maxLines: 7,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                    hintText: "พิมพ์ข้อความ", border: InputBorder.none),
                style: const TextStyle(
                  fontSize: 22,
                ),
              )),
              haveText
                  ? Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: const Divider(
                              thickness: 2,
                            ),
                          ),
                        ),
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: theme.colorScheme.primary),
                          child: !isProcessing
                              ? IconButton(
                                  onPressed: translate,
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    color: theme.colorScheme.onPrimary,
                                  ))
                              : const CircularProgressIndicator(),
                        ),
                      ],
                    )
                  : const SizedBox()
            ])));
  }
}
