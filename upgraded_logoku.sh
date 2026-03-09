#!/bin/bash

LOG_DOSYASI="alert.log"
ONEMLI_LOG="onemli_loglar.txt"

# Önemli kelimeler listesi
ANAHTAR_KELIMELER=("WARNING" "ALERT" "ERROR")

# Daha önceki analiz dosyasını temizle
> "$ONEMLI_LOG"

while IFS= read -r satir
do
    for kelime in "${ANAHTAR_KELIMELER[@]}" # "${ANAHTAR_KELIMELER[@]}" ifadesi dizideki tüm elemanları birer birer temsil eder.Yani döngü her turda dizinin bir elemanını kelime isimli değişkene atar.
    do
        # Eğer satır anahtar kelimeyi içeriyorsa
        if [[ $satir == *"$kelime"* ]]; then #*"$kelime"* ifadesi, $satir içinde $kelime kelimesinin herhangi bir yerde geçip geçmediğini kontrol eder.* dan dolayı bunu yazdık - Bu biçim sadece [[ ... ]] içinde bu şekilde çalışır.
            echo "$satir" >> "$ONEMLI_LOG"  # $satir değişkeninde tutulan metni, $ONEMLI_LOG dosyasının sonuna ekliyor.
            break #Satırda ilk anahtar kelimeyi bulur bulmaz, break ile diğer kelimelere bakmayıp döngüyü hemen durduruyoruz.
        fi
    done
done < "$LOG_DOSYASI" #while döngüsünün içine giren kod bloğu, standart girdi (standard input) olarak belirtilen dosyadan satır satır veri okur.

echo "Analiz tamamlandı. Önemli kayıtlar $ONEMLI_LOG dosyasına yazıldı."
