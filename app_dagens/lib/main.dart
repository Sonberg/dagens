import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:app_dagens/store/reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'pages/map/page.dart';

void main() {
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final store =
      new Store<AppStore>(geoLocationReducer, initialState: AppStore());

  runApp(new MyApp(
    store: store,
  ));
}

@immutable
class MyApp extends StatelessWidget {
  final Store<AppStore> store;

  MyApp({Key key, this.store}) : super(key: key);

  ValueNotifier<GraphQLClient> valueNotifierClient =
      ValueNotifier(GraphQLClient(
    link: HttpLink(
            uri: 'https://api.graph.cool/simple/v1/cj65a1d7g03k60187mbo74qel')
        as Link,
    cache: InMemoryCache(),
  ));

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: GraphQLProvider(
        client: valueNotifierClient,
        child: CacheProvider(
          child: MaterialApp(
            theme: ThemeData(fontFamily: 'Calibre-Semibold'),
            home: MapPage(
              store: store,
            ),
          ),
        ),
      ),
    );
  }
}
// OpenSans
