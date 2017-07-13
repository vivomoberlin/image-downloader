#!/usr/bin/env bash
filename=./images.csv
download_dir=./downloads
width=800
height=800

IFS=','
while read line || [[ -n "$line" ]]; do
    echo "downloading ${line}"
    image=${line%$'\r'}
    file_name="$(cut -d'/' -f4 <<<"${line}")-$(date "+%Y.%m.%d-%H.%M.%S").jpg"
    download_file_name="${download_dir}/${file_name}"
    resize_file_name="${download_dir}/resize-${file_name}"
    curl -o ${download_file_name} ${image}
#    echo "curl ${line} -o ${download_file_name}\n" >> info.txt
#    wget ${line} -o ${download_file_name}  || rm -f ${download_file_name}
#    curl -o ${download_file_name} ${line}
#    mogrify -resize 800x800 ${resize_file_name} ${download_file_name}
#    convert ${download_file_name} -resize 800x800! ${resize_file_name}
    convert ${download_file_name} \
        -resize "${width}x${height}^" \
        -gravity Center \
        -extent "${width}x${height}" \
        ${resize_file_name}

done < "$filename"


#xargs -n 1 curl -O < ${filename}
