# resource "kubernetes_namespace" "grpc_namespace" {
#   metadata {
#     name = "py-grpc"
#   }
# }

# resource "kubernetes_deployment" "grpc_deployment" {
#   metadata {
#     name      = "py-grpc"
#     namespace = kubernetes_namespace.grpc_namespace.metadata.0.name
#   }
#   spec {
#     replicas = 2
#     selector {
#       match_labels = {
#         app = "Py-gRPC"
#       }
#     }
#     template {
#       metadata {
#         labels = {
#           app = "Py-gRPC"
#         }
#       }
#       spec {
#         node_name = var.aws_eks_node_group_public
#         #
#         container {
#           image = "nginx:1.21.6"
#           name  = "example"

#           resources {
#             limits = {
#               cpu    = "0.5"
#               memory = "512Mi"
#             }
#             requests = {
#               cpu    = "250m"
#               memory = "50Mi"
#             }
#           }

#           liveness_probe {
#             http_get {
#               path = "/"
#               port = 80

#               http_header {
#                 name  = "X-Custom-Header"
#                 value = "Awesome"
#               }
#             }

#             initial_delay_seconds = 3
#             period_seconds        = 3
#           }
#         }
#         # container {
#         #   image = "grpc/python"
#         #   name  = "py-grpc-container"
#         #   port {
#         #     container_port = 50051
#         #   }
#         #   command = [
#         #     "git clone -b v1.62.0 --depth 1 --shallow-submodules https://github.com/grpc/grpc",
#         #     "cd grpc/examples/python/route_guide",
#         #     "python -m grpc_tools.protoc -I../../protos --python_out=. --pyi_out=. --grpc_python_out=. ../../protos/route_guide.proto",
#         #     "python -m grpc_tools.protoc -Igrpc/example/custom/path=../../protos --python_out=. --grpc_python_out=. ../../protos/route_guide.proto",
#         #     "python route_guide_server.py"
#         #   ]
#         # }
#       }
#     }
#   }
# }

# resource "kubernetes_service" "py-grpc-service" {
#   metadata {
#     name      = "py-grpc"
#     namespace = kubernetes_namespace.grpc_namespace.metadata.0.name
#   }
#   spec {
#     selector = {
#       app = kubernetes_deployment.grpc_deployment.spec.0.template.0.metadata.0.labels.app
#     }
#     type = "LoadBalancer"
#     port {
#       port        = 50051
#       target_port = 50051
#     }
#   }
# }