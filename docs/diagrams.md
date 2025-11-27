# Diagramas de Arquitetura

## 1. Diagrama de Rede (Network)

Este diagrama detalha a segmentação da rede (VNet), as faixas de IP (CIDR) e as subnets configuradas.

- **VNet:** `10.0.0.0/16`
- **Subnets:**
  - `default`: `10.0.1.0/24` (Uso geral)
  - `appgw-subnet`: `10.0.2.0/24` (Dedicada ao Application Gateway)
  - `postgres-subnet`: `10.0.3.0/24` (Delegada ao PostgreSQL)
  - `aca-subnet`: `10.0.4.0/23` (Delegada ao Container Apps - Faixa maior para suportar escalabilidade de pods)

```mermaid
graph TB
    subgraph VNet["VNet: meurh360-br-vnet-homolog (10.0.0.0/16)"]
        direction TB
        
        subgraph SnetDefault["Subnet: default (10.0.1.0/24)"]
            Note1[Uso Geral]
        end

        subgraph SnetAGW["Subnet: appgw-subnet (10.0.2.0/24)"]
            AGW[Application Gateway]
            NSG_AGW[NSG: (Regras de Entrada HTTP/HTTPS)]
        end

        subgraph SnetDB["Subnet: postgres-subnet (10.0.3.0/24)"]
            DB[PostgreSQL Flexible Server]
            DelegationDB[Delegation: Microsoft.DBforPostgreSQL]
            SE_Storage[Service Endpoint: Microsoft.Storage]
        end

        subgraph SnetACA["Subnet: aca-subnet (10.0.4.0/23)"]
            ACA[Container Apps Environment]
            DelegationACA[Delegation: Microsoft.App/environments]
            API[Container App API]
        end
    end

    Internet((Internet)) -->|"Public IP (Basic)"| AGW
    AGW -->|"Private IP (VNet)"| API
    API -->|"Private Link/VNet"| DB

    classDef subnet fill:#e1f5fe,stroke:#01579b,stroke-width:2px;
    classDef nsg fill:#ffebee,stroke:#b71c1c,stroke-width:2px,stroke-dasharray: 5 5;
    
    class SnetDefault,SnetAGW,SnetDB,SnetACA subnet;
    class NSG_AGW nsg;
```

## 2. Diagrama de Segurança

Este diagrama ilustra as camadas de segurança implementadas, desde a identidade até a proteção de dados.

- **Identidade:** Uso de Managed Identities para evitar credenciais hardcoded.
- **Segredos:** Key Vault centraliza o armazenamento seguro.
- **Rede:** Isolamento via VNet Injection (o banco de dados não tem IP público).
- **Aplicação:** Application Gateway atua como proxy reverso, ocultando a topologia interna.

```mermaid
graph TD
    subgraph Identity["Gerenciamento de Identidade"]
        UAI[User Assigned Identity: meurh360-br-agw-identity]
        SP[Service Principal (Terraform)]
    end

    subgraph Secrets["Gestão de Segredos (Key Vault)"]
        KV[Key Vault: meurh360-br-kv-homolog]
        Secret1[Database Credentials]
        Secret2[API Keys]
    end

    subgraph NetworkSecurity["Segurança de Rede"]
        AGW[Application Gateway (Reverse Proxy)]
        NSG[Network Security Groups (Firewall L4)]
        VNetInjection[VNet Injection (Isolamento)]
    end

    subgraph DataSecurity["Segurança de Dados"]
        Postgres[PostgreSQL (SSL Enforced)]
        Storage[Storage Account (Encrypted)]
    end

    %% Relacionamentos
    SP -->|"Gerencia"| KV
    UAI -.->|"Acesso Futuro (Certificados)"| KV
    
    AGW -->|"Protege (Oculta Backend)"| VNetInjection
    NSG -->|"Filtra Tráfego"| VNetInjection
    
    VNetInjection -->|"Acesso Privado"| Postgres
    VNetInjection -->|"Acesso Privado"| Storage

    classDef security fill:#fff3e0,stroke:#e65100,stroke-width:2px;
    class Identity,Secrets,NetworkSecurity,DataSecurity security;
```
