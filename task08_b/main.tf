# Storage module
module "storage" {
  source   = "./modules/storage"
  rg_name  = local.rg_name
  location = var.location
  sa_name  = local.sa_name
  tags     = merge(var.tags, { (local.creator_tag) = "" })
}

# Key Vault module
module "keyvault" {
  source                 = "./modules/keyvault"
  name                   = local.kv_name
  rg_name                = local.rg_name
  location               = var.location
  tenant_id              = var.tenant_id
  current_user_object_id = var.current_user_object_id
  tags                   = merge(var.tags, { (local.creator_tag) = "" })
}

# ACI Redis module
module "aci_redis" {
  source   = "./modules/aci_redis"
  rg_name  = local.rg_name
  location = var.location
  kv_id    = module.keyvault.kv_id
  tags     = merge(var.tags, { (local.creator_tag) = "" })
}

# ACR module
module "acr" {
  source         = "./modules/acr"
  name           = local.acr_name
  rg_name        = local.rg_name
  location       = var.location
  acr_image_name = var.acr_image_name
  image_tag      = var.image_tag
  blob_url       = module.storage.blob_url
  sas_token      = module.storage.sas_token
  tags           = merge(var.tags, { (local.creator_tag) = "" })
}

# AKS module
module "aks" {
  source    = "./modules/aks"
  name      = local.aks_name
  rg_name   = local.rg_name
  location  = var.location
  acr_id    = module.acr.acr_id
  kv_id     = module.keyvault.kv_id
  tenant_id = var.tenant_id
  tags      = merge(var.tags, { (local.creator_tag) = "" })
}

# ACA module
module "aca" {
  source           = "./modules/aca"
  name             = local.aca_name
  env_name         = local.aca_env_name
  rg_name          = local.rg_name
  location         = var.location
  acr_id           = module.acr.acr_id
  kv_id            = module.keyvault.kv_id
  acr_login_server = module.acr.login_server
  image_name       = var.acr_image_name
  image_tag        = var.image_tag
  redis_secrets = {
    url = module.keyvault.redis_hostname_secret_id
    pwd = module.keyvault.redis_password_secret_id
  }
  tags = merge(var.tags, { (local.creator_tag) = "" })
}

# Kubernetes deployment module
module "k8s" {
  source         = "./modules/k8s"
  aks_cluster    = module.aks.cluster
  acr_login      = module.acr.login_server
  app_image_name = var.acr_image_name
  image_tag      = var.image_tag
  kv_name        = local.kv_name
  tenant_id      = var.tenant_id
}