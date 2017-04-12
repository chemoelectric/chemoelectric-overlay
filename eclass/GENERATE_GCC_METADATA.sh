#!/bin/sh
#
# Add USE=ada to the sys-devel/gcc metadata.

gcc_dir="../sys-devel/gcc"

cd "${gcc_dir}" || {
    echo "Could not change directory to ${gcc_dir}"
    exit 1
}
fgrep -q '<flag name="ada">' metadata.xml || {
    sed -i-e 's|<use>|<use><flag name="ada">Build support for the Ada language</flag>|' metadata.xml || {
        echo "Could not edit metadata.xml"
        exit 1
    }
}
xmllint --format metadata.xml > metadata.xml.NEW || {
    echo "xmllint failed"
    exit 1
}
mv metadata.xml.NEW metadata.xml || {
    echo "mv failed"
    exit 1
}
repoman fix

exit 0

    
