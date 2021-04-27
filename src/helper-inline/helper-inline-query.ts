import { Context, Telegraf} from "telegraf";
import { Update} from "typegram";
import { queryResults } from "./query-results";

export class HelperInlineQuery {
    private bot: Telegraf<Context<Update>>
    constructor(bot: Telegraf) {
        this.bot = bot;
        this.init();
    }

    init() {
        this.bot.on('inline_query', (ctx) => {
            const query = ctx.inlineQuery.query;

            const filtered = queryResults.filter(v => {
                return (new RegExp(query, 'gium').test(v.title));
            })

            ctx.answerInlineQuery(filtered)
        })
    }
}
