# Phase 1: Quickstart

## How to add a new route

1. Define the route constant in `core/navigation/app_route_constant.dart`.
2. Add a `GoRoute` entry in `core/navigation/app_route.dart`.

## How to register a new dependency

1. Open `core/di/di.dart`.
2. Use `sl.registerLazySingleton`, `sl.registerFactory`, or `sl.registerSingleton` depending on the lifecycle needed.
