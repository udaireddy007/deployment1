
// AWS SNS
resource "aws_sns_topic" "sample_sns_topic" {
  name = "sample-sns-${var.env}"
  display_name = "SOME NAME SNS"
}

resource "aws_sns_topic_subscription" "test_topic_subscription" {
  topic_arn                       = "${aws_sns_topic.samples_sns_topic.arn}"
  confirmation_timeout_in_minutes = 5
  endpoint_auto_confirms          = true
  protocol                        = "lambda"
  endpoint                        = "arn:aws:lambda:us-west-2:${var.aws_account_number}:function:some-function--${var.env}"
}

resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn = "${aws_sns_topic.sample_sns_topic.arn}"

  policy = "${data.aws_iam_policy_document.sample_topic_policy_document.json}"
}

data "aws_iam_policy_document" "sample_topic_policy_document" {
  statement {
    actions = [
      "SNS:GetTopicAttributes",
      "SNS:SetTopicAttributes",
      "SNS:AddPermission",
      "SNS:RemovePermission",
      "SNS:DeleteTopic",
      "SNS:Subscribe",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish",
      "SNS:Receive"
    ]

    principals {
      type = "AWS"

      identifiers = [
        "*",
      ]
    }

    resources = [
      "${aws_sns_topic.sample_sns_topic.arn}",
    ]

    condition {
      test = "StringEquals"
      variable = "AWS:SourceOwner"
      values = ["${var.aws_account_number}"]
    }
  }
}


