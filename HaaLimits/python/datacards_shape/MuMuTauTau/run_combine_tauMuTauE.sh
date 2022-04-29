#!/bin/bash


combineCards.py --xc control mmmt_mm_parametric_lowmass_TauMuTauE_Order_Scale_2017_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt mmmt_mm_parametric_lowmass_TauMuTauE_Order_Scale_2016_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt > mmmt_mm_parametric_lowmass_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt.tmp
sed 's/ch1_//g' mmmt_mm_parametric_lowmass_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt.tmp | sed 's/ch2_//g' > mmmt_mm_parametric_lowmass_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt
combineCards.py mmmt_mm_parametric_lowmass_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt mmmt_mm_parametric_lowmass_TauMuTauE_Order_Scale_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt > mmmt_mm_parametric_lowmass_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt.tmp
sed 's/ch1_//g' mmmt_mm_parametric_lowmass_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt.tmp | sed 's/ch2_//g' > mmmt_mm_parametric_lowmass_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt

combineCards.py --xc control mmmt_mm_parametric_highmass_TauMuTauE_Order_Scale_2017_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt mmmt_mm_parametric_highmass_TauMuTauE_Order_Scale_2016_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt > mmmt_mm_parametric_highmass_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt.tmp
sed 's/ch1_//g' mmmt_mm_parametric_highmass_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt.tmp | sed 's/ch2_//g' > mmmt_mm_parametric_highmass_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt
combineCards.py mmmt_mm_parametric_highmass_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt mmmt_mm_parametric_highmass_TauMuTauE_Order_Scale_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt > mmmt_mm_parametric_highmass_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt.tmp
sed 's/ch1_//g' mmmt_mm_parametric_highmass_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt.tmp | sed 's/ch2_//g' > mmmt_mm_parametric_highmass_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt

combineCards.py --xc control mmmt_mm_parametric_upsilon_TauMuTauE_Order_Scale_2017_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt mmmt_mm_parametric_upsilon_TauMuTauE_Order_Scale_2016_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt > mmmt_mm_parametric_upsilon_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt.tmp
sed 's/ch1_//g' mmmt_mm_parametric_upsilon_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt.tmp | sed 's/ch2_//g' > mmmt_mm_parametric_upsilon_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt
combineCards.py mmmt_mm_parametric_upsilon_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt mmmt_mm_parametric_upsilon_TauMuTauE_Order_Scale_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt > mmmt_mm_parametric_upsilon_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt.tmp
sed 's/ch1_//g' mmmt_mm_parametric_upsilon_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt.tmp | sed 's/ch2_//g' > mmmt_mm_parametric_upsilon_TauMuTauE_Order_Scale_2016_2017_2018_looseMuIso_tightEleId_1d_wFakeModelling_hm125_amX.txt
