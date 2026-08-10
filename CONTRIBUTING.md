# Contributing

Contributions are welcome. Fork the repository, create a feature branch, make and test your changes, and submit a pull request.

## Development setup

Required tools:

- Terraform >= 1.10.0
- pre-commit
- TFLint
- terraform-docs

Run the following checks before opening a pull request:

```bash
pre-commit install
pre-commit run -a
terraform fmt -recursive -check
terraform init -backend=false
terraform validate
terraform test
```

Use Conventional Commit messages such as `feat: add alias connection support` or `fix: correct DNS group naming`.
