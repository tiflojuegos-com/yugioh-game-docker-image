#!/bin/sh

echo "loading alternative default  cdbS files"
cd /ygo

if [ -e cdb/en.cdb ]
then
echo "found a new default english cdb file"
rm locale/en/cards.cdb
cp cdb/en.cdb locale/en/cards.cdb
fi
if [ -e cdb/es.cdb ]
then
echo "found a new default spanish  cdb file"
cp cdb/es.cdb locale/es/cards.cdb
fi

if [ -e cdb/fr.cdb ]
then
echo "found a new default french cdb file"
cp cdb/fr.cdb locale/fr/cards.cdb
fi

if [ -e cdb/de.cdb ]
then
echo "found a new default german  cdb file"
cp cdb/de.cdb locale/de/cards.cdb
fi

if [ -e cdb/pt.cdb ]
then
echo "found a new default portuguese  cdb file"
cp cdb/pt.cdb locale/pt/cards.cdb
fi

if [ -e cdb/it.cdb ]
then
echo "found a new default italian  cdb file"
cp cdb/it.cdb locale/it/cards.cdb
fi

if [ -e cdb/ja.cdb ]
then
echo "found a new default japanese  cdb file"
cp cdb/ja.cdb locale/ja/cards.cdb
fi

if [ -e cdb/th.cdb ]
then
echo "found a new default thurquish  cdb file"
cp cdb/th.cdb locale/th/cards.cdb
fi

echo "finding extra cdbs files"
cd cdb

for f in en_*; do
echo "copying $f to locale/en"
# test -e $f && cp $f ../locale/en/$f
done
for f in es_*; do
echo "copying $f to locale/es"
# test -e $f && cp $f ../locale/es/$f
done

for f in fr_*; do
echo "copying $f to locale/fr"
# test -e $f && cp $f ../locale/fr/$f
done

for f in de_*; do
echo "copying $f to locale/de"
# test -e $f && cp $f ../locale/de/$f
done

for f in pt_*; do
echo "copying $f to locale/pt"
# test -e $f && cp $f ../locale/pt/$f
done

for f in it_*; do
echo "copying $f to locale/it"
# test -e $f && cp $f ../locale/it/$f
done

for f in ja_*; do
echo "copying $f to locale/ja"
# test -e $f && cp $f ../locale/ja/$f
done

for f in th_*; do
echo "copying $f to locale/th"
# test -e $f && cp $f ../locale/th/$f
done

echo "launching server"
cd /ygo
exec /ygo/venv/bin/python ygo.py $@
exit 0
