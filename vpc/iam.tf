# Instance role
resource "aws_iam_role" "r_instance_role" {
  name                = "${var.project_name}-${var.environment}-Instance-role"
  path = "/"
  assume_role_policy  = data.aws_iam_policy_document.d_instance_assume_role_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
}

# Instance profile
resource "aws_iam_instance_profile" "r_instance_profile" {
  name = "${var.project_name}-${var.environment}-Instance_Profile"
  path = "/"
  role = aws_iam_role.r_instance_role.name
}