# Terraform Modules

Each subfolder in this directory defines a Terraform module which can be used
as a building block when defining a cloud environment to deploy.

Each module should only define a single piece of infrastructure to deploy and
should consist of only a few, tightly-coupled, resources. In this way the modules
are composable and can be effectively re-used as building-blocks for multiple
different cloud environments.