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
               
    curl -sL https://git.io/file-transfer | sh

    zip -r "$ZIP_NAME"-Aonly-"$sourcever2"-"$date2"-amyGSI.zip *-Aonly-*.img
    zip -r "$ZIP_NAME"-AB-"$sourcever2"-"$date2"-amyGSI.zip *-AB-*.img

    SYNC_END=$(date +"%s")
    SYNC_DIFF=$((SYNC_END - SYNC_START))
    telegram -M -C "`printenv ROM_NAME` - compression completed in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds."

    SYNC_START=$(date +"%s")
    telegram -M -C "`printenv ROM_NAME` - starting upload..."

    echo "::set-env name=DOWNLOAD_A::$(./transfer $MIR "$ZIP_NAME-Aonly-$sourcever2-$date2-amyGSI.zip" | grep -o -P '(?<=Download Link: )\S+')"
    echo "::set-env name=DOWNLOAD_AB::$(./transfer $MIR "$ZIP_NAME-AB-$sourcever2-$date2-amyGSI.zip" | grep -o -P '(?<=Download Link: )\S+')"

    echo "::set-env name=MIRROR_A::$(./transfer $MIR2 "$ROM-AB-$sourcever2-$date2-ErfanGSI.7z" | grep -o -P '(?<=Download Link: )\S+')"
    echo "::set-env name=MIRROR_AB::$(./transfer $MIR2 "$ROM-AB-$sourcever2-$date2-ErfanGSI.7z" | grep -o -P '(?<=Download Link: )\S+')

    SYNC_END=$(date +"%s")
    SYNC_DIFF=$((SYNC_END - SYNC_START))
    telegram -M -C "`printenv ROM_NAME` - upload completed in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds."
