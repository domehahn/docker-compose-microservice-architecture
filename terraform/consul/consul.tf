resource "consul_service" "keycloak" {
  name = "keycloak"
  node = "${consul_node.compute.name}"
  tags = ["identity", "authentication"]

  check {
    check_id                          = "service:keycloak"
    name                              = "Keycloak health check"
    status                            = "passing"
    http                              = "http://keycloak:9999/health/ready"
    tls_skip_verify                   = true
    interval                          = "5s"
    timeout                           = "1s"
  }
}

resource "consul_node" "compute" {
  name    = "compute-keycloak"
  address = "keycloak"
}

resource "consul_keys" "write" {

  key {
    path  = "config/api-gateway,zone1/data"
    value = <<EOT
spring:
  cloud:
    consul:
      discovery:
        instanceZone: zone1
        register: false
        registerHealthCheck: false
        tags: zone=zone1
    gateway:
      discovery:
        locator:
          enabled: true
      routes:
        - id: event-service
          uri: lb://event-service
          predicates:
            - Path=/event/**
          filters:
            - RewritePath=/event/(?<path>.*), /$\{path}
server:
  port: $${PORT:8080}
EOT
  }

  key {
    path  = "config/data-service,zone1/data"
    value = <<EOT
spring:
  cloud:
    consul:
      discovery:
        prefer-ip-address: true
        health-check-path: $${server.servlet.context-path:}/actuator/health
        health-check-interval: 15s
        health-check-timeout: 90s
        health-check-critical-timeout: 3m
        instanceId: "$${spring.application.name}:$${random.int[1,999999]}"
        instanceZone: zone1
server:
  port: 0
EOT
  }

  key {
    path  = "config/event-service,zone1/data"
    value = <<EOT
spring:
  cloud:
    consul:
      discovery:
        prefer-ip-address: true
        health-check-path: $${server.servlet.context-path:}/actuator/health
        health-check-interval: 15s
        health-check-timeout: 90s
        health-check-critical-timeout: 3m
        instanceId: "$${spring.application.name}:$${random.int[1,999999]}"
        instanceZone: zone1
server:
  port: 0
EOT
  }

  key {
    path  = "config/config-server,composite/data"
    value = <<EOT
spring:
  cloud:
    consul:
      discovery:
        prefer-ip-address: true
        health-check-path: $${server.servlet.context-path:}/actuator/health
        health-check-interval: 15s
        health-check-timeout: 90s
        health-check-critical-timeout: 3m
        instanceId: "$${spring.application.name}:$${random.int[1,999999]}"
        instanceZone: zone1
management:
  security:
    enabled: false
  endpoints:
    web:
      exposure:
        include: "*"
  tracing:
    enabled: true
    sampling:
      probability: 1.0
  otlp:
   tracing:
    endpoint: http://jaeger:4318/v1/traces
EOT
  }

  key {
    path  = "config/backend-service"
    value = <<EOT
micronaut:
  server:
    port: -1
  router:
    static-resources:
      swagger:
        paths: classpath:META-INF/swagger
        mapping: /swagger/**
endpoints:
  info:
    enabled: true
    sensitive: false
  prometheus:
    sensitive: false
consul:
  client:
    registration:
      enabled: true
EOT
  }

  key {
    path  = "config/fail-service"
    value = <<EOT
rabbitmq-host: localhost
rabbitmq-port: 15672
rabbitmq-username: guest
rabbitmq-password: guest
quarkus:
  http:
    port: 0
EOT
  }
}