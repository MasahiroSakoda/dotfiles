# SQL Rules

- **Encoding**: Always Use UTF-8 (Use `utf8mb4` for [`MySQL`](https://www.mysql.com/) typically)
- **Database Engine**: Use [`PostgreSQL`](https://www.postgresql.org/) as default unless explicitly requested.

## General Instructions

1. **Clarify Task**: ALWAYS ask for clarification rather than making assumptions.
2. **Safety First**: Identify dangerous operations (DELETE/UPDATE without WHERE, DROP statements)
3. **Performance Analysis**: Check for query optimization opportunities, indexing needs, and anti-patterns
4. **Security Review**: Look for SQL injection risks, privilege escalation, and data exposure
5. **Standards Compliance**: Verify naming conventions, code formatting, and team standards
6. **Database-Specific**: Apply database engine specific optimizations (PostgreSQL, MySQL)

## Important Instructions
- Data safety (backup requirements, WHERE clause validation)
- Query performance (index usage, joins vs subqueries, SELECT *)
- Security vulnerabilities (dynamic SQL, injection risks)
- Naming conventions and maintainability
- Database-specific best practices

## Commonly Used Extensions

If you have complex task for SQL, consider to use following extensions and then explain how to use it.

### PostgreSQL

#### Official extensions
- **Execution Stats**: [`pg_stat_statements`](https://www.postgresql.org/docs/current/pgstatstatements.html)
- **UUID Generator**: [`uuid-ossp`](https://www.postgresql.org/docs/current/uuid-ossp.html)
- **Key/Value Datatype**: [`hstore`](https://www.postgresql.org/docs/current/hstore.html)
- **Hierarchical Datatype**: [`ltree`](https://www.postgresql.org/docs/current/ltree.html)
- **Integer Array**: [`intarray`](https://www.postgresql.org/docs/9.1/intarray.html)
- **Cryptography**: [`pgcrypto`](https://www.postgresql.org/docs/current/pgcrypto.html)
- **Fuzzy Search**: [`fuzzystrmatch`](https://www.postgresql.org/docs/current/fuzzystrmatch.html)
- **SQL Procedural Language**: [`PL/pgSQL`](https://www.postgresql.org/docs/current/plpgsql.html)

#### Thirdparty extensions
- **Vector Similarity Search**: [`pgvector`](https://github.com/pgvector/pgvector)
- **Geographical Data**: [`PostGIS`](https://postgis.net/)
