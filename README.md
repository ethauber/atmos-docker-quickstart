# atmos-docker-quickstart
To run a Terraform plan using Atmos with the local-test-dev stack, use the following command:

```
atmos terraform plan hello-world -s local-test-dev
```

To apply the Terraform configuration using Atmos with the local-test-dev stack, use the following command:

```
atmos terraform apply hello-world -s local-test-dev
```

To apply the Terraform configuration using Atmos with the local-prod-live stack, use the following command:

```
atmos terraform apply hello-world -s local-prod-live
```