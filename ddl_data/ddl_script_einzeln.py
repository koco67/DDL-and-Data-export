from profi_control import ProfiControl
from stdArgParser import getStandardArgParser

parser = getStandardArgParser()
args = parser.parse_args()
cursor = ProfiControl(args.oracleUser, args.oraclePassword, args.saveCredentials, args.setDefaultUser)

# Specify the schema and table prefix
schema = 'PADDI'
table_prefix = 'D3_BEN'

# Function to write DDL to a text file
def write_ddl(table_name, ddl):
    with open(f"{table_name}_DDL.txt", 'w') as ddl_file:
        ddl_file.write(ddl.read())

# SQL query
sql_query = f"SELECT table_name, dbms_metadata.get_ddl('TABLE', table_name) FROM all_tables WHERE owner = '{schema}' AND table_name LIKE '{table_prefix}%'"

# Execute the SQL query using getResultTable
result_set = cursor.getResultTable(sql_query, None)

# Fetch and write DDL for each table
if result_set:
    for row in result_set:
        table_name, ddl = row
        write_ddl(table_name, ddl)
else:
    print("Error executing the SQL query.")