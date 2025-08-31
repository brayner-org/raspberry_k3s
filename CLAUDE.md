# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This repository contains infrastructure-as-code for deploying a K3s Kubernetes cluster on Raspberry Pi with Home Assistant and supporting services. The project uses Ansible for configuration management and Just for task automation.

### Core Components
- **K3s**: Lightweight Kubernetes distribution optimized for Raspberry Pi
- **Home Assistant**: Home automation platform deployed as a StatefulSet
- **Longhorn**: Distributed storage system for persistent volumes
- **Ingress-NGINX**: Ingress controller (replaces default Traefik)
- **Cloudflare Operator**: For external access via Cloudflare tunnels
- **Music Assistant**: Music server integration
- **VS Code Server**: Web-based code editor for Home Assistant configuration

## Common Commands

### Build and Deploy
```bash
# Full deployment (K3s + Home Assistant)
just deploy

# Deploy only Home Assistant (requires existing K3s)
just deploy-home-assistant-only

# Test K3s connectivity
just test

# Destroy infrastructure
just destroy

# Setup development environment
just setup
```

### Ansible Direct Commands
```bash
# Run specific playbook tags from ansible directory
cd ansible
ansible-playbook playbooks/main.yml --tags deploy
ansible-playbook playbooks/main.yml --tags deploy-homeassistant
ansible-playbook playbooks/main.yml --tags destroy
```

### Kubernetes Access
```bash
# Use the generated kubeconfig
kubectl --kubeconfig output/k3s.yaml get nodes
kubectl --kubeconfig output/k3s.yaml get pods -A
```

## Project Structure

### Configuration Flow
1. **Environment Variables**: All configuration starts in `.env` file (see `.env.example`)
2. **Ansible Variables**: Environment variables are loaded into `ansible/inventory/group_vars/all.yml`
3. **Role Execution**: Main playbook (`ansible/playbooks/main.yml`) orchestrates roles with tags
4. **Template Rendering**: Jinja2 templates in `roles/*/templates/` generate Kubernetes manifests

### Key Ansible Roles
- **base**: System preparation and dependencies
- **k3s**: K3s installation, Helm setup, storage configuration, ingress controller
- **home_assistant**: Deploy Home Assistant, HACS, VS Code Server, Music Assistant
- **destroy**: Teardown infrastructure

### Important Configuration Files
- `.justfile`: Task automation commands with colored output helpers
- `ansible/ansible.cfg`: Ansible configuration with SSH optimizations
- `ansible/inventory/hosts.ini`: Dynamic inventory using environment variables
- `output/k3s.yaml`: Generated kubeconfig with corrected IPs and cluster names

## Deployment Process

The deployment creates:
1. K3s cluster with metrics-server
2. Longhorn storage with basic auth (accessible at `http://longhorn.lan`)
3. Home Assistant with persistent storage (accessible at configured INGRESS_FQDN)
4. Cloudflare tunnel for external access
5. VS Code Server for configuration editing
6. Music Assistant for media services

## Security Considerations
- Private SSH keys are base64 encoded in environment variables
- Cloudflare API tokens should be restricted per documentation
- Basic auth protects Longhorn UI
- VS Code Server requires password authentication