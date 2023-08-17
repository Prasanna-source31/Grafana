import os
import re

# Directory where your Terraform configuration files are located
tf_directory = "path/to/terraform/files"

# Generate an OPA policy that checks for specific attributes in Terraform resources
def generate_opa_policy(attributes):
    policy = '''
package main

default allow = false

deny[msg] {
    some resource
    input.resource.type = resource
    %s
    msg = sprintf("Resource is missing required attributes: %s", [missing_attributes])
}
    ''' % (', '.join([f'not has_attribute(resource, "{attr}")' for attr in attributes]),
           ', '.join(attributes))
    return policy

# Check if a label exists in a YAML file
def has_label(label):
    label_pattern = re.compile(rf'\b{label}\s*:')
    for root, _, files in os.walk(yaml_directory):
        for file in files:
            if file.endswith('.yaml'):
                file_path = os.path.join(root, file)
                with open(file_path, 'r') as f:
                    content = f.read()
                    if label_pattern.search(content):
                        return True
    return False

def main():
    required_labels = ["app", "environment"]
    opa_policy = generate_opa_policy(required_labels)
    
    with open('OPA_policy.rego', 'w') as f:
        f.write(opa_policy)
    
    print("OPA policy generated successfully.")

if __name__ == "__main__":
    main()
