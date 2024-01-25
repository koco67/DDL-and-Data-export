from profi_control import ProfiControl
from stdArgParser import getStandardArgParser

parser = getStandardArgParser()
args = parser.parse_args()
cursor = ProfiControl(args.oracleUser, args.oraclePassword, args.saveCredentials, args.setDefaultUser)


sql_query = f"SELECT table_name FROM all_tables WHERE table_name LIKE 'D3_%'"
tables = [table[0] for table in cursor.getResultTable(sql_query, None)]

# Function to write data to a text file
def write_data(table_name, rows):
    with open(f"{table_name}_data.txt", 'w') as data_file:
        for row in rows:
            data_file.write(', '.join(map(str, row)) + '\n')

# Fetch and write data for each table
for table_name in tables:
    # Use dynamic SQL to fetch all data from the table
    sql_query = f"SELECT * FROM {table_name}"
    rows = cursor.getResultTable(sql_query, None)

    # Write data to a text file
    write_data(table_name, rows)
