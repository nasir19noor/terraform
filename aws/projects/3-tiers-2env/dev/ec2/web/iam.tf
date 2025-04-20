resource "aws_iam_role" "dev_web_role" {
  name = "dev_web_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com" # Adjust this according to your needs
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dev_web_attach_policy" {
  role       = aws_iam_role.dev_web_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "dev_web_attach_policy_2" {
  role       = aws_iam_role.dev_web_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess" 
}

resource "aws_iam_role_policy_attachment" "dev_web_attach_policy_3" {
  role       = aws_iam_role.dev_web_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess" 
}

resource "aws_iam_instance_profile" "dev_web_profile" {
  name = "dev_web_profile"
  role = "${aws_iam_role.dev_web_role.name}"
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
    },
    {
            "Effect": "Allow",
            "Action": [
                "ssm:*",
                "ec2:describeInstances",
                "iam:ListRoles"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:PassedToService": "ssm.amazonaws.com"
                }
            }
        }
  ]
}
EOF
}