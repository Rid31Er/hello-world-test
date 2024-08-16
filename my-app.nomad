  # Declare variables at the job level
  variable "TAG" {
    type = string
}

job "hello-world:$TAG" {
  type = "service"

  

  group "hello-world-web" {
    count = 1

    network {
      port "web" {
        static = 3000
      }
    }

    service {
      name = "hello-world-service"
      port = "web"
      provider = "nomad"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.helloworld.rule=Host(`test3.roketinapp.com`)",
        "traefik.http.routers.helloworld.entrypoints=websecure",
        "traefik.http.routers.helloworld.service=helloworld-service",
        "traefik.http.routers.helloworld.tls=true",
        "traefik.http.routers.helloworld.tls.certresolver=roketinapp",
        "traefik.http.services.helloworld-service.loadbalancer.server.port=3000"
      ]
    }

    task "hello-world-task" {
      driver = "docker"

      config {
        image = "ridhwan31/hello-world-test:${var.TAG}"
        ports = ["web"]
      }
    }
  }
}
