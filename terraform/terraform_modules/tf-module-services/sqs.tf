resource "aws_sqs_queue" "sample_sqs" {
  name                       = "sample-sqs-${var.env}.fifo"
  fifo_queue                 = true
  visibility_timeout_seconds = 120
  message_retention_seconds  = 500

  tags {
    BusinessUnit  = "some-name"
    Application   = "${var.application}"
    "Charge Code" = "${var.charge_code}"
    Environment   = "${var.env}"
    Owner         = "${var.owner}"
  }
}

resource "aws_sqs_queue_policy" "some_sqs_policy" {
  queue_url = "${aws_sqs_queue.sample_sqs.id}"
  policy = "${data.aws_iam_policy_document.sqs_policy_document.json}"
}

data "aws_iam_policy_document" "sqs_policy_document" {
  statement {
    actions = [
      "SQS:ChangeMessageVisibility",
      "SQS:DeleteMessage",
      "SQS:GetQueueAttributes",
      "SQS:ListDeadLetterSourceQueues",
      "SQS:PurgeQueue",
      "SQS:ReceiveMessage",
      "SQS:SendMessage",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "*",
      ]
    }

    resources = [
      "${aws_sqs_queue.sample_sqs.arn}",
    ]
  }
}
