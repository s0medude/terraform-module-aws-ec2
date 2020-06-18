resource "aws_instance" "master" {
    count                       = var.instance_count
    ami                         = var.ami_id
    instance_type               = var.instance_type
    user_data                   = var.user_data
    key_name                    = var.key_name
    monitoring                  = var.monitoring    
    source_dest_check           = length(var.network_interface) > 0 ? null : var.source_dest_check
    associate_public_ip_address = var.associate_public_ip_address
    vpc_security_group_ids      = [local.sg_id]
    placement_group             = var.placement_group
    tenancy                     = var.tenancy
    iam_instance_profile        = var.iam_instance_profile
    private_ip                  = length(var.private_ips) > 0 ? element(var.private_ips, count.index) : var.private_ip
    subnet_id                   = length(var.network_interface) > 0 ? null : var.associate_public_ip_address == true ? element(
                                    distinct(compact(concat([var.public_subnet_id], var.public_subnet_ids))),
                                    count.index,) : element(distinct(compact(concat([var.private_subnet_id], var.private_subnet_ids))),
                                    count.index,)
    dynamic "root_block_device" {
        for_each = var.root_block_device
        content {
            delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
            encrypted             = lookup(root_block_device.value, "encrypted", null)
            iops                  = lookup(root_block_device.value, "iops", null)
            kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
            volume_size           = lookup(root_block_device.value, "volume_size", null)
            volume_type           = lookup(root_block_device.value, "volume_type", null)
        }
    }
    tags = merge(
        {
            "Name" = var.instance_count > 1 || var.use_num_suffix ? format("%s-%d", var.name, count.index + 1) : var.name
        },
        var.tags,
    )
    volume_tags = merge(
        {
            "Name" = var.instance_count > 1 || var.use_num_suffix ? format("%s-%d", var.name, count.index + 1) : var.name
        },
        var.volume_tags,
    )

    depends_on = [var.instance_depends_on]
}
