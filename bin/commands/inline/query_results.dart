import 'package:teledart/model.dart';

final queryResults = [
  {'id': '1', 'title': 'Брак > Вознаграждение', 'value': 'Брак вознаграждение'},
  {'id': '2', 'title': 'Брак > Проверка', 'value': 'Брак проверка'},
  {'id': '3', 'title': 'Инфо > Жаба', 'value': 'Жаба инфо'},
  {'id': '4', 'title': 'Инфо > Клан', 'value': 'Мой клан'},
  {'id': '5', 'title': 'Инфо > Семья', 'value': 'Моя семья'},
  {'id': '6', 'title': 'Инфо > Топ', 'value': 'Топ жаб'},
  {'id': '7', 'title': 'Инфо > Туса', 'value': 'Туса инфо'},
  {'id': '8', 'title': 'Клан > Вознаграждение', 'value': 'Клан вознаграждение'},
  {
    'id': '9',
    'title': 'Клан > Война > Начать',
    'value': 'Начать клановую войну'
  },
  {'id': '10', 'title': 'Клан > Война > Напасть', 'value': 'Напасть на клан'},
  {'id': '11', 'title': 'Клан > Инфо', 'value': 'Мой клан'},
  {'id': '12', 'title': 'Клан > Сезон', 'value': 'Клан сезон'},
  {
    'id': '13',
    'title': 'Конвертировать > Водоросли',
    'description': '🌿 10 > 🧩 1',
    'value': 'Конвертировать водоросли'
  },
  {
    'id': '14',
    'title': 'Конвертировать > Кувшинки',
    'description': '🧩 10 > 🦴 1',
    'value': 'Конвертировать кувшинки'
  },
  {
    'id': '15',
    'title': 'Крафт > Наголовник > из грязи',
    'description': '🦗 300 > ❤️+5/🛡+2',
    'value': 'Скрафтить наголовник из грязи'
  },
  {
    'id': '16',
    'title': 'Крафт > Наголовник > из водорослей',
    'description': '🌿 3 > ❤️+10/🛡+4',
    'value': 'Скрафтить наголовник из водорослей'
  },
  {
    'id': '17',
    'title': 'Крафт > Наголовник > из кувшинок',
    'description': '🧩 3 > ❤️+15/🛡+6',
    'value': 'Скрафтить наголовник из кувшинок'
  },
  {
    'id': '18',
    'title': 'Крафт > Наголовник > из клюва',
    'description': '🦴 3 > ❤️+20/🛡+8',
    'value': 'Скрафтить наголовник из клюва цапли'
  },
  {
    'id': '19',
    'title': 'Крафт > Нагрудник > из грязи',
    'description': '🦗 300 > ❤️+5/🛡+2',
    'value': 'Скрафтить нагрудник из грязи'
  },
  {
    'id': '20',
    'title': 'Крафт > Нагрудник > из водорослей',
    'description': '🌿 3 > ❤️+10/🛡+4',
    'value': 'Скрафтить нагрудник из водорослей'
  },
  {
    'id': '21',
    'title': 'Крафт > Нагрудник > из кувшинок',
    'description': '🧩 3 > ❤️+15/🛡+6',
    'value': 'Скрафтить нагрудник из кувшинок'
  },
  {
    'id': '22',
    'title': 'Крафт > Нагрудник > из клюва',
    'description': '🦴 3 > ❤️+20/🛡+8',
    'value': 'Скрафтить нагрудник из клюва цапли'
  },
  {
    'id': '23',
    'title': 'Крафт > Налапники > из грязи',
    'description': '🦗 300 > ❤️+5/🛡+2',
    'value': 'Скрафтить налапники из грязи'
  },
  {
    'id': '24',
    'title': 'Крафт > Налапники > из водорослей',
    'description': '🌿 3 > ❤️+10/🛡+4',
    'value': 'Скрафтить налапники из водорослей'
  },
  {
    'id': '25',
    'title': 'Крафт > Налапники > из кувшинок',
    'description': '🧩 3 > ❤️+15/🛡+6',
    'value': 'Скрафтить налапники из кувшинок'
  },
  {
    'id': '26',
    'title': 'Крафт > Налапники > из клюва',
    'description': '🦴 3 > ❤️+20/🛡+8',
    'value': 'Скрафтить налапники из клюва цапли'
  },
  {
    'id': '27',
    'title': 'Крафт > Оружие 🔪 > Камыш',
    'description': '⚙️ 3 > 🗡+5',
    'value': 'Скрафтить камыш'
  },
  {
    'id': '28',
    'title': 'Крафт > Оружие 🔪 > Коряга',
    'description': '⚙️ 5 > 🗡+10',
    'value': 'Скрафтить корягу'
  },
  {
    'id': '29',
    'title': 'Крафт > Оружие 🔪 > Клюв цапли',
    'description': '⚙️ 10 > 🗡+15',
    'value': 'Скрафтить клюв цапли'
  },
  {
    'id': '30',
    'title': 'Крафт > Оружие 🏹 > Комок грязи',
    'description': '⚙️ 2 > 🗡+2',
    'value': 'Скрафтить комок грязи'
  },
  {
    'id': '31',
    'title': 'Крафт > Оружие 🏹 > Букашкомет',
    'description': '⚙️ 4 > 🗡+4',
    'value': 'Скрафтить букашкомет'
  },
  {'id': '32', 'title': 'Мой ID', 'value': 'Мой ID'},
  {'id': '33', 'title': 'МоЙ баланс', 'value': 'Мой баланс'},
  {'id': '34', 'title': 'Моя жаба', 'value': 'Моя жаба'},
  {'id': '35', 'title': 'Мой инвентарь', 'value': 'Мой инвентарь'},
  {'id': '36', 'title': 'Мой клан', 'value': 'Мой клан'},
  {'id': '37', 'title': 'Моя семья', 'value': 'Моя семья'},
  {'id': '38', 'title': 'Мое снаряжение', 'value': 'Мое снаряжение'},
  {
    'id': '39',
    'title': 'Подземелье > 🥉',
    'description': '🦗 400',
    'value': 'Отправиться в бронзовое подземелье'
  },
  {
    'id': '40',
    'title': 'Подземелье > 🥈',
    'description': '🦗 600',
    'value': 'Отправиться в серебряное подземелье'
  },
  {
    'id': '41',
    'title': 'Подземелье > 🥇',
    'description': '🦗 800',
    'value': 'Отправиться в золотое подземелье'
  },
  {'id': '42', 'title': 'Покормить > жабу', 'value': 'Покормить жабу'},
  {'id': '43', 'title': 'Покормить > жабеныша', 'value': 'Покормить жабеныша'},
  {
    'id': '44',
    'title': 'Приобрести > Аптечка',
    'description': '🦗 300',
    'value': 'Приобрести аптечки 1'
  },
  {
    'id': '45',
    'title': 'Приобрести > Леденец',
    'description': '🦗 300',
    'value': 'Приобрести леденцы 1'
  },
  {
    'id': '46',
    'title': 'Приобрести > Пиво',
    'description': '🦗 750',
    'value': 'Приобрести пиво'
  },
  {
    'id': '47',
    'title': 'Приобрести > Стрекозюля',
    'description': '🦗 2000',
    'value': 'Приобрести стрекозюлю'
  },
  {'id': '48', 'title': 'Работа > Столовая', 'value': 'Поход в столовую'},
  {'id': '49', 'title': 'Работа > Крупье', 'value': 'Работа крупье'},
  {'id': '50', 'title': 'Работа > Грабитель', 'value': 'Работа грабитель'},
].map((e) => InlineQueryResultArticle(
    title: e['title'],
    description: e['description'],
    id: e['id'],
    input_message_content:
        (InputTextMessageContent.fromJson({'message_text': e['value']}))));
