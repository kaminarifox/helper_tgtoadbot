import { Config } from './config';
import { Bot } from 'grammy';
import { Services } from './services/services';
import { Commands } from './commands/commands';

async function bootstrap() {
  const bot = new Bot(Config.get('apiToken'));

  Services.init();
  Commands.init(bot);

  return bot.start();
}

bootstrap().then(() => {
  console.log('Bot is running!');
});
