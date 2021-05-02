import * as redis from 'redis';
import { RedisClient } from "redis";

export class RedisService {
  private client: RedisClient;

  constructor() {
    this.client = redis.createClient(6379, process.env.REDIS_HOST);
  }

  set(key: string, value: string): Promise<string> {
    return new Promise((resolve, reject) => {
      this.client.set(key, value, (err, reply) => {
        if (err) {
          reject(err);
        }
        resolve(reply);
      })
    });
  }

  get(key: string, value: string): Promise<string> {
    return new Promise((resolve, reject) => {
      this.client.get(key, (err, reply) => {
        if (err) {
          reject(err);
        }
        resolve(reply);
      })
    });
  }
}
