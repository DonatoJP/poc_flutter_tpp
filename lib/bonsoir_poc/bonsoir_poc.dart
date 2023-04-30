import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import './bonsoir_poc_viewmodel.dart';

class BonsoirPoc extends StatefulWidget {
  const BonsoirPoc({super.key});

  @override
  State<BonsoirPoc> createState() => _BonsoirPocState();
}

class _BonsoirPocState extends State<BonsoirPoc> {
  BonsoirPocViewModel? viewModelFromBuilder;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BonsoirPocViewModel>.reactive(
      viewModelBuilder: () {
        viewModelFromBuilder = BonsoirPocViewModel();
        return viewModelFromBuilder!;
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: viewModel.isScanning
                      ? null
                      : !(viewModel.isBroadcasting)
                          ? () => viewModel.startBroadcasting()
                          : () => viewModel.stopBroadcasting(),
                  child: !(viewModel.isBroadcasting)
                      ? Text('Broadcast')
                      : Text('Stop Broadcast')),
              ElevatedButton(
                  onPressed: viewModel.isBroadcasting
                      ? null
                      : !(viewModel.isScanning)
                          ? () => viewModel.startScanning()
                          : () => viewModel.stopScanning(),
                  child: !(viewModel.isScanning)
                      ? Text('Scanning')
                      : Text('Stop Scanning')),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child: viewModel.getMessages().isEmpty
                        ? Text("Doing nothing")
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: viewModel.getMessages().length,
                            prototypeItem: ListTile(
                              title: Text(viewModel.getMessages().first),
                            ),
                            itemBuilder: (context, index) => ListTile(
                              title: Text(viewModel.getMessages()[index]),
                            ),
                          ),
                  ),
                ),
              ),
              for (int i = 0; i < viewModel.services.length; i++)
                ElevatedButton(
                    onPressed: () => viewModel.sendMessageTo(i),
                    child: Text('Send to ${viewModel.services[i].name}'))
            ],
          ),
        );
      },
    );
  }
}
