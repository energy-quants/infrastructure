# Cloud Environments for Deployment

Each subfolder in this directory defines a different cloud environment to
deploy.

The environments are defined using Terragrunt and instantiate instances of
the [`../infra`](../infra) project, passing in any required parameters.

To deploy an environment, simply run `terragrunt run-all apply` in one of the
subfolders.
