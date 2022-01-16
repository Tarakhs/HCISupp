WHITE='\033[0m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
RED='\033[1;31m'

format="m4a"

while [[ "$rep" != "E" || "$rep" != "e" ]]
do
    clear
    printf 'Youtube Downloader / Player by p19pana'
    echo -e '\nSelect' ${BLUE}'D'${WHITE} 'to perform a' ${BLUE}'Download'${WHITE}',' ${ORANGE}'P'${WHITE} 'to' ${ORANGE}'Play'${WHITE} 'your music, or' ${RED}'E'${WHITE} 'to' ${RED}'Exit'${WHITE}': '
    read -r rep
    while [[ "$rep" != "D" && "$rep" != "d" && "$rep" != "P" && "$rep" != "p" && "$rep" != "E" && "$rep" != "e" ]]
    do
        echo -e 'Incorrect Syntax! Please select either' ${BLUE}'D'${WHITE}',' ${ORANGE}'P'${WHITE}', or' ${RED}'E'${WHITE}': '
        read -r rep
    done

    while [[ "$rep" == "D" || "$rep" == "d" ]]
    do
        clip=`xsel -ob`
        printf 'Analysing clipboard...'
        if [[ $clip == https://www.youtube.com/watch?v=* ]]
        then
            printf '\nIt looks like you have a URL already copied, would you like to download that or search for another? (U/S): '
            read -r uos
            while [[ "$uos" != "U" && "$uos" != "u" && "$uos" != "S" && "$uos" != "s" ]]
            do
                echo -e 'Incorrect Syntax! Please select either U to use or S to search: '
                read -r uos
            done

            if [[ "$uos" == "S" || "$uos" == "s" ]]
            then
                printf 'Please enter a search term: '
                read -r search
                mpsyt /$search
            else
                url=`xsel -ob`
            fi

        else
            printf '\nNo URL detected on your clipboard, simply enter a search term: '
            read -r search
            mpsyt /$search
        fi

        printf 'URL Copied!'
        printf '\nPlease provide your desired download location: '
        read -r path
        printf 'And the output name: '
        read -r filename
        echo -e '\nDownloading track to the specified path' ${GREEN}$path'\n'${WHITE}

        youtube-dl `xsel -ob` -o $HOME/$path/$filename.$format --format $format

        echo -e '\nDownload completed! Select' ${BLUE}'H'${WHITE} 'to go to the' ${BLUE}'Home Page'${WHITE}',' ${ORANGE}'P'${WHITE} 'to' ${ORANGE}'Play'${WHITE} 'the track you just downloaded, or' ${RED}'E'${WHITE} 'to' ${RED}'Exit'${WHITE}': '
        read -r rep
        while [[ "$rep" != "H" && "$rep" != "h" && "$rep" != "P" && "$rep" != "p" && "$rep" != "E" && "$rep" != "e" ]]
        do
            echo -e 'Incorrect Syntax! Please select either' ${BLUE}'H'${WHITE}',' ${ORANGE}'P'${WHITE}', or' ${RED}'E'${WHITE}': '
            read -r rep
        done
        break
    done
    while  [[ "$rep" == "P" || "$rep" == "p" ]]
    do
        if [ -z "$path" ]
        then
            printf 'Which folder would you like to play music from?: '
            read -r path
        fi
        nvlc $HOME/$path
        rep="H"
    done
    while [[ "$rep" == "E" || "$rep" == "e" ]]
    do
        exit 1
    done

done
