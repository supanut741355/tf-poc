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