printf 'Please provide a City / Airport / IP Address / ... (or use "~" to search for a location): '
read -r city
printf '\nAvailable Forecast Detailing Options: '
printf '\n1)Short form of current weather.'
printf '\n2)Current Weather + Daily Forecast'
printf '\n3)Current Weather + 2-Day Forecast'
printf '\nPlease select the forecast you would like to get: '

read -r sel
while (($sel!=1 && $sel!=2 && $sel!=3))
do
    printf '\nIncorrect Usage! Please select the forecast you would like to get(From numbers 1-3): '
    read -r sel
done

printf '\nLastly, please specify if you would like the full form of the daily forecast or the short version (F/S): '

read -r form
while [[ "$form" != "F" && "$form" != "f" && "$form" != "S" && "$form" != "s" ]]
do
    printf '\nIncorrect Usage! Please select Full or Short form (Using F/S): '
    read -r form
done

clear

case $form in
    F | f)
        echo -n 'Full '
    ;;
    S | s)
        echo -n 'Short '
    ;;
esac

echo 'Weather Report for chosen location:' $city | tr '~' ' '
let "sel--"

case $form in
    F | s)
        curl wttr.in/$city?F?Q?$sel
    ;;
    S | s)
        curl wttr.in/$city?F?Q?$sel?n
    ;;
esac

