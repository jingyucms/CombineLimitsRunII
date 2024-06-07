#!/bin/tcsh

#setenv channel TauMuTauHad_V2
#setenv channel TauHadTauHad_V3
#setenv channel TauETauHad
#setenv channel TauMuTauE
setenv channel TauMuTauMu

#foreach year (2016 2017 2018)
foreach year (2016 2017 2018)
#foreach year (2018)
    if ($channel == TauMuTauHad_V2) then
        python haaLimitsDevToolsRunII.py mm h --unblind --parametric --addControl --fitParams --unbinned --xRange 2.5 8.5  --yRange 50 150 --tag lowmass_${channel}_${year}_MVAMedium_DG_DoubleExpo_yRange_wFakeTauScaleFit_PPonly --channel ${channel}_${year} --yFitFunc DG --doubleExpo >& log1${year} &
	python haaLimitsDevToolsRunII.py mm h --unblind --parametric --addControl --fitParams --unbinned --xRange 6 14  --yRange 50 150 --tag upsilon_${channel}_${year}_MVAMedium_DG_DoubleExpo_yRange_wFakeTauScaleFit_PPonly --channel ${channel}_${year} --yFitFunc DG --doubleExpo >& log2${year} &
	python haaLimitsDevToolsRunII.py mm h --unblind --parametric --addControl --fitParams --unbinned --xRange 11 25  --yRange 50 150 --tag highmass_${channel}_${year}_MVAMedium_DG_DoubleExpo_yRange_wFakeTauScaleFit_PPonly --channel ${channel}_${year} --yFitFunc DG --doubleExpo >& log3${year} &
 	#python haaLimitsDevToolsRunII.py mm h --parametric --addControl --fitParams --unbinned --xRange 2.5 8.5  --yRange 50 150 --tag lowmass_${channel}_${year}_MVAMedium_DG_yRange_wFakeTauScaleFit_PPonly --channel ${channel}_${year} --yFitFunc DG >& log1${year} &
	#python haaLimitsDevToolsRunII.py mm h --parametric --addControl --fitParams --unbinned --xRange 6 14  --yRange 50 150 --tag upsilon_${channel}_${year}_MVAMedium_DG_yRange_wFakeTauScaleFit_PPonly --channel ${channel}_${year} --yFitFunc DG >& log2${year} &
	#python haaLimitsDevToolsRunII.py mm h --parametric --addControl --fitParams --unbinned --xRange 11 45  --yRange 50 150 --tag highmass_${channel}_${year}_MVAMedium_DG_yRange_wFakeTauScaleFit_PPonly --channel ${channel}_${year} --yFitFunc DG >& log3${year} &
    else if ($channel == TauHadTauHad_V3) then
	python haaLimitsDevToolsRunII.py mm h --unblind --parametric --fitParams --addControl --unbinned --xRange 2.5 8.5 --yRange 50 150 --tag lowmass_${channel}_${year}_MVAMedium_DG_DoubleExpo_yRange_wFakeJECFit_PPonly --channel ${channel}_${year} --yFitFunc DG --doubleExpo >& log1${year} &
	python haaLimitsDevToolsRunII.py mm h --unblind --parametric --fitParams --addControl --unbinned --xRange 6 14 --yRange 50 150 --tag upsilon_${channel}_${year}_MVAMedium_DG_DoubleExpo_yRange_wFakeJECFit_PPonly --channel ${channel}_${year} --yFitFunc DG --doubleExpo >& log2${year} &
	python haaLimitsDevToolsRunII.py mm h --unblind --parametric --fitParams --addControl --unbinned --xRange 11 25 --yRange 50 150 --tag highmass_${channel}_${year}_MVAMedium_DG_DoubleExpo_yRange_wFakeJECFit_PPonly --channel ${channel}_${year} --yFitFunc DG --doubleExpo >& log3${year} &
	#python haaLimitsDevToolsRunII.py mm h --unblind --parametric --fitParams --addControl --unbinned --xRange 28 52 --yRange 50 150 --tag highhiggs_${channel}_${year}_MVAMedium_DG_DoubleExpo_yRange_wFakeJECFit_PPonly --channel ${channel}_${year} --yFitFunc DG --doubleExpo >& log4${year} &
    else if ($channel == TauETauHad) then
	python haaLimitsDevToolsRunII.py mm h --unblind --parametric --addControl --unbinned --fitParams --xRange 2.5 8.5 --yRange 50 150 --tag lowmass_${channel}_${year}_MVAMedium_DG_yRange_wFakeTauScaleFit_PPonly --channel ${channel}_${year} --yFitFunc DG >& log1${year} &
	python haaLimitsDevToolsRunII.py mm h --unblind --parametric --addControl --unbinned --fitParams --xRange 6 14 --yRange 50 150 --tag upsilon_${channel}_${year}_MVAMedium_DG_yRange_wFakeTauScaleFit_PPonly --channel ${channel}_${year} --yFitFunc DG >& log2${year} &
	python haaLimitsDevToolsRunII.py mm h --unblind --parametric --addControl --unbinned --fitParams --xRange 11 25 --yRange 50 150 --tag highmass_${channel}_${year}_MVAMedium_DG_yRange_wFakeTauScaleFit_PPonly --channel ${channel}_${year} --yFitFunc DG >& log3${year} &
	#python haaLimitsDevToolsRunII.py mm h --parametric --addControl --unbinned --fitParams --xRange 2.5 8.5 --yRange 50 150 --tag lowmass_${channel}_${year}_MVAMedium_DG_yRange_wFakeTauScaleFit_PPonly --channel ${channel}_${year} --yFitFunc DG >& log1${year} &
	#python haaLimitsDevToolsRunII.py mm h --parametric --addControl --unbinned --fitParams --xRange 6 14 --yRange 50 150 --tag upsilon_${channel}_${year}_MVAMedium_DG_yRange_wFakeTauScaleFit_PPonly --channel ${channel}_${year} --yFitFunc DG >& log2${year} &
	#python haaLimitsDevToolsRunII.py mm h --parametric --addControl --unbinned --fitParams --xRange 11 45 --yRange 50 150 --tag highmass_${channel}_${year}_MVAMedium_DG_yRange_wFakeTauScaleFit_PPonly --channel ${channel}_${year} --yFitFunc DG >& log3${year} &
    else
	python haaLimitsDevToolsRunII.py mm h --unblind --parametric --addControl --unbinned --fitParams --xRange 2.5 8.5 --tag lowmass_${channel}_${year}_MVAMedium_DG_wFakeTauScaleFit_PPonly --channel ${channel}_${year} --yFitFunc DG >& log1${year} &
	python haaLimitsDevToolsRunII.py mm h --unblind --parametric --addControl --unbinned --fitParams --xRange 6 14 --tag upsilon_${channel}_${year}_MVAMedium_DG_wFakeTauScaleFit_PPonly --channel ${channel}_${year} --yFitFunc DG >& log2${year} &
	python haaLimitsDevToolsRunII.py mm h --unblind --parametric --addControl --unbinned --fitParams --xRange 11 25 --tag highmass_${channel}_${year}_MVAMedium_DG_wFakeTauScaleFit_PPonly --channel ${channel}_${year} --yFitFunc DG >& log3${year} &
    endif
end

