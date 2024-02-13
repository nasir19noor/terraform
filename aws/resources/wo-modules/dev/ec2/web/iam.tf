resource "aws_iam_role" "dev_web_role" {
  name = "dev_web_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "${var.project}-dev-web-role"
  }
}

resource "aws_iam_instance_profile" "dev_web_profile" {
  name = "dev_web_profile"
  role = "${aws_iam_role.test_role.name}"
}

resource "aws_iam_role_policy" "dev_web_policy" {
  name = "dev_web_policy"
  role = "${aws_iam_role.dev_web_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}