#!/bin/bash


MINIX_HTTP="https://www.minix-vmd.org/cgi-bin/raw/pub/minix/2.0.4/i386/"
ROOT="https://www.minix-vmd.org/cgi-bin/raw/pub/minix/2.0.0/i386/ROOT"
USR="https://www.minix-vmd.org/cgi-bin/raw/pub/minix/2.0.0/i386/USR"
USR_TAZ="https://www.minix-vmd.org/pub/minix/2.0.0/i386/USR.TAZ"

IMAGES_DIR="images"
        
create_images() {
    # Merging ROOT and USR
    cat "${IMAGES_DIR}"/ROOT.MNX "${IMAGES_DIR}"/USR.MNX >"${IMAGES_DIR}"/install-minix2.0.4.img
    # Creating the instalation floppies
    dd if=USR.TAZ of=install-minix2.0.4-usr.taz-0.img bs=1440k count=1 skip=0
    dd if=USR.TAZ of=install-minix2.0.4-usr.taz-1.img bs=1440k count=1 skip=1
    dd if=USR.TAZ of=install-minix2.0.4-usr.taz-2.img bs=1440k count=1 skip=2
    # Appending files at the end of the third disk image in order to let it have the standard size of 1.44MB
    dd if=/dev/zero of=install-minix2.0.4-usr.taz-2.img bs=1 count=`expr 1474560 - 776267` oflag=append conv=notrunc status=noxfer 2> /dev/null
}

[ ! -d images ] && mkdir "${IMAGES_DIR}"
    if [[ -e urls ]]; then
        echo "Downling Minix img files..."
        wget -i urls -qc -P "${IMAGES_DIR}/"
    else
        echo "urls file was not found..."
        exit 1
    fi
create_images
