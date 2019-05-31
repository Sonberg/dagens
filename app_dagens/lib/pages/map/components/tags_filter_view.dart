import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:app_dagens/models/tag.dart';
import 'package:app_dagens/queries.dart' as queries;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:app_dagens/store/reducer.dart';
import 'tag_view.dart';

class TagsFilterView extends StatefulWidget {
  @override
  _TagsFilterViewState createState() => _TagsFilterViewState();
}

class _TagsFilterViewState extends State<TagsFilterView> {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: queries.allTags,
        pollInterval: 0,
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.loading || result.errors != null) {
          return Container(
            height: 0,
            width: 0,
          );
        }

        var json = result.data['allTags'] as List<dynamic>;
        var tags = json.map((x) => Tag.fromJson(x)).toList();

        tags.sort((t1, t2) => t2.offers.length.compareTo(t1.offers.length));

        if (tags == null) {
          return Container();
        }

        return StoreConnector<AppStore, List<String>>(
          converter: (store) {
            return store.state.tags;
          },
          builder: (BuildContext bc, List<String> selectedTags) {
            return SizedBox(
              height: 60,
              child: Container(
                padding: EdgeInsets.all(8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tags.length,
                  itemBuilder: (context, index) {
                    var element = tags[index];
                    return TagView(
                      value: element,
                      selected: selectedTags.contains(element.id),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
