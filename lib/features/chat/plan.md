# Chat Feature Refactor — Implementation Plan

## Overview

Refactor the existing chat feature from scratch following Clean Architecture, using the new Supabase schema. All old commented-out code (`chat_remote_datasource.dart`, `chat_repository_impl.dart`, cubits, pages, DI, routes) will be rewritten. Existing entities, models, states, and widgets will be adapted to the new schema.

---

## Database (Supabase)

**Status:** ✅ Complete — schema is deployed.

7 tables + 1 preview table + 3 enum types + 5 triggers.

| Table | Purpose | Key Columns |
|-------|---------|-------------|
| `chat_users` | User profiles for chat | `user_id` (INT PK), `username` |
| `chat_rooms` | Room metadata | `room_id` (UUID PK), `team_id` (INT UNIQUE), `team_name` |
| `chat_room_members` | Membership + role + unread | `room_id`, `user_id` (composite PK), `role`, `unread_count` |
| `messages` | Message content | `message_id` (UUID PK), `room_id`, `sender_id`, `content`, `is_edited`, `is_deleted` |
| `message_status` | Per-user delivery tracking | `message_id`, `user_id` (composite PK), `status` (sent/delivered/read) |
| `chat_room_previews` | Cached last message (trigger-maintained) | `room_id` (PK), `last_message`, `last_message_at` |
| `join_requests` | Join request management | `request_id` (UUID PK), `room_id`, `user_id`, `status` |
| `invitations` | Invitation management | `invitation_id` (UUID PK), `room_id`, `inviter_id`, `invitee_id`, `status` |

**Key constraints:**
- `idx_one_leader_per_room` — partial unique index enforcing exactly one leader per room
- `ON DELETE CASCADE` — room deletion cascades to messages, members, requests, invitations
- `ON DELETE SET NULL` on `messages.sender_id` — preserves messages when user is deleted

**Triggers (automatic):**
- `trg_messages_update_preview` — updates `chat_room_previews` on every new message
- `trg_messages_increment_unread` — increments `unread_count` for other members on new message
- `trg_messages_insert_status` — inserts `sent` status for all members on new message
- `update_timestamp` — auto-updates `updated_at` on all tables

---

## Architecture (Clean Architecture)

```
lib/features/chat/
├── domain/
│   ├── entities/       (Entity classes)
│   ├── repositories/   (Abstract repository interface)
│   └── usecases/       (25 use case classes)
├── data/
│   ├── datasources/    (Supabase remote data source)
│   ├── models/         (DTO model classes extending entities)
│   └── repositories/   (Repository implementation)
├── presentation/
│   ├── bloc/           (Cubits + States)
│   ├── pages/          (Full screen UIs)
│   └── widgets/        (Reusable UI components)
└── di/                 (GetIt dependency injection)
```

---

## Implementation Steps (in order)

### Step 1: Domain Entities — Modify existing + Create new

| File | Action |
|------|--------|
| `chat_room_entity.dart` | Add `roomId`, `leaderId` fields; remove `lastMessageSenderName` (resolved via JOIN) |
| `message_entity.dart` | Add `isEdited`, `isDeleted`, `senderName`, `messageDeliveryStatus`; remove redundant fields |
| `chat_user_entity.dart` | **New** — `userId`, `username`, `email`, `avatarUrl` |
| `join_request_entity.dart` | **New** — `requestId`, `roomId`, `userId`, `username`, `status`, `createdAt` |
| `invitation_entity.dart` | **New** — `invitationId`, `roomId`, `inviterId`, `inviteeId`, `status`, `teamName`, `createdAt` |
| `message_status_entity.dart` | **New** — `messageId`, `userId`, `status`, `updatedAt` |

### Step 2: Data Models — Modify existing + Create new

| File | Action |
|------|--------|
| `chat_room_model.dart` | Rewrite `fromJson`/`toJson` for new query structure (handles JOIN from `chat_rooms` + `chat_room_members` + `chat_room_previews` + `chat_users`) |
| `message_model.dart` | Rewrite `fromJson`/`toJson` for `messages` JOIN `chat_users` JOIN `message_status` |
| New model files | One per new entity above |

### Step 3: Data Source — Full rewrite

| File | Action |
|------|--------|
| `chat_remote_datasource.dart` | Rewrite entire file: abstract + implementation with all 25+ Supabase methods |

**Key query patterns:**

- **Chat list:** `chat_room_members` → JOIN `chat_rooms` → LEFT JOIN `chat_room_previews` → LEFT JOIN `chat_users` on `last_message_sender_id`
- **Messages:** `messages` → JOIN `chat_users` → LEFT JOIN `message_status`
- **Search:** `chat_room_members` → JOIN `chat_rooms` with `ILIKE team_name`
- **Pagination:** Cursor-based on `messages.created_at DESC`
- **Realtime channels:** 3 channels — chat list (debounced 300ms), messages (per room), message status (per user)

### Step 4: Repository Interface — Rewrite

| File | Action |
|------|--------|
| `chat_repository.dart` | Rewrite abstract interface with all methods matching data source |

### Step 5: Repository Implementation — Full rewrite

| File | Action |
|------|--------|
| `chat_repository_impl.dart` | Rewrite — delegates to data source, wraps in `Either<Failure, T>`, handles exceptions |

### Step 6: Use Cases — Modify existing + Create new

**Existing (rewrite):** `create_team_chat_room`, `get_chat_rooms`, `search_chat_rooms`, `subscribe_to_chat_rooms`, `reset_unread_count`, `get_messages`, `send_message`, `watch_messages`

**Remove:** `reconcile_membership` (no longer needed — new schema handles consistency via FKs)

**New (17 use cases):**

| Use Case | Method |
|----------|--------|
| `change_leader` | `call(ChangeLeaderParams(roomId, newLeaderId))` |
| `delete_chat_room` | `call(DeleteChatRoomParams(roomId))` |
| `send_join_request` | `call(SendJoinRequestParams(roomId, userId))` |
| `send_invitation` | `call(SendInvitationParams(roomId, inviterId, inviteeId))` |
| `accept_join_request` | `call(AcceptJoinRequestParams(requestId))` |
| `accept_invitation` | `call(AcceptInvitationParams(invitationId))` |
| `reject_join_request` | `call(RejectJoinRequestParams(requestId))` |
| `reject_invitation` | `call(RejectInvitationParams(invitationId))` |
| `save_user_chat_data` | `call(SaveUserChatDataParams(user))` |
| `get_user_chat_data` | `call(GetUserChatDataParams(userId))` |
| `delete_user_chat_data` | `call(DeleteUserChatDataParams(userId))` |
| `update_username` | `call(UpdateUsernameParams(userId, newUsername))` |
| `delete_message` | `call(DeleteMessageParams(messageId))` |
| `edit_message` | `call(EditMessageParams(messageId, newContent))` |
| `mark_message_read` | `call(MarkMessageReadParams(messageId, userId))` |
| `get_message_status` | `call(GetMessageStatusParams(messageId, userId))` |
| `get_room_members` | `call(GetRoomMembersParams(roomId))` |

### Step 7: States — Rewrite

| File | Action |
|------|--------|
| `chat_list_state.dart` | Rewrite with `ChatListInitial`, `ChatListLoading`, `ChatListLoaded(rooms, isSearching, searchQuery)`, `ChatListEmpty`, `ChatListError` — all with `copyWith` |
| `chat_room_state.dart` | Rewrite with `ChatRoomInitial`, `ChatRoomLoading`, `ChatRoomLoaded(messages, hasMore, loadingMore, sendingMessage)`, `ChatRoomError` — all with `copyWith` |

### Step 8: Cubits — Full rewrite

| File | Action |
|------|--------|
| `chat_list_cubit.dart` | Rewrite with `init(int userId)`, `loadChatRooms()`, `searchChatRooms(String)`, `onChatRoomOpened(String roomId)`, `refresh()` |
| `chat_room_cubit.dart` | Rewrite with `init(String roomId, int userId)`, `loadMoreMessages()`, `sendMessage(String)`, `editMessage(String, String)`, `deleteMessage(String)`, `retrySendMessage(String)`, `dispose()` |

**Optimization features:**
- Deduplication via `Set<String> knownMessageIds`
- Diff-based state emission for chat list (skip emit if no changes)
- `BlocSelector`-ready state props
- Reconnect handling — resubscribe + catch-up fetch
- App lifecycle — pause/resume subscriptions via `WidgetsBindingObserver`

### Step 9: DI — Rewrite

| File | Action |
|------|--------|
| `chat_injection.dart` | Rewrite — register data source, repository, 25 use cases, 2 cubits |
| `di.dart` (in core) | Uncomment `initChatList()` |

### Step 10: Routes — Rewrite

| File | Action |
|------|--------|
| `chat_route.dart` | Rewrite — `ChatListPage` at `/chat`, `ChatRoomPage` at `/chat/chat-details/:roomId` |
| `bridge_x_routes.dart` | Add `chatRoute` to `StatefulShellRoute` branches |

### Step 11: Pages — Minimal updates

| File | Action |
|------|--------|
| `chat_list_page.dart` | Rewrite — adapt for new state structure, wire cubit methods |
| `chat_room_page.dart` | Rewrite — adapt for new state structure, wire send/edit/delete |
| `message_list_widget.dart` | Rewrite — adapt pagination, integrate status indicators |

---

## Network Failure & Offline Strategy

| Scenario | Behavior |
|----------|----------|
| Offline at open | State = `ChatRoomError("No internet")` |
| Send fails | Optimistic message status → `failed`, retry button shown |
| Realtime disconnect | Supabase SDK auto-reconnects; on reconnect → resubscribe + catch-up fetch |
| Duplicate prevention | `Set<String>` of known message IDs skips duplicates |
| Retry mechanism | `retrySendMessage(localId)` re-sends and updates status |
| App lifecycle | Subscriptions paused in background, resumed + caught-up on foreground |

---

## Edge Cases Coverage

| Edge Case | Handling |
|-----------|----------|
| Duplicate join request | DB `UNIQUE(room_id, user_id)` constraint |
| Duplicate invitation | DB `UNIQUE(room_id, invitee_id)` constraint |
| User already in room | Check `chat_room_members` before accepting |
| User removed mid-chat | Realtime on `chat_room_members` DELETE → navigate out |
| Leader leaving | Require transfer first |
| Two leaders | Partial unique index `WHERE role = 'leader'` |
| Room deleted with listeners | CASCADE deletes + cubit listens to `chat_rooms` status |
| Concurrent message insert | Atomic trigger — no race condition |
| Username change | Single-row update on `chat_users` — all queries reflect immediately |
| Deleted user | `ON DELETE SET NULL` on `sender_id` |
