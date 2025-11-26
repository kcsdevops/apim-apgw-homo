# Banco de Dados (PostgreSQL Flexible Server)

## O que é?
O **Azure Database for PostgreSQL - Flexible Server** é um serviço de banco de dados gerenciado. Pense nele como um PostgreSQL "tunado" pela Microsoft, onde eles cuidam da infraestrutura (servidor, atualizações, backups) e você foca apenas nos dados e nas tabelas.

## Como está configurado?
Neste projeto, configuramos o banco de dados com foco em segurança e isolamento:

- **Versão:** PostgreSQL 13.
- **SKU (Tamanho):** `B_Standard_B1ms` (Econômico, ideal para homologação/dev).
- **Rede:** **Privada**. O banco não tem endereço IP público. Ele está "escondido" dentro da Subnet `postgres-subnet`.
- **Acesso:** Apenas recursos dentro da mesma VNet (como os Containers) conseguem "ver" e conectar no banco.
- **DNS:** Usamos uma Zona de DNS Privado (`meurh360.postgres.database.azure.com`) para que a aplicação consiga encontrar o banco pelo nome, já que ele não está na internet pública.

## Dicas de Melhoria (Próximos Passos)

1.  **Gerenciamento de Senhas:**
    - *Atual:* A senha está definida no código (hardcoded).
    - *Melhoria:* Usar o **Key Vault** para gerar e armazenar a senha, injetando-a no Terraform dinamicamente.

2.  **Alta Disponibilidade (HA):**
    - *Atual:* Zona única.
    - *Melhoria:* Para produção, habilitar `Zone Redundant` (Alta Disponibilidade). Se um data center cair, o banco muda automaticamente para outro.

3.  **Backups:**
    - *Atual:* Padrão do Azure.
    - *Melhoria:* Configurar retenção de backup personalizada (ex: 35 dias) e Geo-Redundância (backup em outra região) para desastres.

4.  **Autenticação:**
    - *Melhoria:* Habilitar autenticação via **Microsoft Entra ID (antigo Azure AD)** para não precisar gerenciar usuários e senhas de banco locais.
