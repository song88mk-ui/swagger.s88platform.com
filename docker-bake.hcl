group "default" {
  targets = ["root"]
}

target "docker-metadata-action" {}

target "image" {
  inherits = ["docker-metadata-action"]
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
}

target "_common_docs" {
  dockerfile = "docker/Dockerfile.docs"
}

target "_openapi_docs" {
  dockerfile = "docker/Dockerfile.openapi"
}

target "operator-api" {
  dockerfile = "docker/Dockerfile.operator-api"
  args = {
    VERSION = "1.2.6"
  }
  target = "out"
  output = ["type=local,dest=build/operator-api"]
}

target "root" {
  dockerfile = "docker/Dockerfile.root"
  contexts = {
    operator_api = "target:operator-api"
  }
  tags = ["swagger.s88platform.com"]
}
