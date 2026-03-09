bash
#!/bin/bash

LOG_DOSYASI="alert.log"

while IFS= read -r satir
do
    echo "$satir"
done < "$LOG_DOSYASI"
