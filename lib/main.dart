import 'package:flutter/material.dart';
import 'package:flutter_temp/providers/global_providers.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends ConsumerStatefulWidget {
  const MyHome({super.key});


  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomeState();
}

class _MyHomeState extends ConsumerState<MyHome> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text = ref.watch(generateQrProvider).currentData;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(
          Icons.qr_code_rounded,
        ),
        onPressed: () {
          ref.read(generateQrProvider).generateQr(
                controller.text,
              );
        },
        label: const Text(
          "Generate QR",
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ref.watch(generateQrProvider).isQrInit
                      ? QrImageView(
                          errorStateBuilder: (cxt, err) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  border: Border.all(color: Colors.black)),
                              child:const  Center(
                                child: Text(
                                  "Looks like your input is too long!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            );
                          },
                          data: ref.watch(generateQrProvider).currentData,
                          size: constraints.maxHeight * 0.5,
                          version: QrVersions.auto,
                        )
                      : const ColoredBox(
                          color: Colors.grey,
                          child: SizedBox(
                            height: 200,
                            width: 200,
                            child: Center(
                              child: Text(
                                "QR Code",
                              ),
                            ),
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 1,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: "Type  ",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
