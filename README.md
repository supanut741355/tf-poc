```
terraform init -upgrade
```


```
terraform apply -target=module.<module_name>
```

```
terraform destroy -target=module.<module_name>
```


force run trigger (recreate)
```
terraform apply -replace="module.upload_model_to_vertex.null_resource.upload_model_to_vertex"

```

---

Module lists:

- gcs-copy: clone bucket arocess project
  
- google_vertex_ai_model: create and push model to Vertex registry
  
- google_vertex_ai_endpoint: create endpoint from model in registry
  
- google_vertext_ai_endpoint_deploy_model: deploy model
