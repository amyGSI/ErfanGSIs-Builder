#!/bin/bash
# Sync

telegram -M -C "`printenv ROM_NAME` - build started..."
SYNC_START=$(date +"%s")

sudo ./ErfanGSIs/url2GSI.sh $ROM_URL $ROM_NAME
    mkdir final

    SYNC_END=$(date +"%s")
    SYNC_DIFF=$((SYNC_END - SYNC_START))
    telegram -M -C "`printenv ROM_NAME` - Build completed in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds."

    SYNC_START=$(date +"%s")
    telegram -M -C "`printenv ROM_NAME` - compressing GSI files..."

    export date2=`date +%Y%m%d%H%M`
    export sourcever2=`cat ./ErfanGSIs/ver`
    sudo chmod -R 777 ErfanGSIs/output
               
    cd ErfanGSIs/output/
               
    sudo wget "https://github.com/00p513-dev/pdup/raw/master/pdup" -o /usr/bin

    zip -r "$ZIP_NAME"-Aonly-"$sourcever2"-"$date2"-quxngGSI.zip *-Aonly-*.img
    zip -r "$ZIP_NAME"-AB-"$sourcever2"-"$date2"-quxngGSI.zip *-AB-*.img

    SYNC_END=$(date +"%s")
    SYNC_DIFF=$((SYNC_END - SYNC_START))
    telegram -M -C "`printenv ROM_NAME` - compression completed in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds."

    SYNC_START=$(date +"%s")
    telegram -M -C "`printenv ROM_NAME` - starting upload..."
    
    pdup "$ZIP_NAME-Aonly-$sourcever2-$date2-amyGSI.zip"
    echo "::set-env name=DOWNLOAD_A::$(cat url.txt")

    pdup "$ZIP_NAME-AB-$sourcever2-$date2-amyGSI.zip"
    echo "::set-env name=DOWNLOAD_AB::$(cat url.txt")

    SYNC_END=$(date +"%s")
    SYNC_DIFF=$((SYNC_END - SYNC_START))
    telegram -M -C "`printenv ROM_NAME` - upload completed in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds."
