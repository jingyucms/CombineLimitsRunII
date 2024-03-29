#!/bin/tcsh

## foreach year (2016 2017 2018)
##     foreach channel (TauMuTauHad_V2 TauHadTauHad_V3)
## 	python haaLimitsDevToolsRunII.py mm h --parametric --addControl --unbinned --fitParams --xRange 11 25  --yRange 50 150 --tag highmass_${channel}_${year}_MVAMedium_DG_DoubleExpo_yRange_wFakeTauScale --channel ${channel}_${year} --yFitFunc DG --doubleExpo --addSignal
##     end
##     foreach channel (TauETauHad TauMuTauE TauMuTauMu)
## 	python haaLimitsDevToolsRunII.py mm h --parametric --addControl --unbinned --fitParams --xRange 11 25 --yRange 50 150 --tag highmass_${channel}_${year}_MVAMedium_DG_yRange_wFakeTauScale --channel ${channel}_${year} --yFitFunc DG --addSignal
##     end
## end

foreach year (2016 2017 2018)
    foreach channel (TauMuTauHad_V2 TauHadTauHad_V3)
	python haaLimitsDevToolsRunII.py mm h --parametric --addControl --unbinned --fitParams --xRange 2.5 8.5  --yRange 50 150 --tag lowmass_${channel}_${year}_MVAMedium_DG_DoubleExpo_yRange_wFakeTauScale --channel ${channel}_${year} --yFitFunc DG --doubleExpo --addSignal
    end
    foreach channel (TauETauHad TauMuTauE TauMuTauMu)
	python haaLimitsDevToolsRunII.py mm h --parametric --addControl --unbinned --fitParams --xRange 2.5 8.5 --yRange 50 150 --tag lowmass_${channel}_${year}_MVAMedium_DG_yRange_wFakeTauScale --channel ${channel}_${year} --yFitFunc DG --addSignal
    end
end
