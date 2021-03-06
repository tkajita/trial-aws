/** CodeDeploy定義 */

resource "aws_codedeploy_app" "trial" {
  name = "trial"
}

//resource "aws_codedeploy_deployment_config" "trial" {
//  deployment_config_name = "trial"
//
//  minimum_healthy_hosts {
//    type  = "HOST_COUNT"
//    value = 1
//  }
//}

resource "aws_codedeploy_deployment_group" "trial" {
  deployment_group_name  = "trial"
  app_name               = "${aws_codedeploy_app.trial.name}"
  service_role_arn       = "${module.codedeploy_role.arn}"

  ec2_tag_filter {
    type  = "KEY_AND_VALUE"
    key   = "Environment"
    value = "Trial"
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type = "IN_PLACE"
  }

  load_balancer_info {
    target_group_info {
      name = "trial"
    }
  }
}