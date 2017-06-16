#!/bin/bash
set -euo pipefail

apt-get update
pushd /data
ansible-playbook -i environments/inventory test.yml --vault-password-file=.pass --syntax-check
ansible-playbook -i environments/inventory test.yml --vault-password-file=.pass
ansible-playbook -i environments/inventory test.yml --vault-password-file=.pass -v | grep -q 'changed=0.*failed=0' && (echo 'Idempotence test: pass' && exit 0) || (echo 'Idempotence test: fail' && exit 1)
