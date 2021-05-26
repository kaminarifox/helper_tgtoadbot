import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';

import '../../services/telegram.service.dart';
import 'query_results.dart';

class InlineCommand {
  InlineCommand() {
    final bot = GetIt.I.get<TelegramService>();

    bot.teledart.onInlineQuery().listen((inlineQuery) =>
        inlineQuery.answer(InlineCommand.getResults(inlineQuery.query)));
  }

  static List<InlineQueryResultArticle> getResults(String query) {
    final queryRegExp = RegExp(query, caseSensitive: false, unicode: true);

    return queryResults
        .where((element) => queryRegExp.hasMatch(element.title))
        .toList();
  }
}
