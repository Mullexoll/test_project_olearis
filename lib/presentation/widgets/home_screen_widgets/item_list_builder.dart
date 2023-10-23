import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olearis_flutter/presentation/widgets/home_screen_widgets/image_header.dart';
import 'package:olearis_flutter/presentation/widgets/home_screen_widgets/item_card.dart';

import '../../../bloc/olearis_bloc.dart';

class ItemListBuilder extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  ItemListBuilder({
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
        controller: _scrollController,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: true,
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
            BlocConsumer<OlearisBloc, OlearisState>(
              listener: (context, state) =>
                  _consumerListenerHandler(state, context),
              builder: (context, state) {
                if (state is OlearisStateLoaded) {
                  return SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                    itemCount: state.listItems.length,
                    itemBuilder: ((context, index) {
                      return ItemCard(
                        itemTitle: state.listItems[index],
                      );
                    }),
                  );
                }

                return const SliverToBoxAdapter(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
