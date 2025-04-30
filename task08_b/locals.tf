locals {
  name_prefix = "cmtr-57d8b090-mod8b"
  creator_tag = "Creator=shashwat_swaraj@epam.com"

  # Resource names
  rg_name        = "${local.name_prefix}-rg"
  aca_name       = "${local.name_prefix}-ca"
  aca_env_name   = "${local.name_prefix}-cae"
  acr_name       = replace("${local.name_prefix}cr", "-", "")
  aks_name       = "${local.name_prefix}-aks"
  kv_name        = "${local.name_prefix}-kv"
  redis_aci_name = "${local.name_prefix}-redis-ci"
  sa_name        = replace("${local.name_prefix}sa", "-", "")
}