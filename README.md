# randomgen
RandomGenerator - Easy Shell Tool for Random Schema and Data Generation

Inspiration:
Developers and testers need a small/large/unique volume of data in the database in order to test the features. Manually generating data is not an affordable option and sometimes tiresome too. Writing a schema will also be a time-consuming option as it takes a lot of thinking though we as a tester or developer need more uniqueness in the schema that has single to multiple occurrences of data types columns. Hence, the need for this tool came which can create a random schema with random data types or/ and random data based on the schema provided and specially in a language that is understood by most of the user "SHELL SCRIPTING"

The need for this particular tool specially for complex datatype, we didn't have much tool that generate any array type data and somewhat randomly complex and moreover user friendly. Sometimes you can rely on a small samples, but if you want to perform some testing on large datasets or if you want to test a feature that needs to produce enormous data, then you start to need more than just two or three or more occurrences of data types in a table. This tool can help in this task with the automatic generation of hundreds or thousands of items with different data types.

Most importantly, by our own experiences, when you're writing queries to test a table in a database, you'll want to make sure you're testing it under conditions that closely simulate a production environment. In production, you'll have an army of users banging away at database and filling your database with data, which puts database engine in stress. If you're hand-entering data into a test environment one record at a time, you're never going to build up the volume and variety of data that your app will accumulate in a few days in production. Worse, the data you enter will be biased towards your own usage patterns and won't match real-world usage, leaving important bugs undiscovered.

Imagine a tool that can simplify the method for generation of test data and takes away all of these problems. There are multiple reasons why this tool will be an asset for us - 

*Hassel-free: No need to worry about schema and data now. Tool will generate the most powerful schema for testing.

No existing data set available for testing: For example array data types, no available data set was present, manually creating data will take a lot of effort. 

*Test unusual cases: Test unusual cases with lot of randomness in data type and data sets

*Turnaround Time: As data and schema is ready within a few minutes, testing time would decrease like never before. 

*Usability: Any team can use this tool irrespective of knowledge about schema and data types. 

*Saves Time: A delayed product delivery is not good for any business. Most of us find problems with the time required to generate unique schema and data to perform testing especially when it is regression testing. This tool will solve this problem and maximize your testing capabilities

*Checks Quality: If setup ready, which is almost error-free then team needs to check for quality of rest of the script

*Early Bug Detection: Random schema and data is ready within a minute; everything is in your way! Log a bug!!

*Portable & Easy to maintain: Tool is portable in any Linux flavor and easy to maintain as compared to the rest of the tool available with limited capabilities.

*Improves Test Coverage: It will for sure, improve test coverage because it will do all magic for you while creating schema and generation of data.

*Manpower Utilization: This is relative to the above benefits. You know it!

*Improves Team Motivation: This is a big challenge in the testing. Distributed manpower among various features and tasks can't enable most of the folks to learn something new. Cutting down effort using this tool, improve team to focus on other interesting stuff.

*Testing Flexibility: Anyone can do Sanity or full testing if you have schema and data ready. Isn't it!

And many more...


Version                  1.0v
Release	                 Beta
Scripting Language 	     Bash Shell Scripting
Developer	               Manvendra Panwar
Support                  manvendra2525@gmail.com

*Highlight*: This tool is powered with shell scripting which generate automatic schema and data. This randomgenerator module is fragmented into 2 parts, schemagen.sh and datagen.sh

1. schemagen.sh 

        Syntax:

        ./schemagen.sh -t 4 -c 8 -d"Boolean|CHAR(32)|INTERVAL|FLOAT|numeric(8,3)|uuid"

         or                 

        ./schemagen.sh -t 4 -c 8 -d"Array[Boolean]|ARRAY[CHAR(32)]|ARRAY[INTERVAL]|ARRAY[FLOAT]|ARRAY[numeric(8,3)]|ARRAY[uuid]"

         or

        ./schemagen.sh --tables 4 --columns 8 --datatypes "Boolean|CHAR(32)|INTERVAL|FLOAT|numeric(8,3)|uuid"

        Parameters:

        -t Number of tables
        -c Number of columns in each table
        -d datatypes list ## Must be pipe seperated


        Format of schema generated:

        create table autogenerate<Number>
        (
        col0 <data type> ,
        col1 <data type> ,
        col2 <data type> ,
        col3 <data type>
        );

        Output file:- schema_<number>.sql

        Support: - All Vertica Primitive Data types
                 - All Array Data types
                 -All Set Data types


2. datagen.sh

        Note: Either you can use schema file generated from schemagen.sh or you can use your independent schema

         Syntax: ./datagen.sh -fschema_1591538597.sql -r10 -lc 

        or

        ./datagen.sh --file schema_1591616769.sql --rows 10 --load copy

        Parameters:

        -f your schema file
        -r number of rows
        -l load type of output # i for insert and c for copy or you can write "insert" or "copy" 



        Format of schema needed:

        create table autogenerate<Number>
        (
        col0 <data type> ,
        col1 <data type> ,
        col2 <data type> ,
        col3 <data type>
        );


        Note: If you have your own schema, it will do the magic!

        Outputfile: <tablename>.dat

        Support: - All Vertica Primitive Data types except BINARY, VARBINARY, GEOMETRY & GEOGRAPHY
                 - All Array Data types expect ARRAY[BINARY] & ARRAY [VARBINARY]

List of Data Types Supported: 

Data Types	Limitation
REAL	
INTEGER	
INT	
BIGINT	
SMALLINT	
TINYINT	
BOOLEAN	
CHAR	Size should be 32
VARCHAR	Data Generated is of size 72 
LONG VARCHAR	Data Generated is of size 572
UUID	
INTERVAL	
INTERVAL DAY	
INTERVAL DAY TO HOUR	
INTERVAL DAY TO MINUTE	
INTERVAL DAY TO SECOND	
INTERVAL HOUR	
INTERVAL HOUR TO MINUTE	
INTERVAL HOUR TO SECOND	
INTERVAL MINUTE	
INTERVAL MINUTE TO SECOND	
INTERVAL MONTH	
INTERVAL SECOND	
INTERVAL YEAR	
INTERVAL YEAR TO MONTH	
TIME	
TIMETZ	
TIMESTAMP	
TIMESTAMPTZ	
DATE	
DATETIME	
FLOAT	
NUMERIC	
DECIMAL	
DOUBLE	
Array[Boolean]	
Array[Char]	
Array[Date]	
Array[Float8]	
Array[Int8]	
Array[Interval Day to Hour]	
Array[Interval Day to Minute]	
Array[Interval Day to Second]	
Array[Interval Day]	
Array[Interval Hour to Minute]	
Array[Interval Hour to Second]	
Array[Interval Hour]	
Array[Interval Minute to Second]	
Array[Interval Minute]	
Array[Interval Month]	
Array[Interval Second]	
Array[Interval Year to Month]	
Array[Interval Year]	
Array[Numeric]	
Array[TimeTz]	
Array[Time]	
Array[TimestampTz]	
Array[Timestamp]	
Array[Uuid]	
Array[Varchar]	

