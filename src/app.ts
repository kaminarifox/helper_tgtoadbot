import { Telegraf } from 'telegraf';
import { HelperInlineQuery } from "./helper-inline/helper-inline-query";
import { HelperScheduler } from "./helper-sheduler/helper-scheduler";
require('dotenv').config()

const bot = new Telegraf(process.env.API_TOKEN)

new HelperInlineQuery(bot);
new HelperScheduler(bot);

bot.launch()

//
// bot.on('message', (ctx) => {
//     console.log(ctx.chat);
//     ctx.reply('test', {reply_markup: {inline_keyboard: [[{text: 'test', callback_data: 'test'}]]} as InlineKeyboardMarkup})
// })



//
// bot.telegram.sendMessage(chatId, 'Пришло время кормежки!', {
//     reply_markup: {
//         one_time_keyboard: true,
//         remove_keyboard: true,
//         keyboard: [[{text: 'Убрать таймер'}, {text: 'Покормить жабу'}]],
//         resize_keyboard: true,
//     }
// });

// Enable graceful stop
process.once('SIGINT', () => bot.stop('SIGINT'))
process.once('SIGTERM', () => bot.stop('SIGTERM'))
