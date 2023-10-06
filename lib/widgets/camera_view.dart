import 'package:a_check/utils/abstracts.dart';
import 'package:a_check/widgets/controllers/camera_view_state.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraViewWidget extends StatefulWidget {
  const CameraViewWidget({Key? key, required this.onCapture}) : super(key: key);

  final Function(XFile photoFile) onCapture;

  @override
  State<CameraViewWidget> createState() => CameraViewState();
}

class CameraView extends WidgetView<CameraViewWidget, CameraViewState> {
  const CameraView(state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final deviceRatio = size.width / size.height;

    Widget buildBody() {
      if (!state.camCon!.value.isInitialized) {
        return const Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
            Text("Initializing camera...")
          ]),
        );
      }
      return Center(child: CameraPreview(state.camCon!));
    }

    Widget? buildFab() {
      if (!state.camCon!.value.isInitialized) {
        return null;
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: state.takePicture,
              heroTag: null,
              child: const Icon(Icons.camera),
            ),
            FloatingActionButton(
              onPressed: state.switchCamera,
              heroTag: null,
              child: const Icon(Icons.switch_camera),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: buildBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildFab(),
    );
  }
}
