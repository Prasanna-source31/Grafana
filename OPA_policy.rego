package main

default deny = false

deny_instance_without_tags {
    not input.resource.type == "aws_instance"
}

deny_instance_missing_environment_tag {
    input.resource.type == "aws_instance"
    not input.resource.attributes.tags[_].key == "Environment"
}

deny_instance_missing_owner_tag {
    input.resource.type == "aws_instance"
    not input.resource.attributes.tags[_].key == "Owner"
}
