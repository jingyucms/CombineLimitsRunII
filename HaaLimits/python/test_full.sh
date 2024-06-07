#!/bin/bash

for r in `seq 0.1 0.1 0.6`
do
    #echo combine -M HybridNew -U -v -1 --LHCmode LHC-limits --saveToys --saveHybridResult -m 125 --setParameters MA=5 --freezeParameters=MA -T 500 --singlePoint ${r} --clsAcc 0 datacards_shape/MuMuTauTau/mmmt_mm_h_parametric_unbinned_lowmass_TauMuTauHad_V2_2016_MVAMedium_DG_DoubleExpo_yRangeV2_wFakeTauScale_hm125_amX.txt -n mmmt_mm_h_parametric_unbinned_lowmass_TauMuTauHad_V2_2016_MVAMedium_DG_DoubleExpo_yRange_wFakeTauScale_hm125_am5.0_X${r}
    #combine -M HybridNew --unbinned --genUnbinnedChannels TauMuTauE_2016_FP,TauMuTauE_2016_PP -v 2 --LHCmode LHC-limits --saveToys --saveHybridResult -m 125 --setParameters MA=5 --freezeParameters=MA -T 500 --singlePoint ${r} --clsAcc 0 datacards_shape/MuMuTauTau/mmmt_mm_h_parametric_unbinned_lowmass_TauMuTauE_2016_test_hm125_amX.txt -n mmmt_mm_h_parametric_unbinned_lowmass_TauMuTauE_2016_test_hm125_am5.0_X${r} --expectedFromGrid=0.5 >& TauMuTauEfull${r} &
    combine -M HybridNew --genUnbinnedChannels TauMuTauHad_V2_2016_FP,TauMuTauHad_V2_2016_PP -v 2 --LHCmode LHC-limits --saveToys --saveHybridResult -m 125 --setParameters MA=5 --freezeParameters=MA -T 500 --singlePoint ${r} --clsAcc 0 datacards_shape/MuMuTauTau/mmmt_mm_h_parametric_unbinned_lowmass_TauMuTauHad_V2_2016_MVAMedium_DG_DoubleExpo_yRange_BinnedV1_wFakeTauScale_hm125_amX.txt -n mmmt_mm_h_parametric_unbinned_lowmass_TauMuTauHad_V2_2016_MVAMedium_DG_DoubleExpo_yRange_BinnedV1_wFakeTauScale_hm125_am5.0_X${r} --expectedFromGrid=0.5 >& TauMuTauHadfull${r} &
done
