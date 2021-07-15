import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';

import '../../common/services/telegram.service.dart';
import 'query_results.dart';

class InlineCommands {
  InlineCommands() {
    final bot = GetIt.I.get<TelegramService>();

    bot.teledart.onInlineQuery().listen((inlineQuery) =>
        inlineQuery.answer(InlineCommands.getResults(inlineQuery.query)));
  }

  static List<InlineQueryResultArticle> getResults(String query) {
    final queryRegExp = RegExp(query, caseSensitive: false, unicode: true);

    return queryResults
        .where((element) => queryRegExp.hasMatch(element.title))
        .toList();
  }
}
