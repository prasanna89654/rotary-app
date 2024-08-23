import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotary/presentation/features/resources_bloc/resources_bloc.dart';

class ResourceDescriptionPage extends StatefulWidget {
  final String id;

  final String name;
  const ResourceDescriptionPage(
      {Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<ResourceDescriptionPage> createState() =>
      _ResourceDescriptionPageState();
}

class _ResourceDescriptionPageState extends State<ResourceDescriptionPage> {
  // ResourcesBloc resourcesBloc = ResourcesBloc(
  //   di(),
  //   di(),
  //   di(),
  // );
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ResourcesBloc>(context)
        .add(GetResourceDescriptionEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: BlocBuilder<ResourcesBloc, ResourcesState>(
        builder: (context, state) {
          if (state is ResourcesLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ResourcesDetailLoadedState) {
            return Column(
              children: [
                CachedNetworkImage(
                  imageUrl: state.resourceDescription?.image ?? "",
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Center(child: Text("Error")),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                              state.resourceDescription?.description ?? ""),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Container(
            child: Center(
              child: Text('Resource error state'),
            ),
          );
        },
      ),
    );
  }
}
