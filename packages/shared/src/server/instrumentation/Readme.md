# Instrumentation at Langfuse

Throughout our applications we want to use as much Otel as possible. This helps us to be flexible choosing our observability backend, and we will benefit from new features built by the Otel community.

## How to use Otel in your application

- Use the `instrumentAsync` or `instrument` functions to wrap your functions with Otel instrumentation. This will automatically create spans for your functions and send them to the Otel collector. If the functions throw, exceptions will be added to the span.
- Use `recordGauge`, `recordCounter`, `recordHistogram` to record metrics. These will be sent to the Otel collector.

## Configuration options

- `web` and `worker` have an instrumentation.ts file, which sets up otel for the application. This file is imported in the main file of the application.
- For trpc, we use `@baselime/trpc-opentelemetry-middleware` to enrich spans with trpc inputs and outputs.

## Library support

- `dd-trace` has a direct dependency of `@opentelemetry/api` version < `1.9` [GH](https://github.com/DataDog/dd-trace-js/blob/ed9b0b30f7b0283579a9bf8c18e1f9deab18fecf/package.json#L81)
- `@prisma/instrumentation` requires at least `@opentelemetry/api` version `1.8` [GH](https://github.com/prisma/prisma/blob/d780290b13754420abcfa5d7592f02049c6cc005/packages/instrumentation/package.json#L25)
- Hence, we need to ensure that all other libraries we use are compatible with `@opentelemetry/api` version `1.8`. If we have a package using a later version, this will break the instrumentation and crash the container.