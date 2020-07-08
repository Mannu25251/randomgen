function dataset
{
        typeset type=""                         # the whole thing

        case $1 in
                -i)   type=int;;
                -f)   type=float;;
                -b)   type=boolean;;
                -c)   type=char;;
                -v)   type=varchar;;		
                -lv)  type=longvarchar;;
                -d)   type=date;;          
                -dt)  type=datetime;;            
                -t)   type=time1;;            
                -ts)  type=timestamp;;          
                -tsz) type=timestamptz;; 
                -it)  type=interval;;				
		-u)   type=uuid;;          
		-tz)  type=timetz;;         
                -ity)  type=ity;;
                -itym)  type=itym;;
                -itm)  type=itm;;
                -itd)  type=itd;;
                -itdh)  type=itdh;;
                -itdm)  type=itdm;;
                -itds)  type=itds;;
                -ith)  type=ith;;
                -ithm)  type=ithm;;
                -iths)  type=iths;;
                -itmi)  type=itmi;;
                -itmis)  type=itmis;;
                -its)  type=its;; 

        esac

                if [[ "$type" == "int"  ]]
                then
                        echo $(shuf -i 10-999 -n 1)
                elif [[ "$type" == "float" ]]
                then
                        prec=$(echo $((10**$precessionca -1)))
                        precesion=$(shuf -i 10-"$prec" -n 1)
                        sca=$(echo $((10**$scaleca -1)))
                        scale=$(shuf -i 10-"$sca" -n 1)
                        echo "'"$precesion.$scale"'" 
                elif [[ "$type" == "boolean" ]]
                then
                    echo $(shuf -i 0-1 -n 1)
                       
                elif [[ "$type" == "char" ]]
                then
                     echo "'"$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w ${2:-32} | head -n 1)"'"
                       
                elif [[ "$type" == "varchar" ]]
                then
                      echo "'"$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${2:-72} | head -n 1)"'" 
                elif [[ "$type" == "longvarchar" ]]
                then
                      echo "'"$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${2:-532} | head -n 1)"'"
                elif [[ "$type" == "date" ]]
                then
                       echo "'"$(date -d "$((RANDOM%1+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1))" '+%Y-%m-%d')"'"
                elif [[ "$type" == "time1" ]]
                then
                       echo "'"$(date -d "$((RANDOM%1+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1))" '+%H:%M:%S')"'"
                elif [[ "$type" == "datetime" ]]
                then
                       echo "'"$(date -d "$((RANDOM%1+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1))" '+%Y-%m-%d %H:%M:%S')"'"
                elif [[ "$type" == "timestamp" ]]
                then
                       echo "'"$(date -d "$((RANDOM%1+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1))" '+%Y-%m-%d %H:%M:%S')"'"
                elif [[ "$type" == "timestamptz" ]]
                then
                       echo "'"$(date -d "$((RANDOM%1+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1)).$((RANDOM%17+139161934))" '+%Y-%m-%d %H:%M:%S.%N %:z')"'" 
                elif [[ "$type" == "interval" ]]
                then
                       echo "'"$(date -d "$((RANDOM%1+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1)).$((RANDOM%17+139161934))" '+%Y-%m %H:%M:%S:%N')"'" 
                elif [[ "$type" == "uuid" ]]
                then
                       echo "'"$(uuidgen)"'"   
                elif [[ "$type" == "timetz" ]]
                then
                       echo "'"$(date -d "$((RANDOM%1+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1)).$((RANDOM%17+139161934))" '+%H:%M:%S.%N %:z')"'"
                elif [[ "$type" == "ity" ]]
                then
                      # INTERVAL YEAR
                      echo "'"$(date -d "$((RANDOM%17+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1)).$((RANDOM%17+139161934))" '+%Y')"'"
                elif [[ "$type" == "itm" ]]
                then
                      # INTERVAL MONTH
                      echo "'"$(date -d "$((RANDOM%1+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1)).$((RANDOM%17+139161934))" '+%m')"'"
                elif [[ "$type" == "itym" ]]
                then
                      # INTERVAL YEAR TO MONTH
                      echo "'"$(date -d "$((RANDOM%17+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1)).$((RANDOM%17+139161934))" '+%Y-%m')"'"
                 elif [[ "$type" == "itd" ]]
                then                     
                      # INTERVAL DAY
                      echo "'"$(date -d "$((RANDOM%1+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1)).$((RANDOM%17+139161934))" '+%d')"'"
                 elif [[ "$type" == "itdh" ]]
                then                     
                      # INTERVAL DAY TO HOUR
                      echo "'"$(date -d "$((RANDOM%1+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1)).$((RANDOM%17+139161934))" '+%d %H')"'"
                 elif [[ "$type" == "itdm" ]]
                then                     
                      # INTERVAL DAY TO MONTH
                      echo "'"$(date -d "$((RANDOM%1+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1)).$((RANDOM%17+139161934))" '+%d %M')"'"
                elif [[ "$type" == "itds" ]]
                then                      
                      # INTERVAL DAY TO SECOND
                      echo "'"$(date -d "$((RANDOM%1+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1)).$((RANDOM%17+139161934))" '+%d %S')"'"
                 elif [[ "$type" == "ith" ]]
                then                     
                      # INTERVAL HOUR
                      echo "'"$(date -d "$((RANDOM%1+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1)).$((RANDOM%17+139161934))" '+%H')"'"
                elif [[ "$type" == "ithm" ]]
                then                      
                      # INTERVAL HOUR TO MINUTE
                      echo "'"$(date -d "$((RANDOM%1+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1)).$((RANDOM%17+139161934))" '+%H:%M')"'"
                 elif [[ "$type" == "iths" ]]
                then                     
                      # INTERVAL HOUR TO SECOND
                      echo "'"$(date -d "$((RANDOM%1+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1)).$((RANDOM%17+139161934))" '+%H:%S')"'"
                 elif [[ "$type" == "itmi" ]]
                then                     
                      # INTERVAL MINUTE
                      echo "'"$(date -d "$((RANDOM%1+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1)).$((RANDOM%17+139161934))" '+%M')"'"
                elif [[ "$type" == "itmis" ]]
                then                      
                      # INTERVAL MINUTE TO SECOND
                      echo "'"$(date -d "$((RANDOM%1+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1)).$((RANDOM%17+139161934))" '+%M:%S')"'"
                elif [[ "$type" == "its" ]]
                then                      
                      # INTERVAL SECOND
                      echo "'"$(date -d "$((RANDOM%1+2019))-$((RANDOM%12+1))-$((RANDOM%28+1)) $((RANDOM%23+1)):$((RANDOM%59+1)):$((RANDOM%59+1)).$((RANDOM%17+139161934))" '+%S')"'"
                else 
                       echo "Datatype is not supported"       

						
                fi
}

export precessionca=4
export scaleca=3
export scaleca=3


# dataset -i
# dataset -i
# dataset -i  
# dataset -f  
# dataset -b  
# dataset -z  
# dataset -v  
# dataset -lv
# dataset -d  
# dataset -dt 
# dataset -t  
# dataset -ts 
# dataset -tsz
# dataset -it 
# dataset -u  
# dataset -tz 
