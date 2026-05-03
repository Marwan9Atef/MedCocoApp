import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcoco/core/di/service_locator.dart';
import 'package:medcoco/core/widget/advance_loading_indicator.dart';
import 'package:medcoco/core/widget/empty_result_indicator.dart';
import 'package:medcoco/core/widget/error_indicator.dart';
import 'package:medcoco/feature/history/presentation/cubit/history_cubit.dart';
import 'package:medcoco/feature/history/presentation/cubit/history_states.dart';
import '../widgets/history_header.dart';
import '../screens/desktop/desktop_history_list.dart';
import '../screens/mobile/mobile_history_list.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<HistoryCubit>()..getHistory(),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 800;

            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: isDesktop ? 12 : 16,
              ),
              child: BlocBuilder<HistoryCubit, HistoryStates>(
                builder: (context, state) {
                  if (state is HistoryLoading) {
                    return const Center(child: AdvanceLoadingIndicator());
                  } else if (state is HistoryFailure) {
                    return ErrorIndicator(
                      onPressed: () {
                        context.read<HistoryCubit>().getHistory();
                      },
                    );
                  } else if (state is HistoryEmpty) {
                    return RefreshIndicator(
                      onRefresh: () {
                        return context.read<HistoryCubit>().getHistory();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const HistoryHeader(numberOfResults: 0),
                          if (!isDesktop) const SizedBox(height: 16),
                          const Expanded(
                            child: EmptyResultIndicator(
                              subMessage:
                                  "No search history has been saved yet.",
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is HistorySuccess) {
                    return RefreshIndicator(
                      onRefresh: () {
                        return context.read<HistoryCubit>().getHistory();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocSelector<HistoryCubit, HistoryStates, int>(
                            selector: (state) {
                              if (state is HistorySuccess) {
                                return state.history.results.length;
                              }
                              return 0;
                            },
                            builder: (context, numberOfResults) {
                              return HistoryHeader(
                                numberOfResults: numberOfResults,
                              );
                            },
                          ),
                          if (!isDesktop) const SizedBox(height: 16),
                          Expanded(
                            child: isDesktop
                                ? DesktopHistoryList(
                                    results: state.history.results,
                                  )
                                : MobileHistoryList(
                                    results: state.history.results,
                                  ),
                          ),
                        ],
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
