#!/bin/bash

counter=1
while [ $counter -le 6 ]
do
	echo Creating zad_$counter/
	mkdir zad_$counter/
	mkdir zad_$counter/img/
	touch zad_$counter/zad_$counter.m
	git add zad_$counter/.
	((counter++))
done
git commit -m 'auto create folders'
echo All done