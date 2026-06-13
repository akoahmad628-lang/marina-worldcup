-- Marina World Cup 2026 Supabase setup
-- 1) Create a Supabase project
-- 2) SQL Editor -> paste all -> Run
-- 3) Project Settings -> API -> copy Project URL and anon public key into the HTML files

create table if not exists games (
  id uuid primary key default gen_random_uuid(),
  team1 text not null,
  team2 text not null,
  flag1 text default '🏳️',
  flag2 text default '🏳️',
  match_date date not null,
  kickoff_time text not null,
  close_time text not null,
  active boolean default true,
  score1 int,
  score2 int,
  created_at timestamptz default now()
);

create table if not exists predictions (
  id uuid primary key default gen_random_uuid(),
  game_id uuid references games(id) on delete cascade,
  full_name text not null,
  phone text not null,
  building text not null,
  floor text not null,
  apartment text not null,
  apartment_code text not null,
  pred1 int not null,
  pred2 int not null,
  created_at timestamptz default now(),
  unique(game_id, phone),
  unique(game_id, apartment_code)
);

create table if not exists winners (
  id uuid primary key default gen_random_uuid(),
  game_id uuid references games(id) on delete cascade,
  winner_name text not null,
  apartment_code text,
  prize text,
  created_at timestamptz default now(),
  unique(game_id)
);

-- Simple public access for a static website. For stronger security, use a backend/API later.
alter table games enable row level security;
alter table predictions enable row level security;
alter table winners enable row level security;

drop policy if exists "public read games" on games;
drop policy if exists "public insert games" on games;
drop policy if exists "public update games" on games;
drop policy if exists "public delete games" on games;
create policy "public read games" on games for select using (true);
create policy "public insert games" on games for insert with check (true);
create policy "public update games" on games for update using (true);
create policy "public delete games" on games for delete using (true);

drop policy if exists "public read predictions" on predictions;
drop policy if exists "public insert predictions" on predictions;
drop policy if exists "public delete predictions" on predictions;
create policy "public read predictions" on predictions for select using (true);
create policy "public insert predictions" on predictions for insert with check (true);
create policy "public delete predictions" on predictions for delete using (true);

drop policy if exists "public read winners" on winners;
drop policy if exists "public insert winners" on winners;
drop policy if exists "public update winners" on winners;
drop policy if exists "public delete winners" on winners;
create policy "public read winners" on winners for select using (true);
create policy "public insert winners" on winners for insert with check (true);
create policy "public update winners" on winners for update using (true);
create policy "public delete winners" on winners for delete using (true);

-- Default tonight game
insert into games (team1, team2, flag1, flag2, match_date, kickoff_time, close_time, active)
values ('Brazil', 'Morocco', '🇧🇷', '🇲🇦', '2026-06-14', '01:00', '00:00', true)
on conflict do nothing;
