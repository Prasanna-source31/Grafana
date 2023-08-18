package azure.terraform

default allow = false

required_tags = {
    "Environment": ["Development", "Staging", "Production"],
    "Project": ["ProjectA", "ProjectB"]
}

allow {
    input.resource.type == "Microsoft.Resources/subscriptions/resourceGroups"
    input.operation == "Microsoft.Resources/subscriptions/resourceGroups/write"
    has_required_tags(input.resource)
}

has_required_tags(resource) {
    all_tags := resource.properties.tags
    all(tag_name; tag_values) = required_tags {
        tag_name = tag_values[_]
        tag_value = all_tags[tag_name]
        tag_value == tag_values[_]
    }
}
