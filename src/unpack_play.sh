START_TIME=$SECONDS

mkdir ../data/play/

# unzip play log
for f in ../data/raw/*_play.log.tar.gz
do
  echo "Processing $f"
  f_dir=$(grep -o '[^/]*$' <<< $f)
  mkdir ${f_dir}.tmpdir
  tar -xvzf $f -C ${f_dir}.tmpdir/
  f_new=$(sed 's/.tar.gz//g' <<< $f_dir)
  mv ${f_dir}.tmpdir/* ../data/play/${f_new}
done

echo "All log.tar.gz file have been unzipped."
echo ""

rm -rf *tmpdir

cp ../data/raw/*_play.log.gz ../data/play/
gunzip ../data/play/*.gz

echo "All log.gz file have been unzipped."
echo ""

echo "The total number of play log file is: "
ls ../data/play/ | wc -l
echo ""

echo -e "Start cleaning the play log file...\n"
# append file_name to each row (will be used for date)
for f in ../data/play/*.log
do
 echo "Processing $f"
 #awk -v var="$f" '{print $0,"\t",var}' $f >> ../all_play.log.fn
 gawk -f unpack_play.awk $f >> ../data/all_play.log.fn
done

rm -rf ../data/play/

echo -e "\nFinished..."
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "It took $ELAPSED_TIME seconds to unpack play data."
