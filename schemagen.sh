#!/bin/bash
#
# Mnemonic: schemagen.sh
# Abstract:    This is the main executable script which generate random tables based on your datatypes 
#              input
#
# syntax:   ./schemagen.sh -t4 -c8 -d"Array[Boolean]|Array[CHAR(32)]|Array[VARCHAR]|Array[DATETIME]|Array[TIMESTAMP]|Array[INTERVAL]||Array[numeric(8,3)]|Array[uuid]"
#
# Parms:    -t Number of tables 
#           -c Number of columns in each table
#           -d datatypes list ## Must be pipe seperated 
#
#
#
# Date:           7th June 2020
# Author:         Manvendra S Panwar
# Mod:
#
# --------------------------------------------------------------------------------------------



echo -e ""
echo -e "************************************* Read Please:************************************************" 
echo -e "||                                                                                              ||"
echo -e "|| This tool is powered with shell scripting and it will generate automatic native vertica      ||"
echo -e "|| tables and generate data based on your schema.                                               ||"
echo -e "||                                                                                              ||"
echo -e "|| It's possible sometime that all of the data types are not picked from the list of data types ||"
echo -e "|| you provided. To mitigate this, it's advisable to create more than one table.                ||"
echo -e "||                                                                                              ||"
echo -e "|| This module is fragmented into 2 parts                                                       ||"
echo -e "||                                                                                              ||"
echo -e "|| 1. schemagen.sh -> For schema generation                                                     ||"
echo -e "|| 2. datagen.sh -> To generate data based on your schema                                       ||"
echo -e "||                                                                                              ||"
echo -e "|| syntax:   ./schemagen.sh -t4 -c8 -d\"Boolean|CHAR(32)|INTERVAL|FLOAT|numeric(8,3)|uuid\"       ||"
echo -e "||                                                                                              ||"
echo -e "|| Parms:    -t Number of tables                                                                ||"
echo -e "||           -c Number of columns in each table                                                 ||"
echo -e "||           -d datatypes list ## Must be pipe seperated                                        ||"
echo -e "||                                                                                              ||"
echo -e "|| Format of schema:                                                                            ||"
echo -e "||                                                                                              ||"
echo -e "|| create table autogenerate<Number>                                                            ||"
echo -e "|| (                                                                                            ||"
echo -e "|| col0 <data type> ,                                                                           ||"
echo -e "|| col1 <data type> ,                                                                           ||"
echo -e "|| col2 <data type> ,                                                                           ||"
echo -e "|| col3 <data type>                                                                             ||"
echo -e "|| );                                                                                           ||"
echo -e "||                                                                                              ||"
echo -e "|| If your schema is not in the above format, random data will not be generated using           ||"
echo -e "|| datagen.sh. Schema generate from schemagen.sh needs no modification.                         ||"
echo -e "||                                                                                              ||"
echo -e "|| Support:                                                                                     ||"
echo -e "|| - All Vertica Primitive Data types                                                           ||"
echo -e "|| - All Array Data types                                                                       ||"
echo -e "|| - All Set Data types                                                                         ||"
echo -e "||                                                                                              ||"
echo -e "|| Outputfile: schema_<number>.sql                                                              ||"
echo -e "||                                                                                              ||"
echo -e "|| For any query reach out to manvendra2525@gmail.com                                           ||"
echo -e "||                                                                                              ||"
echo -e "|| You can say thanks to me if it adds some value to you - Manvendra                            ||"
echo -e "||                                                                                              ||"
echo -e "**************************************************************************************************"
echo -e ""

# --- Few Functions 
       argv0b=${0##*/}

      function setup_outfile
      {
        now=$(date +%s)         # filename timestamp
        export SCHEMA_OUT=${SCHEMA_OUT:-`pwd`}
        export FILE=${FILE:-${SCHEMA_OUT}/schema_"$now".sql} # use the shortest form of our script name to log under
        exec 1>>$FILE
        exec 2>&1
      }

        while [[ $1 = -* ]]
                do
        case $1 in
                -t|--tables)       ntables=$2; shift;;
                -t*|--tables*)     ntables=${1#-?};;

                -c|--columns)      columns=$2; shift;;
                -c*|--columns*)    columns=${1#-?};;

                -d|--datatypes)    datatype=$2; shift;;
                -d*|--datatypes*)   datatype=${1#-?};;

                -p|--primarykey)    primarykey=$2; shift;;
                -p*|--primarykey*)  primarykey=${1#-?};;

                        esac
                        shift
                done

    if [[ $ntables -eq 0 ]]
    then
       echo "Number of table can't be zero or empty. Exiting script.."
       exit 1
    else 
       echo "Number of tables needed are $ntables. Continue.."
    fi 

    if [[ $columns -eq 0 ]]
    then
       echo "Number of columns can't be zero or empty. Exiting script.."
       exit 1
    else
       echo "Number of columns needed are $columns. Continue.."
    fi

    if [[ -z $datatype  ]]
    then
       echo "Datatypes can't be zero. Exiting script.."
       exit 1
    else
       echo "Datatypes needed are $datatype. Continue.."
    fi

    OIFS=$IFS;
    IFS="|";
    datatypes=($datatype)
    IFS=$OIFS;
   

    setup_outfile 

    echo "--"
    echo "-- Table structure for your tests"
    echo "-- Made for your convienece"
    echo "-- You can say thank you if it's works for you. Happy Testing :) - Manvendra" 
    echo "--"
     
   checkifarray=$( echo $datatypes | grep -i ARRAY )
   for (( j=1; j <= $ntables; j++ ))
   do
     echo "create table autogenerate$j" 
     echo "("
     if [[ -n $checkifarray ]]
     then
        echo "col0 INT ,"
     fi
     for (( i=1; i <= $columns; i++ ))
     do
       randomdatatype=${datatypes[$RANDOM % ${#datatypes[@]} ]}  
       upperrandomdatatype=$(echo $randomdatatype | tr '[a-z]' '[A-Z]')
       if [[ $i == $columns ]]
       then 
          echo "col$i $upperrandomdatatype"
          echo ");"
          echo -e "\n"
       else
          if ( ( [[ $primarykey == "y" ]] || [[ $primarykey == "Y" ]] ) && [[ $i == 1 ]] )
          then
             echo "col$i $upperrandomdatatype primary key enabled ,"
          else
             echo "col$i $upperrandomdatatype ,"
          fi
       fi
     done
   done


