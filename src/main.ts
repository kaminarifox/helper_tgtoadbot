import { Telegraf } from 'telegraf';
import { Services } from "./services/services";
import { BotModules } from "./modules/bot-modules";
require('dotenv').config()

async function bootstrap() {
  const bot = new Telegraf(process.env.API_TOKEN)

  Services.init();
  BotModules.init(bot);

  return bot.launch()
}
bootstrap().then(() => {
  console.log('Bot is running!');
});
