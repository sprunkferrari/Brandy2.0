printf "Shutting down  ... "
    		ssh 192.168.1.24 sudo shutdown -h now &> /dev/null
            if ( [ $? = 255 ] || [ $? = 0 ] ) ;
                then printf "\tSuccess\n" && break
                else printf "\tFailed. Try again? y/n ->" && exit
fi
