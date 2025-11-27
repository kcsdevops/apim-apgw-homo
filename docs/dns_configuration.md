# Configuração de DNS (Homologação)

Para garantir o acesso correto aos serviços do ambiente de homologação, é necessário configurar as entradas DNS no seu provedor de domínio (ex: GoDaddy, Registro.br, Route53).

O domínio base utilizado é: `homolog.meurh360.com.br`.

## Entradas Necessárias

### 1. Application Gateway (Ponto de Entrada Principal)
O Application Gateway é a porta de entrada para as aplicações web.

- **Tipo:** `CNAME`
- **Nome (Host):** `app` (resultando em `app.homolog.meurh360.com.br`)
- **Valor (Destino):** `meurh360-homolog-agw.brazilsouth.cloudapp.azure.com`
  - *Nota:* Este endereço é gerado pelo `domain_name_label` configurado no IP Público do Application Gateway.

### 2. API Management (APIM)
O APIM gerencia as chamadas de API.

- **Tipo:** `CNAME`
- **Nome (Host):** `api` (resultando em `api.homolog.meurh360.com.br`)
- **Valor (Destino):** `[nome-do-apim].azure-api.net`
  - *Exemplo:* `meurh360-br-apim-homolog.azure-api.net`
  - *Nota:* Verifique o output `gateway_url` do Terraform para o endereço exato.

### 3. Container Apps (Acesso Direto - Opcional)
Caso seja necessário acessar diretamente os Container Apps (embora o recomendado seja via App Gateway).

- **Tipo:** `CNAME`
- **Nome (Host):** `*.apps` (resultando em `qualquer-coisa.apps.homolog.meurh360.com.br`)
- **Valor (Destino):** `[default-domain-do-environment]`
  - *Nota:* O domínio padrão do Container Apps Environment pode ser encontrado no portal do Azure.

## Resumo da Tabela DNS

| Serviço | Tipo | Host | Destino |
| :--- | :--- | :--- | :--- |
| **App Gateway** | CNAME | `app` | `meurh360-homolog-agw.brazilsouth.cloudapp.azure.com` |
| **APIM** | CNAME | `api` | `meurh360-br-apim-homolog.azure-api.net` |
| **Container Apps** | CNAME | `*.apps` | `(Consultar no Portal Azure)` |

## Validação
Após configurar, aguarde a propagação do DNS e teste usando:
```bash
nslookup app.homolog.meurh360.com.br
```
