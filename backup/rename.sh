for f in *.PAS; do 
mv -- "$f" "${f%.PAS}.pas"
done
