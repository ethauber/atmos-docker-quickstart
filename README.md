# atmos-docker-quickstart

A quickstart project demonstrating Atmos patterns with Docker-based Terraform components.

## Project Structure

```
├── atmos.yaml                    # Atmos CLI configuration + workflows
├── components/terraform/         # Terraform components (reusable modules)
│   └── hello-world/              # Simple nginx container component
├── stacks/                       # Stack configurations
│   ├── catalog/                  # Base component defaults (inheritance)
│   │   └── hello-world.yaml      # Default values for hello-world
│   ├── local-test-dev.yaml       # Dev environment overrides
│   ├── local-prod-live.yaml      # Prod environment overrides
│   └── stacks.yaml               # Stack imports
```

## Key Concepts

### Component Inheritance
Components in `stacks/catalog/` define base defaults. Environment stacks (`local-test-dev.yaml`, `local-prod-live.yaml`) import and override only what's different. This follows the DRY principle.

### Naming Pattern
Stacks use the pattern `{tenant}-{environment}-{stage}`:
- `local-test-dev` → tenant=local, environment=test, stage=dev
- `local-prod-live` → tenant=local, environment=prod, stage=live

---

## Quick Commands

### Individual Stack Operations

```bash
# Plan a specific stack
atmos terraform plan hello-world -s local-test-dev

# Apply to dev
atmos terraform apply hello-world -s local-test-dev

# Apply to prod
atmos terraform apply hello-world -s local-prod-live

# Destroy a stack
atmos terraform destroy hello-world -s local-test-dev
```

---

## Workflows

Workflows are reusable command sequences defined in `atmos.yaml`. They simplify common multi-step operations.

### List Available Workflows

```bash
atmos workflow --help
```

### Available Workflows

| Workflow | Description | Command |
|----------|-------------|---------|
| `plan-all` | Plan across all environments | `atmos workflow plan-all` |
| `deploy-dev` | Deploy to dev only | `atmos workflow deploy-dev` |
| `deploy-prod` | Deploy to prod only | `atmos workflow deploy-prod` |
| `deploy-all` | Deploy to all (dev → prod) | `atmos workflow deploy-all` |
| `destroy-all` | Teardown all environments | `atmos workflow destroy-all` |
| `status` | Show outputs from all stacks | `atmos workflow status` |

### Example: Full Deployment Pipeline

```bash
# 1. See what will change in all environments
atmos workflow plan-all

# 2. Deploy everything (dev first, then prod)
atmos workflow deploy-all

# 3. Check the deployed URLs
atmos workflow status
```

### Example: Safe Teardown

```bash
# Destroys prod first, then dev (reverse deployment order)
atmos workflow destroy-all
```

---

## Ports

| Environment | Port | URL |
|-------------|------|-----|
| Dev (local-test-dev) | 8081 | http://localhost:8081 |
| Prod (local-prod-live) | 9090 | http://localhost:9090 |