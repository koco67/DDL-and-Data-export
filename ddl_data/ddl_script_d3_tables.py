from profi_control import ProfiControl
from stdArgParser import getStandardArgParser

parser = getStandardArgParser()
args = parser.parse_args()
cursor = ProfiControl(args.oracleUser, args.oraclePassword, args.saveCredentials, args.setDefaultUser)

# Specify the schema and table prefix
schema = 'PADDI'
table_prefix = 'D3_'

def write_ddl_to_file(file_path, table_name, ddl):
    with open(file_path, 'a', encoding='utf-8') as ddl_file:
        ddl_file.write('-' * 50 + '\n')
        ddl_file.write(f'-- DDL for Table {table_name}\n')
        ddl_file.write('-' * 50 + '\n\n')
        
        # Write the CREATE TABLE statement
        ddl_file.write(ddl.read() + '\n\n')

        # Fetch and write table comment
        table_comment_query = f"SELECT comments FROM all_tab_comments WHERE table_name = '{table_name}' AND owner = '{schema}'"
        table_comment_result = cursor.getResultTable(table_comment_query, None)
        if table_comment_result:
            table_comment = table_comment_result[0][0]
            ddl_file.write(f"COMMENT ON TABLE \"{table_name}\" IS '{table_comment}';\n")

        # Fetch and write column comments
        comments_query = f"SELECT column_name, comments FROM all_col_comments WHERE table_name = '{table_name}' AND owner = '{schema}'"
        comments_result = cursor.getResultTable(comments_query, None)
        for comment_row in comments_result:
            column_name, comment_text = comment_row
            ddl_file.write(f"COMMENT ON COLUMN \"{table_name}\".\"{column_name}\" IS '{comment_text}';\n")

        # Fetch and write indexes
        indexes_query = f"SELECT index_name, dbms_metadata.get_ddl('INDEX', index_name) FROM all_indexes WHERE table_name = '{table_name}' AND owner = '{schema}'"
        indexes_result = cursor.getResultTable(indexes_query, None)
        for index_row in indexes_result:
            index_name, index_ddl = index_row
            ddl_file.write(index_ddl.read() + '\n\n')

# SQL query to fetch table names
sql_query = f"SELECT table_name, dbms_metadata.get_ddl('TABLE', table_name) FROM all_tables WHERE owner = '{schema}' AND table_name LIKE '{table_prefix}%'"

# Output file path
output_file_path = 'O:\\022 EXIST\\200 Datenbanken\\log\\D3_tables_DDL.txt'

# Execute the SQL query using getResultTable
result_set = cursor.getResultTable(sql_query, None)

# Fetch and write DDL for each table
if result_set:
    for row in result_set:
        table_name, ddl = row
        write_ddl_to_file(output_file_path, table_name, ddl)
else:
    print("Error executing the SQL query.")
