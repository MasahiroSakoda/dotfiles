### 🩺 Scope

This policy applies to global environment, including but not limited to:

- All source code, in all repositories associated with the project.
- All project data, including user data, configuration data, and metadata.
- All systems and infrastructure used to develop, test, and deploy the project.
- All individuals contributing to the project, including core team members, external contributors, and third-party vendors.

### 🔒️ Security Principles

Adhere to the following security principles:

- **Secure Secrets**: NEVER hardcode API keys, tokens, credentials, or any sensitive informations
- **Validate Commit**: NEVER commit API keys, tokens, credentials, or any sensitive informations

### 🔐 Secure Development Lifecycle (SDLC)

- **Secure Coding**: All code should be written in accordance with secure coding best practices, such as those outlined in the [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- **Code Review**: All code changes must be reviewed for security vulnerabilities before being merged into the main branch.
- **Dependency Management**: All third-party dependencies must be scanned for known vulnerabilities.
- **Security Testing**: Perform regular security testing, including static application security testing (SAST), dynamic application security testing (DAST), and penetration testing.
