import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olearis_flutter/presentation/widgets/home_screen_widgets/image_header.dart';
import 'package:olearis_flutter/presentation/widgets/home_screen_widgets/item_card.dart';

import '../../../bloc/olearis_bloc.dart';

class ItemListBuilder extends StatelessWidget {
  const ItemListBuilder({
    super.key,
  });

  void _consumerListenerHandler(OlearisState state, BuildContext context) {
    if (state is OlearisStateLoaded) {
      if (state.appException != null) {
        final snackBar = SnackBar(
          content: Text(
            state.appException!.message,
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () => BlocProvider.of<OlearisBloc>(context).add(
              OlearisExceptionResset(),
            ),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scrollbar(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                        minHeight: 158,
                      ),
                      child: const Center(
                        child: ImageHeader(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 12,
                    ),
                    child: BlocConsumer<OlearisBloc, OlearisState>(
                      listener: (context, state) =>
                          _consumerListenerHandler(state, context),
                      builder: (context, state) {
                        if (state is OlearisStateLoaded) {
                          return Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: state.listItems
                                .map((item) => ItemCard(
                                      itemTitle: item,
                                    ))
                                .toList(),
                          );
                        }

                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
