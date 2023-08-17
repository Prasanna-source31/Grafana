import os
import re

# Directory where your Kubernetes YAML files are located
yaml_directory = "path/to/kubernetes/yaml/files"

# Generate an OPA policy that checks for specific labels in Kubernetes YAML
def generate_opa_policy(labels):
    policy = f'''
package main

default allow = false

deny[msg] {
    input.kind = "Pod"
    {', '.join([f'not has_label("{label}")' for label in labels])}
    msg = sprintf("Pod is missing required labels: {labels}")
}
    '''
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
