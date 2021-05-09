import { Context } from "telegraf";
import { Update } from "typegram";

export type HearContext = Context<Update> & {update: any, match: RegExpExecArray};
