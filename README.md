# Cardápio digital · Condimento Café & Bistrô

- **Cardápio (consulta):** `https://cardapio-condimento.vercel.app/`
- **Cardápio com pedido pela mesa:** `https://cardapio-condimento.vercel.app/?mesa=NÚMERO`
  (ex.: mesa 5 → `...?mesa=5`). Grave um link diferente em cada plaquinha NFC / QR code.
- **Painel da cozinha:** `https://cardapio-condimento.vercel.app/cozinha.html`

## Arquivos
| Arquivo | O que é |
|---|---|
| `index.html` | Cardápio. Pratos e preços ficam na lista `MENU` dentro dele. |
| `cozinha.html` | Painel da cozinha: pedidos chegando, chamados de garçom e pedidos de conta. |
| `config.js` | Endereço e chave pública do Supabase (banco de dados dos pedidos). |
| `supabase.sql` | Cria a tabela de pedidos e as regras de segurança. |

## Como ativar os pedidos (uma vez só)
1. Crie uma conta grátis em supabase.com e um projeto novo (região São Paulo).
2. No projeto: **SQL Editor → New query**, cole o conteúdo de `supabase.sql` e clique **Run**.
3. **Authentication → Sign In / Providers**: desligue **"Allow new users to sign up"**
   (assim ninguém de fora consegue criar login da cozinha).
4. **Authentication → Users → Add user**: crie o e-mail e a senha da equipe da cozinha.
5. **Project Settings → API**: copie o *Project URL* e a chave pública (*anon* / *publishable*)
   para o `config.js`. Nunca use a chave *service_role* / *secret*.

## Como a cozinha usa
- Abrir o painel no tablet, entrar com o e-mail/senha da equipe e tocar em **Ativar som**
  (o tablet apita a cada pedido novo e a tela não apaga).
- Pedido novo → **Começar a preparar** → **Entregue na mesa**.
- Chamados de garçom e pedidos de conta aparecem em destaque no topo → **Atendido**.
- O pagamento continua no final, com o garçom, no caixa/sistema do restaurante.
