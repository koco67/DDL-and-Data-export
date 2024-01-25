from profi_control import ProfiControl
from stdArgParser import getStandardArgParser

parser = getStandardArgParser()
args = parser.parse_args()
cursor = ProfiControl(args.oracleUser, args.oraclePassword, args.saveCredentials, args.setDefaultUser)

sql_query = f"SELECT table_name FROM all_tables WHERE table_name LIKE 'D3_%'"
tables = [table[0] for table in cursor.getResultTable(sql_query, None)]

# Function to write data to a text file
def write_data(file, table_name, columns, rows):
    file.write(f"------------------\n-- Data for Table {table_name}\n------------------\n")
    
    # Write column names
    file.write(', '.join(columns) + '\n')

    # Write data rows
    for row in rows:
        # Encode each cell using UTF-8 to handle special characters
        encoded_row = [str(cell).encode('utf-8').decode('utf-8') for cell in row]
        file.write(', '.join(encoded_row) + '\n')

output_data_path = 'O:\\022 EXIST\\200 Datenbanken\\log\\D3_tables_data.txt'

# Open a single text file to write all data with UTF-8 encoding
with open(output_data_path, 'w', encoding='utf-8') as data_file:
    # Fetch and write data for each table
    for table_name in tables:
        # Use dynamic SQL to fetch all data from the table
        sql_query_columns = f"SELECT column_name FROM all_tab_columns WHERE table_name = '{table_name}' ORDER BY column_id"
        columns = [column[0] for column in cursor.getResultTable(sql_query_columns, None)]

        sql_query_data = f"SELECT * FROM {table_name}"
        rows = cursor.getResultTable(sql_query_data, None)

        # Write data to the common text file
        write_data(data_file, table_name, columns, rows)
