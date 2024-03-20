import { env } from "@/src/env.mjs";
import { type TQueueJobTypes, QueueName } from "shared/src/queues/index";
import { Queue } from "bullmq";
import Redis from "ioredis";

export const isRedisAvailable: boolean =
  env.REDIS_HOST !== undefined &&
  env.REDIS_PORT !== undefined &&
  env.REDIS_AUTH !== undefined;

const redis = isRedisAvailable
  ? new Redis({
      host: String(env.REDIS_HOST),
      port: env.REDIS_PORT ? parseInt(String(env.REDIS_PORT)) : 6379,
      password: String(env.REDIS_AUTH),
    })
  : undefined;

export const evalQueue = redis
  ? new Queue<TQueueJobTypes[QueueName.Evaluation]>(QueueName.Evaluation, {
      connection: redis,
    })
  : undefined;

export default redis;