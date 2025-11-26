# Relatório de Estimativa de Custos Mensais

**Data de Geração:** 26 de Novembro de 2025
**Moeda:** BRL (Reais Brasileiros)

Este relatório apresenta uma estimativa dos custos mensais para a infraestrutura de homologação, baseada na configuração atual do Terraform.

> **Nota:** Os valores são estimativas baseadas nos preços públicos do Azure e podem variar de acordo com o uso real, região e impostos.

## Comparativo de Opções de Application Gateway

Abaixo, um comparativo de custos para auxiliar na decisão do SKU do Application Gateway. O projeto está configurado atualmente com a opção **Standard V1 Medium**.

| SKU | Custo Estimado (BRL) | Diferença | Notas |
| :--- | :--- | :--- | :--- |
| **Standard V1 Medium** (Atual) | **R$ 665,86** | - | Sem WAF. Opção mais econômica para homologação. |
| **WAF V1 Medium** | **R$ 1.198,55** | + R$ 532,69 | Com WAF. Tecnologia legada (V1). |
| **WAF V2** | **R$ 2.932,91** | + R$ 2.267,05 | Com WAF. Tecnologia atual (V2), alta performance e autoscaling. |

## Detalhamento de Custos (Configuração Atual)

```text
Project: main

 Name                                                             Monthly Qty  Unit                  Monthly Cost (BRL)   
                                                                                                                          
 module.network.azurerm_application_gateway.agw                                                                           
 ├─ Gateway usage (basic, medium)                                       1,460  hours                           R$665,86   
 └─ Data processing (0-10TB)                              Monthly cost depends on usage: R$0,00 per GB                    
                                                                                                                          
 module.apim.azurerm_api_management.apim                                                                                  
 └─ API management (developer)                                              1  units                           R$257,73   
                                                                                                                          
 module.database.azurerm_postgresql_flexible_server.psql                                                                  
 ├─ Compute (B_Standard_B1ms)                                             730  hours                           R$137,09   
 ├─ Storage                                                                32  GB                               R$37,52   
 └─ Additional backup storage                             Monthly cost depends on usage: R$0,51 per GB                    
                                                                                                                          
 module.containers.azurerm_container_registry.acr                                                                         
 ├─ Registry usage (Basic)                                                 30  days                             R$26,82   
 ├─ Storage (over 10GB)                                   Monthly cost depends on usage: R$0,54 per GB                    
 └─ Build vCPU                                            Monthly cost depends on usage: R$0,00053655 per seconds         
                                                                                                                          
 module.network.azurerm_public_ip.agw_pip                                                                                 
 └─ IP address (dynamic, regional)                                        730  hours                            R$15,67   
                                                                                                                          
 module.database.azurerm_private_dns_zone.postgres_dns                                                                    
 └─ Hosted zone                                                             1  months                            R$2,68   
                                                                                                                          
 module.monitoring.azurerm_application_insights.appi                                                                      
 └─ Data ingested                                         Monthly cost depends on usage: R$12,34 per GB                   
                                                                                                                          
 module.monitoring.azurerm_log_analytics_workspace.law                                                                    
 ├─ Log data ingestion                                    not found                                                       
 ├─ Log data export                                       Monthly cost depends on usage: R$1,07 per GB                    
 ├─ Basic log data ingestion                              Monthly cost depends on usage: R$5,37 per GB                    
 ├─ Basic log search queries                              Monthly cost depends on usage: R$0,053655 per GB searched       
 ├─ Archive data                                          Monthly cost depends on usage: R$0,21 per GB                    
 ├─ Archive data restored                                 Monthly cost depends on usage: R$1,07 per GB                    
 └─ Archive data searched                                 Monthly cost depends on usage: R$0,053655 per GB                
                                                                                                                          
 module.storage.azurerm_storage_account.st                                                                                
 ├─ Capacity                                              Monthly cost depends on usage: R$0,17 per GB                    
 ├─ Write operations                                      Monthly cost depends on usage: R$0,38 per 10k operations        
 ├─ List and create container operations                  Monthly cost depends on usage: R$0,38 per 10k operations        
 ├─ Read operations                                       Monthly cost depends on usage: R$0,0300468 per 10k operations   
 ├─ All other operations                                  Monthly cost depends on usage: R$0,0300468 per 10k operations   
 └─ Blob index                                            Monthly cost depends on usage: R$0,32 per 10k tags              
                                                                                                                          
 OVERALL TOTAL (BRL)                                                                                        R$1.143,36 

*Usage costs can be estimated by updating Infracost Cloud settings, see docs for other options.

──────────────────────────────────
21 cloud resources were detected:
∙ 9 were estimated
∙ 10 were free
∙ 2 are not supported yet, rerun with --show-skipped to see details

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━┓
┃ Project                                            ┃ Baseline cost ┃ Usage cost* ┃ Total cost ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━╋━━━━━━━━━━━━┫
┃ main                                               ┃       R$1.143 ┃           - ┃    R$1.143 ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━┛
```
