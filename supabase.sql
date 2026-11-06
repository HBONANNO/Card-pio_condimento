-- Banco de dados dos pedidos do Condimento.
-- Cole tudo isto no Supabase: SQL Editor → New query → Run.

create table if not exists public.pedidos (
  id          bigint generated always as identity primary key,
  created_at  timestamptz not null default now(),
  mesa        int  not null check (mesa between 1 and 999),
  tipo        text not null default 'pedido' check (tipo in ('pedido', 'garcom', 'conta')),
  itens       jsonb not null default '[]'::jsonb
              check (jsonb_typeof(itens) = 'array' and jsonb_array_length(itens) <= 60),
  observacao  text check (char_length(observacao) <= 500),
  total       numeric(10,2),
  status      text not null default 'novo' check (status in ('novo', 'preparando', 'entregue'))
);

create index if not exists pedidos_created_at_idx on public.pedidos (created_at desc);

alter table public.pedidos enable row level security;

-- Clientes (sem login) só podem CRIAR pedidos novos. Não conseguem ler nem alterar nada.
drop policy if exists "clientes enviam pedidos" on public.pedidos;
create policy "clientes enviam pedidos" on public.pedidos
  for insert to anon
  with check (status = 'novo');

-- A equipe (com login) vê e atualiza os pedidos.
drop policy if exists "equipe ve pedidos" on public.pedidos;
create policy "equipe ve pedidos" on public.pedidos
  for select to authenticated
  using (true);

drop policy if exists "equipe atualiza pedidos" on public.pedidos;
create policy "equipe atualiza pedidos" on public.pedidos
  for update to authenticated
  using (true) with check (true);

grant insert on public.pedidos to anon;
grant select, update on public.pedidos to authenticated;
