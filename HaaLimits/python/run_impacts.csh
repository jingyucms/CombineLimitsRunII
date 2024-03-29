#!/bin/tcsh

#foreach channel (TauMuTauHad_V2 TauHadTauHad_V3 TauETauHad TauMuTauE TauMuTauMu)
#foreach channel (TauMuTauE TauMuTauMu TauETauHad)
#foreach channel (TauHadTauHad_V3)
#setenv region lowmass
#setenv amass 5.0
foreach channel (TauMuTauHad_V2)
#foreach channel (TauMuTauHad_V2 TauHadTauHad_V3 TauETauHad TauMuTauE TauMuTauMu)
#foreach channel (TauMuTauHad_V2 TauHadTauHad_V3)
    #foreach region (lowmass upsilon highmass)
    foreach region (lowmass upsilon)
	foreach year (2016 2017 2018)
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
            else if ($channel == allchs_2018) then
                setenv channelT $channel
                setenv Tfunc all
            else
                setenv channelT $channel
        	setenv Tfunc MVAMedium_DG_wFakeTauScaleFit_PPonly
            endif
        
            setenv workDir Impacts_${channelT}_${region}_${year}
            if ($Tfunc == all) then
        	setenv datacard mmmt_mm_h_parametric_unbinned_${region}_${channel}_hm125_amX
            else
        	setenv datacard mmmt_mm_h_parametric_unbinned_${region}_${channel}_${year}_${Tfunc}_hm125_amX
            endif
            
            rm -rf $workDir
            mkdir $workDir
            text2workspace.py -m 125 datacards_shape/MuMuTauTau/${datacard}.txt
            mv datacards_shape/MuMuTauTau/${datacard}.root .
            cd $workDir
            #combineTool.py -M Impacts -m 125 -t -1 --setParameters MA=${amass} --freezeParameters MA --setParameterRanges MA=${amass},${amass} --expectSignal=1 --X-rtd TMCSO_AdaptivePseudoAsimov=0 --X-rtd TMCSO_PseudoAsimov=0 --robustFit 1 -d ../${datacard}.root --doInitialFit 
            #combineTool.py -M Impacts -m 125 -t -1 --unbinned --setParameters MA=${amass} --freezeParameters MA --setParameterRanges MA=${amass},${amass} --expectSignal=1 --robustFit 1 -d ../${datacard}.root --doFits --parallel 10
            #combineTool.py -M Impacts -m 125 -t -1 --unbinned --setParameters MA=${amass} --freezeParameters MA --setParameterRanges MA=${amass},${amass} --expectSignal=1 --robustFit 1 -d ../${datacard}.root --output impacts.json
            combineTool.py -M Impacts -m 125 --unbinned --setParameters MA=${amass} --freezeParameters MA --setParameterRanges MA=${amass},${amass} --rMin -1 --rMax 1 --robustFit 1 -d ../${datacard}.root --doInitialFit -v 2 > fit.log
            combineTool.py -M Impacts -m 125 --unbinned --setParameters MA=${amass} --freezeParameters MA --setParameterRanges MA=${amass},${amass} --rMin -1 --rMax 1 --robustFit 1 -d ../${datacard}.root --doFits --parallel 10
            combineTool.py -M Impacts -m 125 --unbinned --setParameters MA=${amass} --freezeParameters MA --setParameterRanges MA=${amass},${amass} --rMin -1 --rMax 1 --robustFit 1 -d ../${datacard}.root --output impacts.json
            plotImpacts.py -i impacts.json -o impacts
	    cd -
	end
    end
end
