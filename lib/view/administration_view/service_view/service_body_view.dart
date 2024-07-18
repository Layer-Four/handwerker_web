import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/data_provider/service_provider/service_vm_provider.dart';
import '../../shared_widgets/add_button_widget.dart';
import '../../shared_widgets/search_line_header.dart';
import '../../shared_widgets/waiting_message_widget.dart';
import 'widgets/create_service_widget.dart';
import 'widgets/service_data_widget.dart';
import 'widgets/service_headlin_widget.dart';

class ServiceBodyView extends ConsumerStatefulWidget {
  const ServiceBodyView({super.key});

  @override
  ConsumerState<ServiceBodyView> createState() => _ServiceBodyViewState();
}

class _ServiceBodyViewState extends ConsumerState<ServiceBodyView> {
  bool _isVisible = false;
  late final ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SearchLineHeader(title: 'Leistungsverwaltung'),
                    const ServiceHeadlineWidget(),
                    ref.watch(serviceVMProvider).isEmpty
                        ? const WaitingMessageWidget('Lade Leistungseintrage')
                        : SizedBox(
                            height: 11 * 60,
                            child: ListView.builder(
                              itemCount: ref.watch(serviceVMProvider).length,
                              itemBuilder: (context, i) => ServiceDataWidget(
                                key: ValueKey(ref.watch(serviceVMProvider)[i]),
                                service: ref.watch(serviceVMProvider)[i],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 50,
            child: AddButton(
              isOpen: _isVisible,
              onTap: () => setState(() => _isVisible = !_isVisible),
              hideAbleChild: CreateServiceWidget(
                onReject: () => setState(() => _isVisible = false),
              ),
            ),
          ),
        ],
      );
}
