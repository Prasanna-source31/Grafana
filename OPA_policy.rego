package main

# Rule to deny insecure security groups
deny_insecure_security_group {
    input.resource.type == "aws_security_group"
    input.resource.attributes.ingress[_].cidr_blocks[_] == "0.0.0.0/0"
}

# Rule to deny publicly exposed resources
deny_publicly_exposed_resources {
    input.resource.attributes.public == true
}

# Rule to deny instances without required tags
deny_missing_required_tags {
    required_tags := {"Environment", "Owner"}
    resource_tags := {tag | tag = input.resource.attributes.tags[_].key}
    not required_tags { tag }
}

# Rule to deny resources with sensitive tags in clear text
deny_sensitive_tags_clear_text {
    sensitive_tags := {"password", "secret"}
    input.resource.attributes.tags[_].value = tag_value
    tag_value == sensitive_tags[_]
}

# Rule to deny S3 buckets with public access
deny_public_s3_buckets {
    input.resource.type == "aws_s3_bucket"
    input.resource.attributes.public == true
}
