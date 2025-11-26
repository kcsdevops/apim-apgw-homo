# API Management (APIM)

## O que é?
O **APIM** é um portal para gerenciar suas APIs. Ele serve como uma fachada para seus serviços backend. Ele cuida de autenticação, limitação de taxa (rate limiting), cache e documentação da API para desenvolvedores.

## Como está configurado?
- **SKU:** `Developer` (Baixo custo, não possui SLA de produção, ideal para testes e homologação).
- **Publisher:** Configurado com o nome da empresa.

## Dicas de Melhoria (Próximos Passos)

1.  **Segurança (Policies):**
    - *Melhoria:* Configurar políticas XML para validar tokens JWT (OAuth2) antes da requisição chegar no backend. Isso tira a carga de autenticação da sua aplicação.

2.  **Rate Limiting:**
    - *Melhoria:* Configurar limites (ex: 100 requisições por minuto por usuário) para proteger o backend contra abusos.

3.  **SKU de Produção:**
    - *Melhoria:* Ao ir para produção, migrar para SKU `Basic`, `Standard` ou `Premium` para ter SLA e redundância.

4.  **Developer Portal:**
    - *Melhoria:* Customizar o portal do desenvolvedor para expor a documentação (Swagger/OpenAPI) das suas APIs para os parceiros ou times internos.
