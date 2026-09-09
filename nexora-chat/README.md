# NEXORA CHAT

Next.js + Supabase starter cho web nhắn tin realtime có lưu lịch sử.

## Chạy

```bash
cd nexora-chat
npm install
cp .env.example .env.local
npm run dev
```

Điền Supabase URL và anon key vào `.env.local`.

## Lưu lịch sử chat

1. Vào Supabase SQL Editor.
2. Chạy toàn bộ `supabase/schema.sql`.
3. Tin nhắn được lưu trong bảng `messages`.
4. Lịch sử được tải bằng `conversation_id` và sắp xếp theo `created_at`.

## Lưu ý

Giao diện hiện tại là MVP. Trước khi triển khai thật, cần hoàn thiện đăng ký/đăng nhập, tạo cuộc trò chuyện, policies cho toàn bộ bảng và route AI phía server.