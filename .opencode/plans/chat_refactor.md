# Chat Feature Refactor Plan

## Goals
1. Replace `CircularProgressIndicator` loading with `BridgeXSkeletonizer` shimmer (like dashboard)
2. Replace all hardcoded `Color(0xFF...)` with `context.colors.xxx` / `AppColors.xxx`
3. Use screen utilities (`.w`/`.h`/`.sp` / `AppSpacing`) for sizing

---

## File-by-File Changes

### 1. `search_bar_widget.dart`

**Replace hardcoded colors with `context.colors`:**
- `Color(0xFFF1F5F9)` → `context.colors.scaffoldBg`
- `Color(0xFF0F172A)` → `context.colors.textPrimary`
- `Color(0xFF94A3B8)` → `context.colors.textHint`
- `Color(0xFF64748B)` → `context.colors.textHint`

**Add import:**
```dart
import 'package:bridge_x/core/extensions/context_extension.dart';
```

---

### 2. `message_input_widget.dart`

**Replace hardcoded colors:**
- `Colors.white` (container bg) → `context.colors.surface`
- `Color(0xFFEFF3FD)` (input pill bg) → `context.colors.primaryLight`
- `Color(0xFF94A3B8)` (attachment icon, hint text) → `context.colors.textHint`
- `Color(0xFF0F172A)` (text style) → `context.colors.textPrimary`
- `Color(0xFF4D73F8)` (send btn active) → `context.colors.primary`
- `Color(0xFF93C5FD)` (send btn inactive) → `context.colors.primaryLight`
- `Colors.white` (send icon) → `context.colors.surface`

**Replace raw sizes with `AppSpacing` or `.w`/`.h`:**
- `EdgeInsets.only(left: 16, right: 16, top: 8, bottom: ...)` → `AppSpacing.pagePadding` or similar
- Raw `44` (button size) → `AppSpacing.iconBoxSize`

**Add imports:**
```dart
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

---

### 3. `message_bubble_widget.dart`

**Keep as-is (intentional):**
- All syntax highlighting colors (`0xFFC084FC`, `0xFFFBBF24`, `0xFFF97316`, `0xFF34D399`)
- Code block dark background (`0xFF0F172A`)
- Avatar colors for Alex/Sarah/Chen — these are decorative/contextual

**Replace hardcoded colors that have theme equivalents:**
- `Color(0xFF64748B)` (sender name, language label) → `context.colors.textSecondary`
- `Color(0xFF94A3B8)` (timestamp, filename, status sent) → `context.colors.textHint`
- `Color(0xFF4D73F8)` (own bubble) → `context.colors.primary`
- `Colors.white` (other bubble bg) → `context.colors.surface`
- `Color(0xFFE2E8F0)` (other bubble border) → `context.colors.divider`
- `Color(0xFF0F172A)` (other text) → `context.colors.textPrimary`
- `Color(0xFFCBD5E1)` (status sending) → `context.colors.textHint`
- `Color(0xFF1E293B)` (code block divider) → `context.colors.divider`
- `Color(0xFFE2E8F0)` (code text) → no direct match, keep or use `context.colors.textSecondary`

**Add imports:**
```dart
import 'package:bridge_x/core/extensions/context_extension.dart';
```

**Remove unused:** `import 'package:bridge_x/core/theme/bridge_x_colors.dart'` if `AppColors.error` is the only usage — replace `AppColors.error` with `context.colors.error`.

---

### 4. `chat_room_list_tile.dart`

**Replace hardcoded colors:**
- `Color(0xFFF1F5F9)` (default avatar bg) → `context.colors.scaffoldBg`
- `Color(0xFF4F46E5)` (default avatar text) → `AppColors.indigo`
- `Color(0xFF0F172A)` (Team Alpha avatar bg) → `AppColors.navyBlue`
- `Color(0xFF22D3EE)` (Team Alpha icon) → keep as-is (brand color)
- `Color(0xFFE2E8F0)` (Backend Core avatar bg) → `context.colors.divider`
- `Color(0xFF475569)` (Backend Core icon) → keep as-is
- `Color(0xFFFFEDD5)` (DevOps avatar bg) → keep as-is
- `Color(0xFFEA580C)` (DevOps icon) → keep as-is
- `Color(0xFF1E2937)` (Design avatar bg) → `context.colors.darkGray` / keep
- `Color(0xFFF59E0B)` (Design icon) → `AppColors.amber`
- `Color(0xFF10B981)` (online dot, badge) → `context.colors.success`
- `Colors.white` (dot border, badge text) → `context.colors.surface`
- `Color(0xFF0B0F19)` (title, timestamp highlighted) → `context.colors.textPrimary`
- `Color(0xFF6B7280)` (subtitle) → `context.colors.textSecondary`
- `Color(0xFF9CA3AF)` (timestamp normal) → `context.colors.textHint`
- `Color(0xFFEFF6FF)` (highlighted card bg) → `context.colors.primaryLight`
- `Color(0xFFE5E7EB)` (divider) → `context.colors.divider`

**Add imports:**
```dart
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
```

---

### 5. `chat_list_page.dart` — Skeletonizer + Colors

**Loading behavior change:**
- Remove the `ChatListLoading → CircularProgressIndicator` branch
- Wrap the main content (search bar + list) in `BridgeXSkeletonizer`
- Enable skeleton when `state is ChatListLoading`
- Show placeholder `ChatRoomListTile` items during loading (hardcoded empty data)
- Or simpler: reuse the existing list with empty `ChatRoomEntity` placeholders and let the skeleton shimmer over them

**Replace hardcoded colors in empty state:**
- `Color(0xFFF1F5F9)` (robot card) → `context.colors.scaffoldBg`
- `Color(0xFF0F3E83)` (robot icon, right bubble icon) → `context.colors.primary`
- `Color(0xFF6366F1)` (purple heart badge) → `AppColors.indigo`
- `Colors.white` (heart, bubble bg) → `context.colors.surface`
- `Color(0xFF475569)` (left bubble icon) → `context.colors.textSecondary`
- `Color(0xFF93C5FD)` (dots inactive) → `context.colors.primaryLight`
- `Color(0xFF3B82F6)` (dot active) → `context.colors.primary`
- `Color(0xFF4C1D95)` (title) → `AppColors.indigo`
- `Color(0xFF64748B)` (description) → `context.colors.textSecondary`
- `Colors.white` (scaffold) → `context.colors.surface`
- `Color(0xFF0F172A)` (header "Chates") → `context.colors.textPrimary`
- `Color(0xFF94A3B8)` (section label) → `context.colors.textHint`

**Add imports:**
```dart
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
```

---

### 6. `message_list_widget.dart` — Skeletonizer + Colors

**Loading behavior change:**
- Remove the `ChatRoomLoading → CircularProgressIndicator` branch — the parent's `BridgeXSkeletonizer` handles it
- (Skeletonizer wraps at the `ChatRoomPage` level)

**Replace hardcoded colors:**
- `Color(0xFFE2D9FF)` (date badge bg) → `AppColors.today`
- `Color(0xFF6366F1)` (date text) → `AppColors.indigo`

**Add import:**
```dart
import 'package:bridge_x/core/theme/bridge_x_colors.dart';
```

---

### 7. `chat_room_page.dart` — Skeletonizer + Colors

**Add skeletonizer wrapping the message list:**
```dart
BridgeXSkeletonizer(
  enableloading: state is ChatRoomLoading,
  child: MessageListWidget(...),
)
```

**Replace hardcoded colors:**
- `Colors.white` (scaffold) → `context.colors.surface`
- `Color(0xFFEFF6FF)` (appbar bg) → `context.colors.primaryLight`
- `Color(0xFF0F172A)` (back arrow, title, info icon) → `context.colors.textPrimary`
- `Color(0xFF64748B)` (subtitle "5 MEMBERS") → `context.colors.textSecondary`

**Add imports:**
```dart
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/widget/loading/bridge_x_skeletonizer.dart';
```

---

## Implementation Order
1. `search_bar_widget.dart` (simple color swap)
2. `message_input_widget.dart` (color swap + spacing)
3. `message_bubble_widget.dart` (partial color swap, keep syntax colors)
4. `chat_room_list_tile.dart` (color swap)
5. `message_list_widget.dart` (colors only)
6. `chat_room_page.dart` (skeletonizer + colors)
7. `chat_list_page.dart` (skeletonizer + colors — most complex)
8. Run `flutter analyze` to verify no issues
