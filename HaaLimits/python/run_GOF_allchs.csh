#!/bin/tcsh
#setenv year 2017
#foreach channel (TauMuTauHad_V2 TauHadTauHad_V3 TauETauHad TauMuTauE TauMuTauMu)
#foreach channel (TauETauHad)
#foreach year (2016 2017 2018)
foreach year (2016)
    #setenv channel allchs
    setenv channel allchs_${year}
    #foreach region (lowmass upsilon highmass)
    foreach region (highmass)
	foreach algo (saturated)
	    if ($region == lowmass) then
		setenv amass 5.0
            else if ($region == upsilon) then
		setenv amass 11.0
            else
		setenv amass 15.0
	    endif
      
            if ($channel == TauMuTauHad_V2) then
    	    setenv channelT TauMuTauHad
    	    setenv Tfunc MVAMedium_DG_DoubleExpo_yRange_wFakeTauScaleFit_PPonly
            else if ($channel == TauHadTauHad_V3) then
    	    setenv channelT TauHadTauHad
    	    setenv Tfunc MVAMedium_DG_DoubleExpo_yRange_wFakeJECFit_PPonly
            else if ($channel == TauETauHad) then
    	    setenv channelT $channel
    	    setenv Tfunc MVAMedium_DG_yRange_wFakeTauScaleFit_PPonly
            else if ($channel == allchs) then
    	    setenv channelT $channel
    	    setenv Tfunc all
            else if ($channel == allchs_${year}) then
            setenv channelT $channel
	    setenv Tfunc all
            else
                setenv channelT $channel
        	setenv Tfunc MVAMedium_DG_wFakeTauScaleFit_PPonly
            endif
        
            setenv workDir GOF_${channelT}_${region}_${algo}
	    echo $workDir
            if ($Tfunc == all) then
        	setenv datacard mmmt_mm_h_parametric_unbinned_unblind_${region}_${channel}_hm125_amX
            else
        	setenv datacard mmmt_mm_h_parametric_unbinned_unblind_${region}_${channel}_${year}_${Tfunc}_hm125_amX
            endif
            
            rm -rf $workDir
            mkdir $workDir
            text2workspace.py -m 125 datacards_shape/MuMuTauTau/${datacard}.txt --channel-mask
            mv datacards_shape/MuMuTauTau/${datacard}.root .
            cd $workDir
	    echo combine -M GoodnessOfFit -d ../${datacard}.root --algo=${algo} -n _${channel}_${region}_${algo} -m 125 --freezeParameters MA --setParameters MA=${amass} --setParametersForFit mask_control_2016=0,mask_control_2017=0,mask_control_2018=0 --setParametersForEval mask_control_2016=1,mask_control_2017=1,mask_control_2018=1 --toysFreq
            combine -M GoodnessOfFit -d ../${datacard}.root --algo=${algo} -n _${channel}_${region}_${algo} -m 125 --freezeParameters MA,r --setParameters MA=${amass},r=-0.07 --setParametersForFit mask_control_2016=1,mask_control_2017=1,mask_control_2018=1 --setParametersForEval mask_control_2016=1,mask_control_2017=1,mask_control_2018=1 --toysFrequentist
            combine -M GoodnessOfFit -d ../${datacard}.root --algo=${algo} -n _${channel}_${region}_${algo} -m 125 --freezeParameters MA,r --setParameters MA=${amass},r=-0.07 --setParametersForFit mask_control_2016=1,mask_control_2017=1,mask_control_2018=1 --setParametersForEval mask_control_2016=1,mask_control_2017=1,mask_control_2018=1 --toysFrequentist -t 500 -s 1234 
	    #combine -M GoodnessOfFit -d ../${datacard}.root --algo=${algo} -n _${channel}_${region}_${algo} -m 125 --freezeParameters MA --setParameters MA=${amass} --setParametersForFit mask_control_2016=0,mask_control_2017=0,mask_control_2018=0 --setParametersForEval mask_control_2016=1,mask_control_2017=1,mask_control_2018=1 --toysFreq
            #combine -M GoodnessOfFit -d ../${datacard}.root --algo=${algo} -n _${channel}_${region}_${algo} -m 125 --freezeParameters MA --setParameters MA=${amass} --setParametersForFit mask_control_2016=0,mask_control_2017=0,mask_control_2018=0 --setParametersForEval mask_control_2016=1,mask_control_2017=1,mask_control_2018=1 --toysFreq -t 500 -s 1234
	    #combine -M GoodnessOfFit -d ../${datacard}.root --algo=${algo} -n _${channel}_${region}_${algo} -m 125 --freezeParameters MA --setParameters MA=${amass} --toysFreq
	    #combine -M GoodnessOfFit -d ../${datacard}.root --algo=${algo} -n _${channel}_${region}_${algo} -m 125 --freezeParameters MA --setParameters MA=${amass} G--toysFreq -t 500 -s 1234
            combineTool.py -M CollectGoodnessOfFit --input higgsCombine_${channel}_${region}_${algo}.GoodnessOfFit.mH125.root higgsCombine_${channel}_${region}_${algo}.GoodnessOfFit.mH125.1234.root -m 125.0 -o gof.json
	    plotGof.py gof.json --statistic ${algo} --mass 125.0 -o gof_plot --title-right=""
	    cd -
	end
    end
end
