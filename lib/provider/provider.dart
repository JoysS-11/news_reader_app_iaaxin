import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'news_provider.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => NewsProvider()),
];
