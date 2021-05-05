import { Telegraf } from 'telegraf';
import { Services } from "./services/services";
import { Commands } from "./commands/commands";
require('dotenv').config()

async function bootstrap() {
  const bot = new Telegraf(process.env.API_TOKEN)

  Services.init();
  Commands.init(bot);

  return bot.launch()
}
bootstrap().then(() => {
  console.log('Bot is running!');
});
