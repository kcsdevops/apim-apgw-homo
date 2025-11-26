# Monitoramento (Log Analytics & App Insights)

## O que é?
- **Log Analytics Workspace:** É um grande banco de dados de logs. Todos os recursos (rede, banco, containers) enviam seus diagnósticos para cá.
- **Application Insights:** Focado na aplicação (código). Monitora performance, erros 500, lentidão no banco de dados e experiência do usuário.

## Como está configurado?
- **Integração:** O Container App Environment já está configurado para enviar logs para o Workspace.
- **Retenção:** Configurada para 30 dias (custo-benefício para homologação).

## Dicas de Melhoria (Próximos Passos)

1.  **Alertas Inteligentes:**
    - *Melhoria:* Criar regras de alerta. Ex: "Me avise por e-mail se a CPU passar de 80%" ou "Me avise se a taxa de erros 500 for maior que 1%".

2.  **Dashboards:**
    - *Melhoria:* Criar Dashboards no Azure Monitor para visualizar a saúde do sistema em tempo real (gráficos de requisições, latência, etc.).

3.  **Mapa de Aplicação:**
    - *Melhoria:* Usar o "Application Map" do App Insights para ver visualmente as dependências do seu sistema e onde estão os gargalos de performance.
