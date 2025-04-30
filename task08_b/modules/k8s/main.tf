provider "kubernetes" {
  host                   = var.aks_cluster.kube_config.0.host
  client_certificate     = base64decode(var.aks_cluster.kube_config.0.client_certificate)
  client_key             = base64decode(var.aks_cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(var.aks_cluster.kube_config.0.cluster_ca_certificate)
}

provider "kubectl" {
  host                   = var.aks_cluster.kube_config.0.host
  client_certificate     = base64decode(var.aks_cluster.kube_config.0.client_certificate)
  client_key             = base64decode(var.aks_cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(var.aks_cluster.kube_config.0.cluster_ca_certificate)
  load_config_file       = false
}

resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/../../k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = var.aks_cluster.kubelet_identity[0].object_id
    kv_name                    = var.kv_name
    redis_url_secret_name      = "redis-hostname"
    redis_password_secret_name = "redis-password"
    tenant_id                  = var.tenant_id
  })
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/../../k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = var.acr_login
    app_image_name   = var.app_image_name
    image_tag        = var.image_tag
  })
  depends_on = [kubectl_manifest.secret_provider]
}

resource "kubectl_manifest" "service" {
  yaml_body  = file("${path.module}/../../k8s-manifests/service.yaml")
  depends_on = [kubectl_manifest.deployment]
}

data "kubernetes_service" "app" {
  metadata {
    name = "redis-flask-app-service"
  }
  depends_on = [kubectl_manifest.service]
}