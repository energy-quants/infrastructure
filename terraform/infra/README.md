# The `infra` Terragrunt Project

This directory defines a Terragrunt project to deploy cloud-based
infrastructure.

Not all input variables are specified so this project acts as a template for
deploying a cloud environment. The [`../deploy`](../deploy) folder instantiates
instances of this project, injecting all required input variables to fully
specify a cloud environment.