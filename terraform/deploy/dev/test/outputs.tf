output "rg" {
  description = "Information about deployed resource groups."
  value = tomap({
    test = {
      "id" = module.rg-test.id,
      "name" = module.rg-test.name,
      "location" = module.rg-test.location,
    },
  })
}
