package main

# Rule to deny S3 buckets without a specific tag
deny_missing_tag {
    input.resource.type == "aws_s3_bucket"
    not input.resource.attributes.tags[_].key == "Environment"
}
