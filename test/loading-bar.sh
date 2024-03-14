#!/bin/bash

# Función para mostrar una barra de progreso
progress_bar() {
    local duration=$1
    local step=1
    local progress=0
    local line=""

    # Calcula el ancho de la terminal y lo divide por dos
    local terminal_width=$(($(tput cols) / 2))

    # Barra inicial completa
    local full_bar
    full_bar=$(printf '=%.0s' $(seq 1 $((terminal_width * 8 / 10))))

    # Establece el color de texto a verde
    local green_color='\e[0;32m'
    local reset_color='\e[0m'
    

    while [ $progress -le "$duration" ]; do  # Cambiado a menor o igual
        # Calcula la longitud de la barra de progreso
        local progress_length=$(( (progress * terminal_width * 8 / 10) / duration ))

        # Construye la línea de progreso
        line=$(printf "%-${progress_length}s" " ")
        line=${line// /█}
        echo -ne "\r[${green_color}${line}${reset_color}${full_bar:${progress_length}}] $(( (progress * 100) / duration ))%"

        ((progress += step))
        sleep 1
    done

}

CLEAR_LINE="\033[1A\033[2K"

# Ejemplo de uso
progress_bar 10
echo -e "$CLEAR_LINE /n"
echo -e "${CLEAR_LINE}Complete"  # Imprime el mensaje "Complete"