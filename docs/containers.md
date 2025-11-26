# Containers (ACA & ACR)

## O que é?
- **Azure Container Apps (ACA):** Plataforma para rodar microsserviços e containers (baseada em Kubernetes, mas sem a complexidade de gerenciar um cluster Kubernetes).
- **Azure Container Registry (ACR):** É o seu "Docker Hub" privado. Onde você guarda as imagens dos seus sistemas.

## Como está configurado?
- **Ambiente (Environment):** Integrado à VNet (`aca-subnet`).
- **App:** Um container de exemplo (`hello-world`) rodando com 0.25 CPU e 0.5GB RAM.
- **Ingress:** Habilitado para receber tráfego externo (via App Gateway ou direto, dependendo da configuração final de DNS).

## Dicas de Melhoria (Próximos Passos)

1.  **Autoscaling (KEDA):**
    - *Melhoria:* Configurar regras de escala baseadas em eventos (ex: número de requisições HTTP, tamanho de fila, uso de CPU). O ACA pode escalar até zero (custo zero) quando ninguém está usando.

2.  **Integração Contínua (CI/CD):**
    - *Melhoria:* Configurar GitHub Actions ou Azure DevOps para, ao fazer um commit, construir a imagem Docker, enviar para o ACR e atualizar o Container App automaticamente.

3.  **Dapr (Distributed Application Runtime):**
    - *Melhoria:* Se a aplicação for complexa (microsserviços), habilitar o **Dapr** no ACA para facilitar a comunicação entre serviços, gerenciamento de estado e pub/sub.
