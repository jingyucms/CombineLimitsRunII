#!/bin/tcsh

foreach seed (`seq 1 51799`)
    echo $seed
    python plotTouys.py $seed
end
