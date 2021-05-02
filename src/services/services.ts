import { RedisService } from "./redis.service";

export class Services {
  private static instances: {[p: string]: any} = {}

  static init() {
    Services.register(RedisService, new RedisService());
  }

  static getService<T>(classType: any) {
    if (Object.keys(Services.instances).includes(classType.name)) {
      return Services.instances[classType.name] as T;
    }

    throw new Error(`Service ${classType.name} does not instantiated`);
  }

  private static register(classType: any, instance: any) {
    Services.instances[classType.name] = instance;
  }
}
