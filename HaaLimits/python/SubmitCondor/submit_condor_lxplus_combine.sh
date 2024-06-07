#!/bin/bash

export HMASS=125
#export CHANNEL=TauMuTauE
#export CHANNEL=TauHadTauHad_2016_2017_2018
                                         
export PREFIX=mmmt_mm_h_parametric_unbinned


#export CHANNEL=allchs_2018
export CHANNEL=allchs


for wp in MVAMedium
do    
    export WP=$wp
    for r in lowmass upsilon highmass
    #for r in highmass
    do
	export MREGION=$r
	echo $MREGION
	if [[ $MREGION == lowmass ]]
	then
	    for m in `seq 3.6 0.1 8.5`
	    do
		export AMASS=$m
		echo Arguments: $HMASS $AMASS $MREGION $CHANNEL 
		condor_submit condor_lxplus_combine.sub 
		done
	fi
	if [[ $MREGION == upsilon ]]
	then
	    for m in `seq 6 0.1 14`
	    do
		export AMASS=$m
		echo Arguments: $HMASS $AMASS $MREGION $CHANNEL 
		condor_submit condor_lxplus_combine.sub 
	    done
	fi
	if [[ $MREGION == highmass ]]
	then
	    for m in `seq 11 0.1 21`
	    do
		export AMASS=$m
		echo Arguments: $HMASS $AMASS $MREGION $CHANNEL
		condor_submit condor_lxplus_combine.sub 
	    done
	fi
    done
done






