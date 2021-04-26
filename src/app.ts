require('dotenv').config()

import { Telegraf } from 'telegraf';
import { inlineResults } from "./inline-results";


// Create your bot and tell it about your context type
const bot = new Telegraf(process.env.API_TOKEN)

bot.start((ctx) => ctx.reply('Welcome'))

bot.on('inline_query', (ctx) => {
    const query = ctx.inlineQuery.query;

    const filtered = inlineResults.filter(v => {
        return (new RegExp(query, 'gium').test(v.title));
    })

    ctx.answerInlineQuery(filtered)
})


bot.launch()

// Enable graceful stop
process.once('SIGINT', () => bot.stop('SIGINT'))
process.once('SIGTERM', () => bot.stop('SIGTERM'))
