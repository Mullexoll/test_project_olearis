import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olearis_flutter/bloc/olearis_bloc.dart';
import 'package:olearis_flutter/presentation/widgets/home_screen_widgets/item_list_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  onIncrementClicked(OlearisBloc olearisBloc) {
    olearisBloc.add(OlearisItemAdded());
  }

  onDecrementClicked(OlearisBloc olearisBloc) {
    olearisBloc.add(OlearisItemRemoved());
  }

  @override
  Widget build(BuildContext context) {
    final OlearisBloc olearisBloc = BlocProvider.of<OlearisBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Markup Test'),
        actions: [
          TextButton(
            onPressed: () => onDecrementClicked(olearisBloc),
            child: const Text(
              '-',
              style: TextStyle(fontSize: 18),
            ),
          ),
          TextButton(
            onPressed: () => onIncrementClicked(olearisBloc),
            child: const Text(
              '+',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ItemListBuilder(),
      ),
    );
  }
}
