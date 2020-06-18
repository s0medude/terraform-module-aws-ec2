locals {
  sg_id  = element(concat(aws_security_group.security-group-ec2.*.id, [""],), 0,)
}

resource "aws_security_group" "security-group-ec2" {
    count       = var.instance_count > 0 ? 1 : 0
    name        = format("%s-sg", var.name)
    description = var.description_sg
    vpc_id      = var.vpc_id
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(
        {
            "Name" = format("%s-", var.name)
        },
        var.tags,
        var.security_group_tags,
    )      
}

resource "aws_security_group_rule" "ingress-rule" {
    count               = var.instance_count > 0 ? length(var.security_group_ingress_rules) : 0
    type                = "ingress"
    security_group_id   = local.sg_id   
    from_port           = var.rules[var.security_group_ingress_rules[count.index]][0]
    to_port             = var.rules[var.security_group_ingress_rules[count.index]][1]
    protocol            = var.rules[var.security_group_ingress_rules[count.index]][2]
    description         = var.rules[var.security_group_ingress_rules[count.index]][3]
    cidr_blocks         = [var.rules[var.security_group_ingress_rules[count.index]][4]]
}