#!/bin/tcsh

foreach seed (`seq 1 10`)
    echo $seed
    ./run_GOF_allchs_grid.csh $seed >& logGOF${seed} &
end
