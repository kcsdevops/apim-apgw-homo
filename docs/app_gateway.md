# Application Gateway (Load Balancer & WAF)

## O que é?
O **Application Gateway** é um balanceador de carga inteligente para tráfego web (HTTP/HTTPS). Ele fica na frente da sua aplicação recebendo os usuários.
Ele também possui o **WAF (Web Application Firewall)**, que protege contra ataques comuns como SQL Injection e Cross-Site Scripting (XSS).

## Como está configurado?
- **SKU:** `Standard_v2`.
- **IP Público:** Possui um IP fixo para entrada da internet.
- **Backend:** Aponta para os Container Apps.
- **Otimização:** Configurado para fazer o roteamento básico na porta 80.

## Dicas de Melhoria (Próximos Passos)

1.  **Habilitar WAF:**
    - *Atual:* SKU Standard (sem WAF ativado por padrão no código básico).
    - *Melhoria:* Mudar para SKU **WAF_v2** e ativar as regras de proteção da OWASP. Isso é crucial para segurança em produção.

2.  **HTTPS / SSL:**
    - *Atual:* Porta 80 (HTTP).
    - *Melhoria:* Configurar listeners **HTTPS (443)**. Importar o certificado SSL no Key Vault e configurar o App Gateway para usá-lo. Redirecionar todo tráfego HTTP para HTTPS automaticamente.

3.  **Autoscaling:**
    - *Melhoria:* Configurar as regras de autoscaling do próprio Gateway para lidar com picos de acesso repentinos.
