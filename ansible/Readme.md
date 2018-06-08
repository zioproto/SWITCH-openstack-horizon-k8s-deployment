# Ansible Playbook to Deploy Horizon on top of a Kubernetes cluster

This playbook requires ansible to be at least at version `2.6.0rc1`

    sudo pip install ansible==2.6.0rc1

Create a vault password

    echo yoursecret > vault_password

Check that you are talking to the right cluster

    kubectl config get-contexts

Modify the variables of the playbook

    vim vars.yaml

Run the playbook

    ansible-playbook main.yaml


