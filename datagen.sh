#!/bin/bash
#
# Mnemonic: datagen.sh
# Abstract:    This is the main executable script which generate random data based on your schema
#
# syntax:   ./datagen.sh -f"schema_1591538597.sql" -r10 -tc
#
# Parms:    -f your schema file 
#           -n number of rows
#           -t type of output # i for insert and c for copy 
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
echo -e "|| This tool is powered with shell scripting and it will automatic generate data                ||"
echo -e "|| based on your schema.                                                                        ||"
echo -e "||                                                                                              ||"
echo -e "||                                                                                              ||"
echo -e "|| This randomgenerator module is fragmented into 2 parts                                       ||"
echo -e "||                                                                                              ||"
echo -e "|| 1. schemagen.sh -> For schema generation                                                     ||"
echo -e "|| 2. datagen.sh -> To generate data based on your schema                                       ||"
echo -e "||                                                                                              ||"
echo -e "|| syntax:   ./datagen.sh -f"schema_1591538597.sql" -r10 -tc                                      ||"
echo -e "||                                                                                              ||"
echo -e "|| Parms:    -f your schema file                                                                ||"
echo -e "||           -r number of rows                                                                  ||"
echo -e "||           -t type of output # i for insert and c for copy                                    ||"
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
echo -e "|| If your output schema is not in the above format, random data will not be generated. Schema  ||"
echo -e "|| generate from schemagen.sh needs no modification.                                            ||"
echo -e "||                                                                                              ||"
echo -e "|| Outputfile: <tablename>.dat                                                                  ||"
echo -e "||                                                                                              ||"
echo -e "|| Support:                                                                                     ||"
echo -e "|| - All Vertica Primitive Data types except BINARY, VARBINARY, GEOMETRY & GEOGRAPHY            ||"
echo -e "|| - All Array Data types expect ARRAY[BINARY] & ARRAY [VARBINARY]                              ||"
echo -e "||                                                                                              ||"
echo -e "|| For any query reach out to manvendra2525@gmail.com                                           ||"
echo -e "||                                                                                              ||"
echo -e "|| You can say thanks to me if it adds some value to you - Manvendra                            ||"
echo -e "||                                                                                              ||"
echo -e "**************************************************************************************************"
echo -e ""


#-----------------------------------------
# Data generation - Mapping
#-----------------------------------------
. randgen.sh

rm -rf *.dat

       while [[ $1 = -* ]]
                do
        case $1 in
                -f|--file)      file=$2; shift;;
                -f*|--file*)    file=${1#-?};;

                -r|--rows)      nrows=$2; shift;;
                -r*|--rows*)    nrows=${1#-?};;

                -t|--load)      load=$2; shift;;
                -t*|--load*)    load=${1#-?};;
				
                        esac
                        shift
                done

if [[ -f $file ]]
then
 echo -e "Begin magic..\n"
 echo -e "Schema file ["$file"] found. Continue.."  
 echo -e "Number of rows needed are $nrows. Continue.."
 if [[ -n $load ]]
 then
   ltype=$(echo $load | tr '[A-Z]' '[a-z]')
    echo "load type selected: $ltype. Continue.."
 else
   ltype="insert"
   echo "Choose default load type: $ltype. Continue.."
 fi
 awk 'IGNORECASE=1; /create table/ {{close (fn); fn=("F" ++i)}; n++} fn {print > fn;}' $file
 for j in $(ls -1 F*)
 do
 i=0
 while [[ $i -le $nrows ]]
 do
   ((i = i + 1))
   while read line
   do
    tableau=$(echo $line | grep -i "create table" | awk '{print $3}')
    if [[ -n $tableau ]]
    then
       fname=$tableau
    fi
    colval=$(echo $line | grep -E '^[[:space:]]?[Aa-Zz].*[[:space:]].*[Aa-Zz].*([0-9]?)' | grep -vi 'create')
    if [[ -n $colval ]]
    then
        datatype=$(echo $line | cut -f2- -d ' ' | sed 's/ //g;s/([0-9]*)//;s/,//')
        datatypefull=$(echo $line |  awk '{first = $1; $1 = ""; print $0 }' | sed 's/^[ \t]//;s/,//')
        datatypearray=$(echo $line | awk '{print $2}' | sed 's/ //' | grep ARRAY) 
        if [[ -n $datatypearray ]]
        then
           checkdenu=$(echo $line | awk '{print $2}' | sed 's/ //;s/ARRAY\[//;s/\]//' | grep -iE 'numeric|decimal' )
           if [[ -n $checkdenu ]]
           then
              scaleca=$(echo $line | awk '{print $2}' | sed 's/ //;s/ARRAY\[//;s/\]//;s/.*\(([0-9]*,[0-9]*)\)/\1/' | awk -F ',' '{print $2}' | sed 's/)//' )
              precessionext=$(echo $line | awk '{print $2}' | sed 's/ //;s/ARRAY\[//;s/\]//;s/.*\(([0-9]*,[0-9]*)\)/\1/' | awk -F ',' '{print $1}' | sed 's/(//' )
              precessionca=$( expr $precessionext - $scaleca )
              datatype=$(echo $line | awk '{print $2}' | sed 's/ //;s/ARRAY\[//;s/\]//;s/([0-9]*,[0-9]*)//' )
           else
              datatype=$(echo $line | cut -f2- -d ' ' | sed 's/ //g;s/ARRAY\[//;s/\]//;s/([0-9]*)//;s/,//' )
              datatypefull=$(echo $line | awk '{first = $1; $1 = ""; print $0 }' | sed 's/^[ \t]//;s/,//' | sed 's/ARRAY\[//;s/\]//;s/([0-9]*)//' )
           fi
           colnum=$(echo $line | awk '{print $1}' | sed 's/ //')
           mapper=$(grep -w $datatype mapperfile.txt | awk -F '=' '{print $2}')
           checktime=$(echo $datatype | grep -i 'time')
           checkdate=$(echo $datatype | grep -i 'date')
           checkuuid=$(echo $datatype | grep -i 'uuid')
           checkinterval=$(echo $datatype | grep -i 'interval')
           checknude=$(echo $datatype | grep -iE 'decimal|numeric')

           if [[ $ltype == "i" || $ltype == "insert" ]]
           then
           if [[ -n $checktime || -n $checkdate || -n $checkuuid ]]
           then
              tmp=$(echo array[$(dataset -"$mapper"),$(dataset -"$mapper"),$(dataset -"$mapper"),$(dataset -"$mapper")]::array[$datatype])
           elif [[  -n $checkinterval ]]
           then
              tmp=$(echo array[$(dataset -"$mapper"),$(dataset -"$mapper"),$(dataset -"$mapper"),$(dataset -"$mapper")]::array[$datatypefull])
           elif [[  -n $checknude ]]
           then
              tmp=$(echo array[$(dataset -"$mapper"),$(dataset -"$mapper"),$(dataset -"$mapper"),$(dataset -"$mapper")]::array["$datatype""(""$precessionext","$scaleca"")"])
           else
              tmp=$(echo array[$(dataset -"$mapper"),$(dataset -"$mapper"),$(dataset -"$mapper"),$(dataset -"$mapper")])
           fi
           else
              tmp=$(echo array[$(dataset -"$mapper"),$(dataset -"$mapper"),$(dataset -"$mapper"),$(dataset -"$mapper")])
           fi

           var=$var,$tmp
    
       else
           checkdenu=$(echo $line | awk '{print $2}' | sed 's/ //' | grep -iE 'numeric|decimal' )
           if [[ -n $checkdenu ]]
           then
              scaleca=$(echo $line | awk '{print $2}' | sed 's/ //;s/.*\(([0-9]*,[0-9]*)\)/\1/' | awk -F ',' '{print $2}' | sed 's/)//' )
              precessionext=$(echo $line | awk '{print $2}' | sed 's/ //;s/.*\(([0-9]*,[0-9]*)\)/\1/' | awk -F ',' '{print $1}' | sed 's/(//' )
              precessionca=$( expr $precessionext - $scaleca )
              datatype=$(echo $line | awk '{print $2}' | sed 's/ //;s/([0-9]*,[0-9]*)//' )
           fi
            
           colnum=$(echo $line | awk '{print $1}' | sed 's/ //')
           mapper=$(grep -w $datatype mapperfile.txt | awk -F '=' '{print $2}')
           checktime=$(echo $datatype | grep -i 'time')
           checkdate=$(echo $datatype | grep -i 'date')
           checkuuid=$(echo $datatype | grep -i 'uuid')
           checkinterval=$(echo $datatype | grep -i 'interval')
           checknude=$(echo $datatype | grep -iE 'decimal|numeric')

           if [[ $ltype == "i" || $ltype == "insert" ]]
           then
           if [[ -n $checktime || -n $checkdate || -n $checkuuid ]]
           then
              tmp=$(echo $(dataset -"$mapper")::$datatype)
           elif [[ -n $checkinterval ]]
           then
             tmp=$(echo $(dataset -"$mapper")::$datatypefull)
           elif [[  -n $checknude ]]
           then
              tmp=$(echo $(dataset -"$mapper")::"$datatype""(""$precessionext","$scaleca"")")
           else
              tmp=$(dataset -"$mapper")
           fi
           else
              tmp=$(dataset -"$mapper")
           fi

           var=$var,$tmp
        fi           
    fi
    done < $j

 if [[ $ltype == "i" || $ltype == "insert"  ]]
 then 
    echo "insert into $fname values ( $var" | sed 's/^,//g' | sed 's/$/\);/;s/( ,/(/' >> $fname.dat
 else
   echo "$var" | sed "s/^,//g;s/'//g" >> $fname.dat
 fi
  var=""
 done

echo -e ""
echo -e "Your data is almost ready. Prepared your database to import."

 if [[ $ltype == "i" || $ltype == "insert" ]]
 then
    echo "Ok! You choose insert. Your output file ["$fname".dat] has $nrows insert statements"
 else
   echo "Ok! You choose copy. Your output file ["$fname".dat] has $nrows comma seperated rows. use delimiter ','"
 fi

done

echo -e "\nOk! All Done. Did you like the magic!"

else
   echo -e "No schema file is supplied in parameter"
fi


rm -rf F*
