# Application Gateway (Load Balancer)

## O que é?
O **Application Gateway** é um balanceador de carga inteligente para tráfego web (HTTP/HTTPS). Ele fica na frente da sua aplicação recebendo os usuários.
Nesta configuração de homologação, estamos utilizando a versão **Standard V1** para otimização de custos.

## Como está configurado?
- **Módulo:** modules/app_gateway
- **SKU:** Standard_Small (Tier Standard V1).
- **IP Público:** SKU Basic, alocação Dinâmica (requisito da V1).
- **Backend:** Aponta para os Container Apps.
- **Otimização:** Configurado para fazer o roteamento básico na porta 80.

## Decisão de Arquitetura (Custos)
Optamos pelo **Standard V1** em vez do V2 para este ambiente de homologação/dev devido à diferença significativa de preço:
- **V2:** ~R$ 2.900,00/mês (Custo fixo alto).
- **V1 (Small):** ~R$ 250,00 - R$ 300,00/mês (Estimado).

## Dicas de Melhoria (Para Produção)

1.  **Migrar para V2 (Produção):**
    - Para ambientes produtivos, recomenda-se o SKU **Standard_v2** ou **WAF_v2** para melhor performance, autoscaling e suporte a Header Rewrites.

2.  **Habilitar WAF:**
    - Caso migre para a V2, ativar o SKU **WAF_v2** para proteção contra ataques comuns (OWASP).

3.  **HTTPS / SSL:**
    - *Atual:* Porta 80 (HTTP).
    - *Melhoria:* Configurar listeners **HTTPS (443)** e importar certificados.
