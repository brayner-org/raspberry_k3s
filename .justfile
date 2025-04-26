set export
set dotenv-filename := '.env'
set dotenv-load

RED := '\033[0;31m'
GREEN := '\033[0;32m'
YELLOW := '\033[1;33m'
BLUE := '\033[0;34m'
NC := '\033[0m'


@_default:
  just --list

# Deploy the k3s infra and home assistant
@deploy:
  just _info "Deploying..."
  cd ansible && \
    ansible-playbook playbooks/main.yml --tags deploy

# Destroy all the infrastructure
@destroy:
  just _warn "Destroying..."
  cd ansible && \
    ansible-playbook playbooks/main.yml --tags destroy

# Test k8s connectivity
@test:
  kubectl top nodes --kubeconfig output/k3s.yaml

# Setup pre-commit
@setup:
  just _info "Installing pre-commit..."
  brew install pre-commit
  pre-commit install

_info MESSAGE:
  #!/usr/bin/env bash
  echo -e "${GREEN}[INFO]${NC} {{MESSAGE}}"
_warn MESSAGE:
  #!/usr/bin/env bash
  echo -e "${YELLOW}[WARNING]${NC} {{MESSAGE}}"
_debug MESSAGE:
  #!/usr/bin/env bash
  echo -e "${BLUE}[WARNING]${NC} {{MESSAGE}}"
_error MESSAGE:
  #!/usr/bin/env bash
  echo -e "${RED}[ERROR]${NC} {{MESSAGE}}"
  exit 1
