import 'package:flutter/material.dart';
import './ble_poc_viewmodel.dart';
import 'package:stacked/stacked.dart';

class BlePoc extends StatefulWidget {
  const BlePoc({super.key});

  @override
  State<BlePoc> createState() => _BlePocState();
}

class _BlePocState extends State<BlePoc> {
  BlePocViewModel? viewModelFromBuilder;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BlePocViewModel>.reactive(
      viewModelBuilder: () {
        viewModelFromBuilder = BlePocViewModel();
        print(viewModelFromBuilder?.getDevicesList());
        return viewModelFromBuilder!;
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child: viewModel.getDevicesList().isEmpty
                        ? Text("No devices yet!")
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: viewModel.getDevicesList().length,
                            prototypeItem: ListTile(
                              title: Text(viewModel.getDevicesList().first),
                            ),
                            itemBuilder: (context, index) => ListTile(
                              title: Text(viewModel.getDevicesList()[index]),
                            ),
                          ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: !(viewModel.getIsScanning())
                      ? () => viewModel.startDetectingDevices()
                      : null,
                  child: Text('Start')),
              ElevatedButton(
                  onPressed: (viewModel.getIsScanning())
                      ? () => viewModel.stopDetectingDevices()
                      : null,
                  child: Text('Cancel'))
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    viewModelFromBuilder?.stopDetectingDevices();
    super.dispose();
  }
}
