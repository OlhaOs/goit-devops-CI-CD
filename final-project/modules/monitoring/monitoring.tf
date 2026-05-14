resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "prometheus" {
  name             = "prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = "56.0.0" 
  namespace        = kubernetes_namespace.monitoring.metadata[0].name
  create_namespace = false
  
  values = [
    templatefile("${path.module}/values.yaml", {
      admin_password = var.grafana_admin_password
    })
  ]

  depends_on = [
    kubernetes_namespace.monitoring
  ]
  
  timeout = 300
  wait    = false
}

data "kubernetes_secret" "grafana_password" {
  metadata {
    name      = "prometheus-grafana" 
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }
  depends_on = [helm_release.prometheus]
}