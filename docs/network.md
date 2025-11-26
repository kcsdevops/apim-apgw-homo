# Rede (Virtual Network - VNet)

## O que é?
A **VNet** é a sua rede privada na nuvem. É como se fosse a rede local (LAN) do seu escritório, mas virtual. Dentro dela, criamos "bairros" chamados **Subnets** para organizar os recursos.

## Como está configurado?
- **VNet Principal:** `meurh360-br-vnet-homolog` (Bloco `10.0.0.0/16`).
- **Subnets:**
    1.  **`default` (10.0.1.0/24):** Para recursos gerais.
    2.  **`appgw-subnet` (10.0.2.0/24):** Exclusiva para o Application Gateway. O Azure exige uma subnet só para ele.
    3.  **`postgres-subnet` (10.0.3.0/24):** Delegada para o PostgreSQL. É uma área reservada onde apenas o banco reside.
    4.  **`aca-subnet` (10.0.4.0/23):** Delegada para o Container Apps. Permite que os containers tenham IPs internos dessa rede.

- **NSG (Network Security Group):** É o firewall básico da rede. Atualmente temos um NSG padrão associado, permitindo o tráfego básico.
- **Application Gateway:** Configurado com SKU **Standard V1 Medium** para otimização de custos em homologação. **Nota:** Este tier não possui WAF habilitado.

## Dicas de Melhoria (Próximos Passos)

1.  **Segurança de Rede (NSG):**
    - *Atual:* Regras padrão (permissivas).
    - *Melhoria:* Implementar regras de **Negação Padrão**. Liberar apenas as portas estritamente necessárias (ex: bloquear todo tráfego de entrada na subnet do banco, exceto vindo da subnet dos containers na porta 5432).

2.  **Proteção DDoS:**
    - *Melhoria:* Avaliar o **Azure DDoS Protection** se o serviço for crítico, para proteger contra ataques de negação de serviço volumétricos.

3.  **Bastion Host:**
    - *Melhoria:* Se precisar acessar o banco de dados manualmente para manutenção, criar um **Azure Bastion**. É uma forma segura de acessar VMs ou recursos privados via navegador, sem expor portas SSH/RDP para a internet.
