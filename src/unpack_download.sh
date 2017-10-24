START_TIME=$SECONDS

mkdir ../data/down/

# unzip download log
for f in ../data/raw/*_down.log.tar.gz
do
 echo "Processing $f"
 f_dir=$(grep -o '[^/]*$' <<< $f)
 mkdir ${f_dir}.tmpdir
 tar -xvzf $f -C ${f_dir}.tmpdir/
 f_new=$(sed 's/.tar.gz//g' <<< $f_dir)
 mv ${f_dir}.tmpdir/* ../data/down/${f_new}
done

echo "All log.tar.gz file have been unzipped."
echo ""

rm -rf *tmpdir

echo "The total number of download log file is: "
ls ../data/down/ | wc -l
echo ""

echo -e "Start cleaning the download log file.\n"
# append file_name to each row (will be used for date)
for f in ../data/down/*.log
do
 echo "Processing $f"
 gawk -f unpack_download.awk $f >> ../data/all_down.log.fn
done

rm -rf ../data/down/

echo -e "\nFinished..."
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "It took $ELAPSED_TIME seconds to unpack down data."
