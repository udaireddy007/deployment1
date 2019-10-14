
// AWS SSM

resource "aws_ssm_parameter" "parameter_store" {
  name = "/some-name-${var.env}/config"
  type = "String"
  value = <<EOT
{
    "publishToSNS": true
}
EOT
}
