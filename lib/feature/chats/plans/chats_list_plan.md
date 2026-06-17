# Bridge X — Chat Module 

## Overview

This is the **final, complete architecture** for the Chats List feature in Bridge X, including all consistency, sync, security, real-time, and cold-start guarantees.

The Chats List is a **fully independent, event-driven, materialized chat index layer** built on Supabase and synchronized with the backend.

---

# Core Concept

The Chats List is NOT computed from:
- backend `/my-projects`
- messages table
- runtime joins

Instead it is:

> A precomputed, denormalized, real-time safe projection of team communication state.

---

# System Architecture

## Backend (Source of Truth)
Responsible for:
- Teams
- Users
- Memberships
- Invitations
- Role management

---

## Chat System (Supabase)
Responsible for:
- Messages
- Chat rooms (materialized state)
- Room membership cache
- Unread counters
- Real-time updates

---

# Core Entities

## 1. Chat Room (Materialized State)

Represents a team chat preview.

Stores:
- team_id (primary key)
- team_name
- last_message (snapshot)
- last_message_sender_id
- last_message_sender_name (snapshot)
- last_message_at

### Consistency Model:
- Eventual consistency allowed
- Updated only via triggers or sync events

---

## 2. Room Member

Represents user membership inside a chat.

Stores:
- team_id
- user_id
- last_read_at
- unread_count (cached)

### Responsibilities:
- Access control
- unread tracking
- per-user chat state

---

## 3. Messages

Stores actual chat content.

Stores:
- message_id
- team_id
- sender_id
- sender_name (snapshot)
- content
- created_at

---

# Chats List Requirements

## UI Fields

Each chat item displays:
- team_name
- last_message
- last_message_sender_name
- last_message_at
- unread_count

---

## Sorting Rule

- last_message_at DESC
- null values last

---

# Sync System

## Sync Philosophy

Chat is independent but synchronized through events.

---

## 1. Sync Triggers (Backend Events)

Triggered when:
- team created
- member added
- member removed
- invitation accepted

---

## 2. Sync Delivery Mechanism

One of:
- Supabase Edge Functions (recommended)
- backend direct Supabase API calls
- future queue system

---

## 3. Sync Behavior

Each event ensures:
- chat_room exists
- room_members are aligned
- missing state is repaired

---

# Reconciliation System

## 1. App Launch Reconciliation (Global)

Runs once per session:
- sync backend memberships
- sync Supabase room_members
- fix mismatches

Fixes:
- missing memberships
- extra stale rows
- unread inconsistencies

---

## 2. Cold-Open Reconciliation (CRITICAL)

Triggered when entering a chat WITHOUT prior app launch sync.

### Trigger:
- deep link
- push notification open
- direct room navigation

### Behavior:
- scoped reconciliation only for that room
- fix membership + unread state
- ensure chat_room exists
- then load messages

### Guarantee:
> No chat room can be opened without consistency validation

---

# Unread Count System

## Core Rule

Unread count is fully database-owned.

---

## Update Strategy

On message insert:
- atomically increment unread_count for all members except sender
- handled via DB trigger or Edge Function

---

## Reset Strategy

On chat open:
- unread_count = 0
- last_read_at = now()

Atomic per user per room.

---

## UX Rule

- 0–99 → exact number
- 99+ → capped display

---

# Last Message System

## Stored Snapshot

- message text
- sender id
- sender name
- timestamp

---

## Update Rule

Updated only when a new message is inserted.

---

## Deletion Behavior

- stale last_message allowed
- eventual consistency accepted
- optional future repair job

---

# Sender Name Strategy

- stored as snapshot at message time
- not updated retroactively
- accepts eventual consistency

---

# Security Model (RLS - REQUIRED)

## chat_rooms
- accessible only if user exists in room_members

## room_members
- users can only access their own membership row

## messages
- accessible only if user is member of team
- sender_id must match authenticated identity

---

# Chat Search System

## Scope
- team_name only

---

## Behavior
- server-side search
- case-insensitive
- partial match
- debounced queries

---

## Optimization
- pg_trgm extension
- GIN index on team_name

---

# Real-Time System

## Subscription Scope

Each user subscribes only to:
- their chat_rooms updates
- their room_members updates

---

## Real-Time Events

- new message
- last message update
- unread count change

---

## Constraint

> No global or unfiltered subscriptions

---

# Chat List Data Contract

Each item includes:
- team_id
- team_name
- last_message
- last_message_sender_name
- last_message_at
- unread_count

---

# Performance Strategy

- no joins in chat list queries
- fully denormalized chat_rooms
- atomic DB updates
- precomputed unread counts
- indexed search fields

---

# Edge Cases

- late sync → handled by reconciliation
- stale last message → allowed
- name changes → not reflected historically
- high activity → UI capped unread display

---

# Scalability Guarantees

- O(1) chat list rendering
- atomic counter updates
- minimal realtime scope
- indexed search
- backend-driven structure
- Supabase-driven state

---

# Final System Guarantees

✔ No unread race conditions  
✔ Fully secure RLS-based access  
✔ No dependency on backend at runtime  
✔ Real-time updates without polling  
✔ Safe deep-link and push notification handling  
✔ Deterministic chat list rendering  
✔ Fully independent chat module  
✔ Resilient to sync failures  
✔ Production-grade scalability  

---

# Future Extensions (Out of Scope)

- Chat room messaging engine
- Pagination system
- Typing indicators
- Attachments
- Reactions
- Push notifications
- Message search
- Read receipts

---

# Final Summary

The Chats List in Bridge X is now a:

> Fully independent, event-driven, real-time, secure, and self-healing chat index system

It behaves like a **materialized, consistency-safe projection layer** over team communication state, designed for production-scale reliability.