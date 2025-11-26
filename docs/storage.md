# Storage (Storage Account)

## O que é?
O **Storage Account** é o serviço de armazenamento genérico do Azure. Pode guardar arquivos (Blobs), filas (Queues), tabelas (Tables) e arquivos compartilhados (Files).

## Como está configurado?
- **Tipo:** `StorageV2` (Padrão moderno).
- **Redundância:** `LRS` (Locally Redundant Storage) - Os dados são replicados 3 vezes dentro do mesmo data center. É o mais barato.

## Dicas de Melhoria (Próximos Passos)

1.  **Lifecycle Management:**
    - *Melhoria:* Criar regras para mover arquivos antigos para camadas mais baratas (Cool ou Archive) ou deletá-los automaticamente após X dias para economizar.

2.  **Segurança:**
    - *Melhoria:* Desabilitar acesso público ao blob se não for estritamente necessário. Usar **SAS Tokens** (com tempo de expiração curto) ou Identidade Gerenciada para acesso.

3.  **Redundância:**
    - *Melhoria:* Para dados críticos em produção, usar `GRS` (Geo-Redundant Storage) para replicar os dados em outra região geográfica.
