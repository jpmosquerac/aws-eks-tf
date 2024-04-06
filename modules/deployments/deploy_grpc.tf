resource "kubernetes_namespace" "grpc_namespace" {
  metadata {
    name = "py-grpc"
  }
}

resource "kubernetes_deployment" "grpc_deployment" {
  metadata {
    name      = "py-grpc"
    namespace = kubernetes_namespace.grpc_namespace.metadata.0.name
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "Py-gRPC"
      }
    }
    template {
      metadata {
        labels = {
          app = "Py-gRPC"
        }
      }
      spec {
        container {
          image = "grpc/python"
          name  = "py-grpc-container"
          port {
            container_port = 50051
          }
          # command = [
          #   "git clone -b v1.62.0 --depth 1 --shallow-submodules https://github.com/grpc/grpc",
          #   "cd grpc/examples/python/route_guide",
          #   "python -m grpc_tools.protoc -I../../protos --python_out=. --pyi_out=. --grpc_python_out=. ../../protos/route_guide.proto",
          #   "python -m grpc_tools.protoc -Igrpc/example/custom/path=../../protos --python_out=. --grpc_python_out=. ../../protos/route_guide.proto",
          #   "python route_guide_server.py"
          # ]
        }
      }
    }
  }
}

resource "kubernetes_service" "py-grpc-service" {
  metadata {
    name      = "py-grpc"
    namespace = kubernetes_namespace.grpc_namespace.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.grpc_deployment.spec.0.template.0.metadata.0.labels.app
    }
    type = "LoadBalancer"
    port {
      port        = 50051
      target_port = 50051
    }
  }
}