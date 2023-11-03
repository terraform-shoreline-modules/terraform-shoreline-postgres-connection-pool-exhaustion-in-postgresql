resource "shoreline_notebook" "connection_pool_exhaustion_in_postgresql" {
  name       = "connection_pool_exhaustion_in_postgresql"
  data       = file("${path.module}/data/connection_pool_exhaustion_in_postgresql.json")
  depends_on = [shoreline_action.invoke_maxconn_config]
}

resource "shoreline_file" "maxconn_config" {
  name             = "maxconn_config"
  input_file       = "${path.module}/data/maxconn_config.sh"
  md5              = filemd5("${path.module}/data/maxconn_config.sh")
  description      = "Increase the maximum number of connections allowed by the connection pool to ensure that the pool can handle the application's traffic without exhausting its resources."
  destination_path = "/tmp/maxconn_config.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_maxconn_config" {
  name        = "invoke_maxconn_config"
  description = "Increase the maximum number of connections allowed by the connection pool to ensure that the pool can handle the application's traffic without exhausting its resources."
  command     = "`chmod +x /tmp/maxconn_config.sh && /tmp/maxconn_config.sh`"
  params      = ["DATABASE_HOST","DATABASE_USER","NEW_MAX_CONNECTIONS","DATABASE_PORT","DATABASE_NAME","DATABASE_PASSWORD"]
  file_deps   = ["maxconn_config"]
  enabled     = true
  depends_on  = [shoreline_file.maxconn_config]
}

