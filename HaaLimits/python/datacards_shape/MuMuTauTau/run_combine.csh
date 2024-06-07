#!/bin/tcsh

setenv channel TauETauHad
#setenv channel TauHadTauHad_V3
#setenv channel TauMuTauHad_V2
#setenv channel TauETauHad
#setenv channel TauMuTauE_Order_Scale

setenv prefix mmmt_mm_h_parametric_unbinned_unblind
#setenv prefix mmmt_mm_parametric

setenv wp MVAMedium
#setenv wp looseMuIso_tightEleId

#setenv method DG_DoubleExpo_wFake
#setenv method 1d
setenv method DG_yRange_wFakeTauScale
#setenv method DG_DoubleExpo_Spline_wFakeTauScale
#setenv method DG_DoubleExpo_yRange_Spline_wFakeTauScaleJEC

setenv year 2016

foreach region (lowmass upsilon highmass)
#foreach region (lowmass)
    ### combine same channel different year
    #python combineChannels.py ${prefix}_${region}_${channel}_2016_2017_2018_${wp}_${method}_hm125_amX.txt ${prefix}_${region}_${channel}_2016_${wp}_${method}_hm125_amX.txt ${prefix}_${region}_${channel}_2017_${wp}_${method}_hm125_amX.txt ${prefix}_${region}_${channel}_2018_${wp}_${method}_hm125_amX.txt
    

    ### combine same year different channels
    python combineChannels.py $year ${prefix}_${region}_allchs_${year}_hm125_amX.txt ${prefix}_${region}_TauMuTauHad_V2_${year}_MVAMedium_DG_DoubleExpo_yRange_wFakeTauScaleFit_PPonly_hm125_amX.txt ${prefix}_${region}_TauMuTauE_${year}_MVAMedium_DG_wFakeTauScaleFit_PPonly_hm125_amX.txt ${prefix}_${region}_TauETauHad_${year}_MVAMedium_DG_yRange_wFakeTauScaleFit_PPonly_hm125_amX.txt ${prefix}_${region}_TauHadTauHad_V3_${year}_MVAMedium_DG_DoubleExpo_yRange_wFakeJECFit_PPonly_hm125_amX.txt ${prefix}_${region}_TauMuTauMu_${year}_MVAMedium_DG_wFakeTauScaleFit_PPonly_hm125_amX.txt


    ### combine all
    #combineCards.py ${prefix}_${region}_allchs_2016_hm125_amX.txt ${prefix}_${region}_allchs_2017_hm125_amX.txt ${prefix}_${region}_allchs_2018_hm125_amX.txt > ${prefix}_${region}_allchs_hm125_amX.txt.tmp
    #sed 's/ch1_//g' ${prefix}_${region}_allchs_hm125_amX.txt.tmp | sed 's/ch2_//g' | sed 's/ch3_//g' > ${prefix}_${region}_allchs_hm125_amX.txt
    #rm -rf ${prefix}_${region}_allchs_hm125_amX.txt.tmp
end
