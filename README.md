# Diseño de Base de Datos (SQL)

## Configuracion SQLServer en MacOS
```bash
docker run -e "ACCEPT_EULA=1" -e "MSSQL_SA_PASSWORD=MyStrongPass123" -e "MSSQL_PID=Developer" -e "MSSQL_USER=SA" -p 1433:1433 -d --name=sql mcr.microsoft.com/azure-sql-edge
```

- Server: localhost
- User Name: SA
- Password: MyStrongPass123
- Port: 1433
