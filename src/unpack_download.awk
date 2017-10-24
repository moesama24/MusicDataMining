BEGIN {
  FS="\t"
  OFS="\t"
  f_name=gensub(/.*\/([^\/]*)$/, "\\1", "g", ARGV[1])
  split(f_name, f_date, "_")
}

{
  gsub(/\r|\x0F|\"/, "", $0)
  gsub(/[[:punct:]]*\([0-9\.]+\)TM/, "", $0)
  print $0, f_date[1]


}
