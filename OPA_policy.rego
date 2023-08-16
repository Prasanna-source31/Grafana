package main

# Rule to deny resources missing an "Environment" tag
deny_missing_environment_tag {
    resource_tags := input.resource.attributes.tags[_]
    input.resource.type == "aws_instance"
    not contains(resource_tags, {"key": "Environment", "value": _})
}

# Rule to deny resources missing an "Owner" tag
deny_missing_owner_tag {
    resource_tags := input.resource.attributes.tags[_]
    input.resource.type == "aws_instance"
    not contains(resource_tags, {"key": "Owner", "value": _})
}

# Rule to deny resources with an "Environment" tag that doesn't match a pattern
deny_invalid_environment_tag {
    resource_tags := input.resource.attributes.tags[_]
    input.resource.type == "aws_instance"
    env_value := resource_tags[_].value
    not (env_value =~ "^(dev|test|prod)$")
}

# Rule to deny instances with an "Owner" tag that doesn't match a pattern
deny_invalid_owner_tag {
    resource_tags := input.resource.attributes.tags[_]
    input.resource.type == "aws_instance"
    owner_value := resource_tags[_].value
    not (owner_value =~ "^[A-Za-z]+$")
}

