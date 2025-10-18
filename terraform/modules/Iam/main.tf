# ------------------------------------------------------------------------------
# ECS Task Execution Role
# ------------------------------------------------------------------------------
resource "aws_iam_role" "test_role" {
  name = "test_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# Attach AWS-managed ECS task execution policy
resource "aws_iam_role_policy_attachment" "test_role_policy_attachment" {
  role       = aws_iam_role.test_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ------------------------------------------------------------------------------
# Custom Inline Policy for SSM + KMS access
# ------------------------------------------------------------------------------
data "aws_caller_identity" "current" {}

resource "aws_iam_role_policy" "ecs_ssm_access" {
  name = "ecs-ssm-access"
  role = aws_iam_role.test_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowReadFromParameterStore",
        Effect = "Allow",
        Action = [
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ssm:GetParametersByPath",
          "ssm:DescribeParameters"
        ],
        Resource = "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/outline/*"
      },
      {
        Sid    = "AllowDecryptSSMParameters",
        Effect = "Allow",
        Action = [
          "kms:Decrypt"
        ],
        Resource = "*"
      }
    ]
  })
}
