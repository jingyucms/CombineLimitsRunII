#!/bin/tcsh

setenv hmass 1000
setenv amass 20
setenv func HHPoly5
#setenv funcname hhpoly5
setenv funcname landau

setenv sigStrength 10

text2workspace.py -m ${hmass} datacards_shape/MuMuTauTau/mmmt_mm_h_parametric_unbinned_highmass_TauHadTauHad_V3_2018_MVAMedium_DG_DoubleExpo_yRange_wFakeJECFit_PPonly_hm${hmass}_amX.txt

#text2workspace.py -m ${hmass} datacards_shape/MuMuTauTau/mmmt_mm_h_parametric_unbinned_highmass_TauHadTauHad_V3_2018_MVAMedium_DG_DoubleExpo_${func}_yRange_wFakeJECFit_PPonly_hm${hmass}_amX.txt
text2workspace.py -m ${hmass} datacards_shape/MuMuTauTau/mmmt_mm_h_parametric_unbinned_highmass_TauHadTauHad_V3_2018_MVAMedium_DG_Landau_yRange_wFakeJECFit_PPonly_hm${hmass}_amX.txt

mv datacards_shape/MuMuTauTau/mmmt_mm_h_parametric_unbinned_highmass_TauHadTauHad_V3_2018_MVAMedium_DG_DoubleExpo_yRange_wFakeJECFit_PPonly_hm${hmass}_amX.root .
#mv datacards_shape/MuMuTauTau/mmmt_mm_h_parametric_unbinned_highmass_TauHadTauHad_V3_2018_MVAMedium_DG_DoubleExpo_${func}_yRange_wFakeJECFit_PPonly_hm${hmass}_amX.root .
mv datacards_shape/MuMuTauTau/mmmt_mm_h_parametric_unbinned_highmass_TauHadTauHad_V3_2018_MVAMedium_DG_Landau_yRange_wFakeJECFit_PPonly_hm${hmass}_amX.root .

rm -rf biasStudy_h${hmass}_a${amass}_Landau
mkdir biasStudy_h${hmass}_a${amass}_Landau
cd biasStudy_h${hmass}_a${amass}_Landau

combine -M GenerateOnly ../mmmt_mm_h_parametric_unbinned_highmass_TauHadTauHad_V3_2018_MVAMedium_DG_DoubleExpo_yRange_wFakeJECFit_PPonly_hm${hmass}_amX.root -m ${hmass} --setParameters MA=${amass} --freezeParameters MA -t 1000 -n .generate_exp --expectSignal ${sigStrength} --saveToys

#combine -M MultiDimFit ../mmmt_mm_h_parametric_unbinned_highmass_TauHadTauHad_V3_2018_MVAMedium_DG_DoubleExpo_${func}_yRange_wFakeJECFit_PPonly_hm${hmass}_amX.root -m ${hmass} --setParameters MA=${amass} --freezeParameters MA -n .bias_${funcname} --toysFile higgsCombine.generate_exp.GenerateOnly.mH${hmass}.123456.root --algo singles -t 1000
combine -M MultiDimFit ../mmmt_mm_h_parametric_unbinned_highmass_TauHadTauHad_V3_2018_MVAMedium_DG_Landau_yRange_wFakeJECFit_PPonly_hm${hmass}_amX.root -m ${hmass} --setParameters MA=${amass} --freezeParameters MA -n .bias_${funcname} --toysFile higgsCombine.generate_exp.GenerateOnly.mH${hmass}.123456.root --algo singles -t 1000 
