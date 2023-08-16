package main

default deny = false

deny {
    not input.resource.type == "aws_instance"
}

deny {
    input.resource.type == "aws_instance"
    not input.resource.attributes.tags[_].key == "Environment"
}

deny {
    input.resource.type == "aws_instance"
    not input.resource.attributes.tags[_].key == "Owner"
}
