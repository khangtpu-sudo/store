create extension if not exists pgcrypto;
create table if not exists profiles(id uuid primary key references auth.users(id) on delete cascade,username text unique not null,avatar_url text,created_at timestamptz default now());
create table if not exists conversations(id uuid primary key default gen_random_uuid(),created_at timestamptz default now());
create table if not exists conversation_members(conversation_id uuid references conversations(id) on delete cascade,user_id uuid references profiles(id) on delete cascade,primary key(conversation_id,user_id));
create table if not exists messages(id uuid primary key default gen_random_uuid(),conversation_id uuid not null references conversations(id) on delete cascade,sender_id uuid not null references profiles(id) on delete cascade,content text not null check(char_length(content)<=5000),created_at timestamptz default now());
alter table profiles enable row level security; alter table conversations enable row level security; alter table conversation_members enable row level security; alter table messages enable row level security;
create policy "members read messages" on messages for select using (exists(select 1 from conversation_members cm where cm.conversation_id=messages.conversation_id and cm.user_id=auth.uid()));
create policy "members send messages" on messages for insert with check(auth.uid()=sender_id and exists(select 1 from conversation_members cm where cm.conversation_id=conversation_id and cm.user_id=auth.uid()));
alter publication supabase_realtime add table messages;