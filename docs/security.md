# Segurança (Key Vault & Identity)

## O que é?
- **Azure Key Vault:** É um cofre digital seguro. Serve para guardar senhas, chaves de API, certificados e segredos.
- **Managed Identity:** É uma identidade (usuário) para serviços do Azure. Em vez de criar um usuário/senha para sua aplicação acessar o Key Vault, damos uma "identidade" para a aplicação e damos permissão para essa identidade.

## Como está configurado?
- **Key Vault:** Criamos um cofre (`meurh360-br-kv-homolog`) para armazenar segredos do ambiente.
- **User Assigned Identity:** Criamos uma identidade (`meurh360-br-agw-identity`) para ser usada pelo Application Gateway (útil para acessar certificados SSL guardados no Key Vault).

## Dicas de Melhoria (Próximos Passos)

1.  **Acesso Privado (Private Link):**
    - *Atual:* O Key Vault tem acesso público habilitado (embora protegido por autenticação).
    - *Melhoria:* Usar **Private Endpoint** para o Key Vault. Assim, o tráfego entre sua aplicação e o cofre nunca sai da rede privada da Microsoft.

2.  **RBAC (Role Based Access Control):**
    - *Atual:* Usamos Políticas de Acesso (Access Policies).
    - *Melhoria:* Migrar para o modelo de permissão **Azure RBAC**. É mais moderno, granular e fácil de gerenciar centralizadamente.

3.  **Rotação de Chaves:**
    - *Melhoria:* Configurar rotação automática para chaves criptográficas e segredos, aumentando a segurança caso alguma credencial vaze.
