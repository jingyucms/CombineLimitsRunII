#!/bin/sh
ulimit -s unlimited
set -e
cd /afs/cern.ch/work/z/zhangj/private/RunIILimits/CMSSW_10_2_13/src
export SCRAM_ARCH=slc7_amd64_gcc700
source /cvmfs/cms.cern.ch/cmsset_default.sh
eval `scramv1 runtime -sh`
cd /afs/cern.ch/work/z/zhangj/private/RunIILimits/CMSSW_10_2_13/src/CombineLimitsRunII/HaaLimits/python

if [ $1 -eq 0 ]; then
  combine -M MultiDimFit -n _paramFit_Test_CMS_eff_m --algo impact --redefineSignalPOIs r -P CMS_eff_m --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 1 ]; then
  combine -M MultiDimFit -n _paramFit_Test_CMS_haa_acc --algo impact --redefineSignalPOIs r -P CMS_haa_acc --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 2 ]; then
  combine -M MultiDimFit -n _paramFit_Test_MA --algo impact --redefineSignalPOIs r -P MA --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 3 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauETauHad_2016_fake --algo impact --redefineSignalPOIs r -P TauETauHad_2016_fake --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 4 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauETauHad_2017_fake --algo impact --redefineSignalPOIs r -P TauETauHad_2017_fake --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 5 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauETauHad_2018_fake --algo impact --redefineSignalPOIs r -P TauETauHad_2018_fake --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 6 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauHadTauHad_V3_2016_JEC --algo impact --redefineSignalPOIs r -P TauHadTauHad_V3_2016_JEC --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 7 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauHadTauHad_V3_2016_fake --algo impact --redefineSignalPOIs r -P TauHadTauHad_V3_2016_fake --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 8 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauHadTauHad_V3_2017_JEC --algo impact --redefineSignalPOIs r -P TauHadTauHad_V3_2017_JEC --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 9 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauHadTauHad_V3_2017_fake --algo impact --redefineSignalPOIs r -P TauHadTauHad_V3_2017_fake --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 10 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauHadTauHad_V3_2018_JEC --algo impact --redefineSignalPOIs r -P TauHadTauHad_V3_2018_JEC --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 11 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauHadTauHad_V3_2018_fake --algo impact --redefineSignalPOIs r -P TauHadTauHad_V3_2018_fake --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 12 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauMuTauE_2016_electronIDScale --algo impact --redefineSignalPOIs r -P TauMuTauE_2016_electronIDScale --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 13 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauMuTauE_2016_fake --algo impact --redefineSignalPOIs r -P TauMuTauE_2016_fake --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 14 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauMuTauE_2017_electronIDScale --algo impact --redefineSignalPOIs r -P TauMuTauE_2017_electronIDScale --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 15 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauMuTauE_2017_fake --algo impact --redefineSignalPOIs r -P TauMuTauE_2017_fake --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 16 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauMuTauE_2018_electronIDScale --algo impact --redefineSignalPOIs r -P TauMuTauE_2018_electronIDScale --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 17 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauMuTauE_2018_fake --algo impact --redefineSignalPOIs r -P TauMuTauE_2018_fake --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 18 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauMuTauHad_V2_2016_fake --algo impact --redefineSignalPOIs r -P TauMuTauHad_V2_2016_fake --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 19 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauMuTauHad_V2_2017_fake --algo impact --redefineSignalPOIs r -P TauMuTauHad_V2_2017_fake --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 20 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauMuTauHad_V2_2018_fake --algo impact --redefineSignalPOIs r -P TauMuTauHad_V2_2018_fake --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 21 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauMuTauMu_2016_fake --algo impact --redefineSignalPOIs r -P TauMuTauMu_2016_fake --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 22 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauMuTauMu_2016_muonIsoScale --algo impact --redefineSignalPOIs r -P TauMuTauMu_2016_muonIsoScale --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 23 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauMuTauMu_2017_fake --algo impact --redefineSignalPOIs r -P TauMuTauMu_2017_fake --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 24 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauMuTauMu_2017_muonIsoScale --algo impact --redefineSignalPOIs r -P TauMuTauMu_2017_muonIsoScale --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 25 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauMuTauMu_2018_fake --algo impact --redefineSignalPOIs r -P TauMuTauMu_2018_fake --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 26 ]; then
  combine -M MultiDimFit -n _paramFit_Test_TauMuTauMu_2018_muonIsoScale --algo impact --redefineSignalPOIs r -P TauMuTauMu_2018_muonIsoScale --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 27 ]; then
  combine -M MultiDimFit -n _paramFit_Test_lambda_cont1_control_2016 --algo impact --redefineSignalPOIs r -P lambda_cont1_control_2016 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 28 ]; then
  combine -M MultiDimFit -n _paramFit_Test_lambda_cont1_control_2017 --algo impact --redefineSignalPOIs r -P lambda_cont1_control_2017 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 29 ]; then
  combine -M MultiDimFit -n _paramFit_Test_lambda_cont1_control_2018 --algo impact --redefineSignalPOIs r -P lambda_cont1_control_2018 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 30 ]; then
  combine -M MultiDimFit -n _paramFit_Test_lumi_13TeV --algo impact --redefineSignalPOIs r -P lumi_13TeV --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 31 ]; then
  combine -M MultiDimFit -n _paramFit_Test_mean_jpsi1S_2016 --algo impact --redefineSignalPOIs r -P mean_jpsi1S_2016 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 32 ]; then
  combine -M MultiDimFit -n _paramFit_Test_mean_jpsi1S_2017 --algo impact --redefineSignalPOIs r -P mean_jpsi1S_2017 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 33 ]; then
  combine -M MultiDimFit -n _paramFit_Test_mean_jpsi1S_2018 --algo impact --redefineSignalPOIs r -P mean_jpsi1S_2018 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 34 ]; then
  combine -M MultiDimFit -n _paramFit_Test_mean_jpsi2S_2016 --algo impact --redefineSignalPOIs r -P mean_jpsi2S_2016 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 35 ]; then
  combine -M MultiDimFit -n _paramFit_Test_mean_jpsi2S_2017 --algo impact --redefineSignalPOIs r -P mean_jpsi2S_2017 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 36 ]; then
  combine -M MultiDimFit -n _paramFit_Test_mean_jpsi2S_2018 --algo impact --redefineSignalPOIs r -P mean_jpsi2S_2018 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 37 ]; then
  combine -M MultiDimFit -n _paramFit_Test_pdf_gg --algo impact --redefineSignalPOIs r -P pdf_gg --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 38 ]; then
  combine -M MultiDimFit -n _paramFit_Test_relNorm_jpsi2S_2016 --algo impact --redefineSignalPOIs r -P relNorm_jpsi2S_2016 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 39 ]; then
  combine -M MultiDimFit -n _paramFit_Test_relNorm_jpsi2S_2017 --algo impact --redefineSignalPOIs r -P relNorm_jpsi2S_2017 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 40 ]; then
  combine -M MultiDimFit -n _paramFit_Test_relNorm_jpsi2S_2018 --algo impact --redefineSignalPOIs r -P relNorm_jpsi2S_2018 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 41 ]; then
  combine -M MultiDimFit -n _paramFit_Test_sigma_jpsi1S_2016 --algo impact --redefineSignalPOIs r -P sigma_jpsi1S_2016 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 42 ]; then
  combine -M MultiDimFit -n _paramFit_Test_sigma_jpsi1S_2017 --algo impact --redefineSignalPOIs r -P sigma_jpsi1S_2017 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 43 ]; then
  combine -M MultiDimFit -n _paramFit_Test_sigma_jpsi1S_2018 --algo impact --redefineSignalPOIs r -P sigma_jpsi1S_2018 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 44 ]; then
  combine -M MultiDimFit -n _paramFit_Test_sigma_jpsi2S_2016 --algo impact --redefineSignalPOIs r -P sigma_jpsi2S_2016 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 45 ]; then
  combine -M MultiDimFit -n _paramFit_Test_sigma_jpsi2S_2017 --algo impact --redefineSignalPOIs r -P sigma_jpsi2S_2017 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 46 ]; then
  combine -M MultiDimFit -n _paramFit_Test_sigma_jpsi2S_2018 --algo impact --redefineSignalPOIs r -P sigma_jpsi2S_2018 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 47 ]; then
  combine -M MultiDimFit -n _paramFit_Test_tauIDScale_2016 --algo impact --redefineSignalPOIs r -P tauIDScale_2016 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 48 ]; then
  combine -M MultiDimFit -n _paramFit_Test_tauIDScale_2017 --algo impact --redefineSignalPOIs r -P tauIDScale_2017 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 49 ]; then
  combine -M MultiDimFit -n _paramFit_Test_tauIDScale_2018 --algo impact --redefineSignalPOIs r -P tauIDScale_2018 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 50 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_bg1_TauHadTauHad_V3_2016_PP_y_frac --algo impact --redefineSignalPOIs r -P uncrt_bg1_TauHadTauHad_V3_2016_PP_y_frac --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 51 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_bg1_TauHadTauHad_V3_2017_PP_y_frac --algo impact --redefineSignalPOIs r -P uncrt_bg1_TauHadTauHad_V3_2017_PP_y_frac --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 52 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_bg1_TauHadTauHad_V3_2018_PP_y_frac --algo impact --redefineSignalPOIs r -P uncrt_bg1_TauHadTauHad_V3_2018_PP_y_frac --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 53 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_bg1_TauMuTauHad_V2_2016_PP_y_frac --algo impact --redefineSignalPOIs r -P uncrt_bg1_TauMuTauHad_V2_2016_PP_y_frac --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 54 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_bg1_TauMuTauHad_V2_2017_PP_y_frac --algo impact --redefineSignalPOIs r -P uncrt_bg1_TauMuTauHad_V2_2017_PP_y_frac --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 55 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_bg1_TauMuTauHad_V2_2018_PP_y_frac --algo impact --redefineSignalPOIs r -P uncrt_bg1_TauMuTauHad_V2_2018_PP_y_frac --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 56 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfScale_erf1_TauHadTauHad_V3_2016_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfScale_erf1_TauHadTauHad_V3_2016_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 57 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfScale_erf1_TauHadTauHad_V3_2017_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfScale_erf1_TauHadTauHad_V3_2017_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 58 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfScale_erf1_TauHadTauHad_V3_2018_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfScale_erf1_TauHadTauHad_V3_2018_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 59 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfScale_erf1_TauMuTauHad_V2_2016_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfScale_erf1_TauMuTauHad_V2_2016_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 60 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfScale_erf1_TauMuTauHad_V2_2017_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfScale_erf1_TauMuTauHad_V2_2017_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 61 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfScale_erf1_TauMuTauHad_V2_2018_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfScale_erf1_TauMuTauHad_V2_2018_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 62 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfScale_erf_TauETauHad_2016_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfScale_erf_TauETauHad_2016_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 63 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfScale_erf_TauETauHad_2017_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfScale_erf_TauETauHad_2017_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 64 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfScale_erf_TauETauHad_2018_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfScale_erf_TauETauHad_2018_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 65 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfScale_erf_TauMuTauE_2016_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfScale_erf_TauMuTauE_2016_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 66 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfScale_erf_TauMuTauE_2017_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfScale_erf_TauMuTauE_2017_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 67 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfScale_erf_TauMuTauE_2018_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfScale_erf_TauMuTauE_2018_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 68 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfScale_erf_TauMuTauMu_2016_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfScale_erf_TauMuTauMu_2016_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 69 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfScale_erf_TauMuTauMu_2017_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfScale_erf_TauMuTauMu_2017_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 70 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfScale_erf_TauMuTauMu_2018_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfScale_erf_TauMuTauMu_2018_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 71 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfShift_erf1_TauHadTauHad_V3_2016_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfShift_erf1_TauHadTauHad_V3_2016_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 72 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfShift_erf1_TauHadTauHad_V3_2017_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfShift_erf1_TauHadTauHad_V3_2017_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 73 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfShift_erf1_TauHadTauHad_V3_2018_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfShift_erf1_TauHadTauHad_V3_2018_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 74 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfShift_erf1_TauMuTauHad_V2_2016_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfShift_erf1_TauMuTauHad_V2_2016_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 75 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfShift_erf1_TauMuTauHad_V2_2017_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfShift_erf1_TauMuTauHad_V2_2017_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 76 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfShift_erf1_TauMuTauHad_V2_2018_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfShift_erf1_TauMuTauHad_V2_2018_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 77 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfShift_erf_TauETauHad_2016_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfShift_erf_TauETauHad_2016_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 78 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfShift_erf_TauETauHad_2017_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfShift_erf_TauETauHad_2017_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 79 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfShift_erf_TauETauHad_2018_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfShift_erf_TauETauHad_2018_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 80 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfShift_erf_TauMuTauE_2016_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfShift_erf_TauMuTauE_2016_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 81 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfShift_erf_TauMuTauE_2017_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfShift_erf_TauMuTauE_2017_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 82 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfShift_erf_TauMuTauE_2018_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfShift_erf_TauMuTauE_2018_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 83 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfShift_erf_TauMuTauMu_2016_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfShift_erf_TauMuTauMu_2016_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 84 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfShift_erf_TauMuTauMu_2017_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfShift_erf_TauMuTauMu_2017_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 85 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_erfShift_erf_TauMuTauMu_2018_PP_y --algo impact --redefineSignalPOIs r -P uncrt_erfShift_erf_TauMuTauMu_2018_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 86 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont1_TauETauHad_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont1_TauETauHad_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 87 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont1_TauETauHad_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont1_TauETauHad_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 88 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont1_TauETauHad_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont1_TauETauHad_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 89 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont1_TauHadTauHad_V3_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont1_TauHadTauHad_V3_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 90 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont1_TauHadTauHad_V3_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont1_TauHadTauHad_V3_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 91 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont1_TauHadTauHad_V3_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont1_TauHadTauHad_V3_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 92 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont1_TauMuTauE_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont1_TauMuTauE_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 93 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont1_TauMuTauE_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont1_TauMuTauE_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 94 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont1_TauMuTauE_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont1_TauMuTauE_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 95 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont1_TauMuTauHad_V2_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont1_TauMuTauHad_V2_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 96 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont1_TauMuTauHad_V2_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont1_TauMuTauHad_V2_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 97 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont1_TauMuTauHad_V2_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont1_TauMuTauHad_V2_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 98 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont1_TauMuTauMu_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont1_TauMuTauMu_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 99 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont1_TauMuTauMu_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont1_TauMuTauMu_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 100 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont1_TauMuTauMu_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont1_TauMuTauMu_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 101 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont2_TauETauHad_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont2_TauETauHad_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 102 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont2_TauETauHad_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont2_TauETauHad_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 103 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont2_TauETauHad_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont2_TauETauHad_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 104 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont2_TauHadTauHad_V3_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont2_TauHadTauHad_V3_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 105 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont2_TauHadTauHad_V3_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont2_TauHadTauHad_V3_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 106 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont2_TauHadTauHad_V3_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont2_TauHadTauHad_V3_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 107 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont2_TauMuTauHad_V2_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont2_TauMuTauHad_V2_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 108 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont2_TauMuTauHad_V2_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont2_TauMuTauHad_V2_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 109 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_cont2_TauMuTauHad_V2_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_cont2_TauMuTauHad_V2_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 110 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_ggH_haa_125_TauETauHad_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_ggH_haa_125_TauETauHad_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 111 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_ggH_haa_125_TauETauHad_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_ggH_haa_125_TauETauHad_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 112 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_ggH_haa_125_TauETauHad_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_ggH_haa_125_TauETauHad_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 113 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_ggH_haa_125_TauHadTauHad_V3_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_ggH_haa_125_TauHadTauHad_V3_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 114 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_ggH_haa_125_TauHadTauHad_V3_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_ggH_haa_125_TauHadTauHad_V3_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 115 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_ggH_haa_125_TauHadTauHad_V3_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_ggH_haa_125_TauHadTauHad_V3_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 116 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_ggH_haa_125_TauMuTauE_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_ggH_haa_125_TauMuTauE_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 117 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_ggH_haa_125_TauMuTauE_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_ggH_haa_125_TauMuTauE_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 118 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_ggH_haa_125_TauMuTauE_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_ggH_haa_125_TauMuTauE_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 119 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_ggH_haa_125_TauMuTauHad_V2_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_ggH_haa_125_TauMuTauHad_V2_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 120 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_ggH_haa_125_TauMuTauHad_V2_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_ggH_haa_125_TauMuTauHad_V2_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 121 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_ggH_haa_125_TauMuTauHad_V2_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_ggH_haa_125_TauMuTauHad_V2_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 122 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_ggH_haa_125_TauMuTauMu_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_ggH_haa_125_TauMuTauMu_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 123 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_ggH_haa_125_TauMuTauMu_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_ggH_haa_125_TauMuTauMu_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 124 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_ggH_haa_125_TauMuTauMu_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_ggH_haa_125_TauMuTauMu_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 125 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_jpsi1S_TauETauHad_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_jpsi1S_TauETauHad_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 126 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_jpsi1S_TauETauHad_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_jpsi1S_TauETauHad_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 127 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_jpsi1S_TauETauHad_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_jpsi1S_TauETauHad_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 128 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_jpsi1S_TauHadTauHad_V3_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_jpsi1S_TauHadTauHad_V3_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 129 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_jpsi1S_TauHadTauHad_V3_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_jpsi1S_TauHadTauHad_V3_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 130 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_jpsi1S_TauHadTauHad_V3_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_jpsi1S_TauHadTauHad_V3_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 131 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_jpsi1S_TauMuTauE_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_jpsi1S_TauMuTauE_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 132 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_jpsi1S_TauMuTauE_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_jpsi1S_TauMuTauE_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 133 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_jpsi1S_TauMuTauE_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_jpsi1S_TauMuTauE_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 134 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_jpsi1S_TauMuTauHad_V2_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_jpsi1S_TauMuTauHad_V2_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 135 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_jpsi1S_TauMuTauHad_V2_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_jpsi1S_TauMuTauHad_V2_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 136 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_jpsi1S_TauMuTauHad_V2_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_jpsi1S_TauMuTauHad_V2_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 137 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_jpsi1S_TauMuTauMu_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_jpsi1S_TauMuTauMu_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 138 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_jpsi1S_TauMuTauMu_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_jpsi1S_TauMuTauMu_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 139 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_integral_jpsi1S_TauMuTauMu_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_integral_jpsi1S_TauMuTauMu_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 140 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont1_TauETauHad_2016_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont1_TauETauHad_2016_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 141 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont1_TauETauHad_2017_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont1_TauETauHad_2017_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 142 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont1_TauETauHad_2018_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont1_TauETauHad_2018_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 143 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont1_TauHadTauHad_V3_2016_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont1_TauHadTauHad_V3_2016_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 144 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont1_TauHadTauHad_V3_2017_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont1_TauHadTauHad_V3_2017_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 145 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont1_TauHadTauHad_V3_2018_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont1_TauHadTauHad_V3_2018_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 146 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont1_TauMuTauE_2016_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont1_TauMuTauE_2016_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 147 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont1_TauMuTauE_2017_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont1_TauMuTauE_2017_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 148 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont1_TauMuTauE_2018_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont1_TauMuTauE_2018_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 149 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont1_TauMuTauHad_V2_2016_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont1_TauMuTauHad_V2_2016_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 150 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont1_TauMuTauHad_V2_2017_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont1_TauMuTauHad_V2_2017_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 151 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont1_TauMuTauHad_V2_2018_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont1_TauMuTauHad_V2_2018_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 152 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont1_TauMuTauMu_2016_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont1_TauMuTauMu_2016_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 153 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont1_TauMuTauMu_2017_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont1_TauMuTauMu_2017_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 154 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont1_TauMuTauMu_2018_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont1_TauMuTauMu_2018_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 155 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont2_TauETauHad_2016_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont2_TauETauHad_2016_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 156 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont2_TauETauHad_2017_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont2_TauETauHad_2017_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 157 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont2_TauETauHad_2018_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont2_TauETauHad_2018_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 158 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont2_TauHadTauHad_V3_2016_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont2_TauHadTauHad_V3_2016_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 159 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont2_TauHadTauHad_V3_2017_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont2_TauHadTauHad_V3_2017_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 160 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont2_TauHadTauHad_V3_2018_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont2_TauHadTauHad_V3_2018_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 161 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont2_TauMuTauHad_V2_2016_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont2_TauMuTauHad_V2_2016_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 162 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont2_TauMuTauHad_V2_2017_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont2_TauMuTauHad_V2_2017_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 163 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_cont2_TauMuTauHad_V2_2018_PP_x --algo impact --redefineSignalPOIs r -P uncrt_lambda_cont2_TauMuTauHad_V2_2018_PP_x --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 164 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty1_TauHadTauHad_V3_2016_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty1_TauHadTauHad_V3_2016_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 165 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty1_TauHadTauHad_V3_2017_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty1_TauHadTauHad_V3_2017_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 166 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty1_TauHadTauHad_V3_2018_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty1_TauHadTauHad_V3_2018_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 167 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty1_TauMuTauHad_V2_2016_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty1_TauMuTauHad_V2_2016_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 168 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty1_TauMuTauHad_V2_2017_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty1_TauMuTauHad_V2_2017_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 169 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty1_TauMuTauHad_V2_2018_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty1_TauMuTauHad_V2_2018_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 170 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty2_TauHadTauHad_V3_2016_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty2_TauHadTauHad_V3_2016_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 171 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty2_TauHadTauHad_V3_2017_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty2_TauHadTauHad_V3_2017_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 172 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty2_TauHadTauHad_V3_2018_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty2_TauHadTauHad_V3_2018_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 173 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty2_TauMuTauHad_V2_2016_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty2_TauMuTauHad_V2_2016_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 174 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty2_TauMuTauHad_V2_2017_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty2_TauMuTauHad_V2_2017_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 175 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty2_TauMuTauHad_V2_2018_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty2_TauMuTauHad_V2_2018_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 176 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty_TauETauHad_2016_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty_TauETauHad_2016_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 177 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty_TauETauHad_2017_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty_TauETauHad_2017_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 178 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty_TauETauHad_2018_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty_TauETauHad_2018_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 179 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty_TauMuTauE_2016_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty_TauMuTauE_2016_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 180 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty_TauMuTauE_2017_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty_TauMuTauE_2017_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 181 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty_TauMuTauE_2018_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty_TauMuTauE_2018_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 182 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty_TauMuTauMu_2016_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty_TauMuTauMu_2016_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 183 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty_TauMuTauMu_2017_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty_TauMuTauMu_2017_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 184 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_lambda_conty_TauMuTauMu_2018_PP_y --algo impact --redefineSignalPOIs r -P uncrt_lambda_conty_TauMuTauMu_2018_PP_y --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 185 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigx_ggH_haa_125_TauETauHad_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigx_ggH_haa_125_TauETauHad_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 186 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigx_ggH_haa_125_TauETauHad_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigx_ggH_haa_125_TauETauHad_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 187 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigx_ggH_haa_125_TauETauHad_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigx_ggH_haa_125_TauETauHad_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 188 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigx_ggH_haa_125_TauHadTauHad_V3_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigx_ggH_haa_125_TauHadTauHad_V3_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 189 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigx_ggH_haa_125_TauHadTauHad_V3_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigx_ggH_haa_125_TauHadTauHad_V3_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 190 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigx_ggH_haa_125_TauHadTauHad_V3_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigx_ggH_haa_125_TauHadTauHad_V3_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 191 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigx_ggH_haa_125_TauMuTauE_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigx_ggH_haa_125_TauMuTauE_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 192 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigx_ggH_haa_125_TauMuTauE_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigx_ggH_haa_125_TauMuTauE_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 193 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigx_ggH_haa_125_TauMuTauE_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigx_ggH_haa_125_TauMuTauE_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 194 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigx_ggH_haa_125_TauMuTauHad_V2_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigx_ggH_haa_125_TauMuTauHad_V2_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 195 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigx_ggH_haa_125_TauMuTauHad_V2_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigx_ggH_haa_125_TauMuTauHad_V2_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 196 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigx_ggH_haa_125_TauMuTauHad_V2_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigx_ggH_haa_125_TauMuTauHad_V2_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 197 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigx_ggH_haa_125_TauMuTauMu_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigx_ggH_haa_125_TauMuTauMu_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 198 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigx_ggH_haa_125_TauMuTauMu_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigx_ggH_haa_125_TauMuTauMu_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 199 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigx_ggH_haa_125_TauMuTauMu_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigx_ggH_haa_125_TauMuTauMu_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 200 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigy_ggH_haa_125_TauETauHad_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigy_ggH_haa_125_TauETauHad_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 201 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigy_ggH_haa_125_TauETauHad_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigy_ggH_haa_125_TauETauHad_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 202 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigy_ggH_haa_125_TauETauHad_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigy_ggH_haa_125_TauETauHad_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 203 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigy_ggH_haa_125_TauHadTauHad_V3_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigy_ggH_haa_125_TauHadTauHad_V3_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 204 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigy_ggH_haa_125_TauHadTauHad_V3_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigy_ggH_haa_125_TauHadTauHad_V3_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 205 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigy_ggH_haa_125_TauHadTauHad_V3_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigy_ggH_haa_125_TauHadTauHad_V3_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 206 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigy_ggH_haa_125_TauMuTauE_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigy_ggH_haa_125_TauMuTauE_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 207 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigy_ggH_haa_125_TauMuTauE_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigy_ggH_haa_125_TauMuTauE_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 208 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigy_ggH_haa_125_TauMuTauE_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigy_ggH_haa_125_TauMuTauE_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 209 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigy_ggH_haa_125_TauMuTauHad_V2_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigy_ggH_haa_125_TauMuTauHad_V2_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 210 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigy_ggH_haa_125_TauMuTauHad_V2_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigy_ggH_haa_125_TauMuTauHad_V2_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 211 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigy_ggH_haa_125_TauMuTauHad_V2_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigy_ggH_haa_125_TauMuTauHad_V2_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 212 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigy_ggH_haa_125_TauMuTauMu_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigy_ggH_haa_125_TauMuTauMu_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 213 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigy_ggH_haa_125_TauMuTauMu_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigy_ggH_haa_125_TauMuTauMu_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 214 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_mean_sigy_ggH_haa_125_TauMuTauMu_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_mean_sigy_ggH_haa_125_TauMuTauMu_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 215 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma1_sigy_ggH_haa_125_TauETauHad_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma1_sigy_ggH_haa_125_TauETauHad_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 216 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma1_sigy_ggH_haa_125_TauETauHad_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma1_sigy_ggH_haa_125_TauETauHad_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 217 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma1_sigy_ggH_haa_125_TauETauHad_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma1_sigy_ggH_haa_125_TauETauHad_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 218 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma1_sigy_ggH_haa_125_TauHadTauHad_V3_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma1_sigy_ggH_haa_125_TauHadTauHad_V3_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 219 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma1_sigy_ggH_haa_125_TauHadTauHad_V3_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma1_sigy_ggH_haa_125_TauHadTauHad_V3_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 220 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma1_sigy_ggH_haa_125_TauHadTauHad_V3_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma1_sigy_ggH_haa_125_TauHadTauHad_V3_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 221 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma1_sigy_ggH_haa_125_TauMuTauE_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma1_sigy_ggH_haa_125_TauMuTauE_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 222 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma1_sigy_ggH_haa_125_TauMuTauE_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma1_sigy_ggH_haa_125_TauMuTauE_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 223 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma1_sigy_ggH_haa_125_TauMuTauE_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma1_sigy_ggH_haa_125_TauMuTauE_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 224 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma1_sigy_ggH_haa_125_TauMuTauHad_V2_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma1_sigy_ggH_haa_125_TauMuTauHad_V2_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 225 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma1_sigy_ggH_haa_125_TauMuTauHad_V2_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma1_sigy_ggH_haa_125_TauMuTauHad_V2_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 226 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma1_sigy_ggH_haa_125_TauMuTauHad_V2_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma1_sigy_ggH_haa_125_TauMuTauHad_V2_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 227 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma1_sigy_ggH_haa_125_TauMuTauMu_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma1_sigy_ggH_haa_125_TauMuTauMu_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 228 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma1_sigy_ggH_haa_125_TauMuTauMu_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma1_sigy_ggH_haa_125_TauMuTauMu_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 229 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma1_sigy_ggH_haa_125_TauMuTauMu_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma1_sigy_ggH_haa_125_TauMuTauMu_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 230 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma2_sigy_ggH_haa_125_TauETauHad_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma2_sigy_ggH_haa_125_TauETauHad_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 231 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma2_sigy_ggH_haa_125_TauETauHad_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma2_sigy_ggH_haa_125_TauETauHad_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 232 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma2_sigy_ggH_haa_125_TauETauHad_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma2_sigy_ggH_haa_125_TauETauHad_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 233 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma2_sigy_ggH_haa_125_TauHadTauHad_V3_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma2_sigy_ggH_haa_125_TauHadTauHad_V3_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 234 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma2_sigy_ggH_haa_125_TauHadTauHad_V3_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma2_sigy_ggH_haa_125_TauHadTauHad_V3_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 235 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma2_sigy_ggH_haa_125_TauHadTauHad_V3_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma2_sigy_ggH_haa_125_TauHadTauHad_V3_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 236 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma2_sigy_ggH_haa_125_TauMuTauE_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma2_sigy_ggH_haa_125_TauMuTauE_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 237 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma2_sigy_ggH_haa_125_TauMuTauE_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma2_sigy_ggH_haa_125_TauMuTauE_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 238 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma2_sigy_ggH_haa_125_TauMuTauE_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma2_sigy_ggH_haa_125_TauMuTauE_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 239 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma2_sigy_ggH_haa_125_TauMuTauHad_V2_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma2_sigy_ggH_haa_125_TauMuTauHad_V2_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 240 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma2_sigy_ggH_haa_125_TauMuTauHad_V2_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma2_sigy_ggH_haa_125_TauMuTauHad_V2_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 241 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma2_sigy_ggH_haa_125_TauMuTauHad_V2_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma2_sigy_ggH_haa_125_TauMuTauHad_V2_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 242 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma2_sigy_ggH_haa_125_TauMuTauMu_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma2_sigy_ggH_haa_125_TauMuTauMu_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 243 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma2_sigy_ggH_haa_125_TauMuTauMu_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma2_sigy_ggH_haa_125_TauMuTauMu_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 244 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma2_sigy_ggH_haa_125_TauMuTauMu_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma2_sigy_ggH_haa_125_TauMuTauMu_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 245 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma_sigx_ggH_haa_125_TauETauHad_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma_sigx_ggH_haa_125_TauETauHad_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 246 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma_sigx_ggH_haa_125_TauETauHad_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma_sigx_ggH_haa_125_TauETauHad_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 247 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma_sigx_ggH_haa_125_TauETauHad_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma_sigx_ggH_haa_125_TauETauHad_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 248 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma_sigx_ggH_haa_125_TauHadTauHad_V3_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma_sigx_ggH_haa_125_TauHadTauHad_V3_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 249 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma_sigx_ggH_haa_125_TauHadTauHad_V3_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma_sigx_ggH_haa_125_TauHadTauHad_V3_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 250 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma_sigx_ggH_haa_125_TauHadTauHad_V3_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma_sigx_ggH_haa_125_TauHadTauHad_V3_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 251 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma_sigx_ggH_haa_125_TauMuTauE_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma_sigx_ggH_haa_125_TauMuTauE_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 252 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma_sigx_ggH_haa_125_TauMuTauE_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma_sigx_ggH_haa_125_TauMuTauE_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 253 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma_sigx_ggH_haa_125_TauMuTauE_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma_sigx_ggH_haa_125_TauMuTauE_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 254 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma_sigx_ggH_haa_125_TauMuTauHad_V2_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma_sigx_ggH_haa_125_TauMuTauHad_V2_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 255 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma_sigx_ggH_haa_125_TauMuTauHad_V2_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma_sigx_ggH_haa_125_TauMuTauHad_V2_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 256 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma_sigx_ggH_haa_125_TauMuTauHad_V2_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma_sigx_ggH_haa_125_TauMuTauHad_V2_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 257 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma_sigx_ggH_haa_125_TauMuTauMu_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma_sigx_ggH_haa_125_TauMuTauMu_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 258 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma_sigx_ggH_haa_125_TauMuTauMu_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma_sigx_ggH_haa_125_TauMuTauMu_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 259 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_sigma_sigx_ggH_haa_125_TauMuTauMu_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_sigma_sigx_ggH_haa_125_TauMuTauMu_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 260 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_width_sigx_ggH_haa_125_TauETauHad_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_width_sigx_ggH_haa_125_TauETauHad_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 261 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_width_sigx_ggH_haa_125_TauETauHad_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_width_sigx_ggH_haa_125_TauETauHad_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 262 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_width_sigx_ggH_haa_125_TauETauHad_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_width_sigx_ggH_haa_125_TauETauHad_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 263 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_width_sigx_ggH_haa_125_TauHadTauHad_V3_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_width_sigx_ggH_haa_125_TauHadTauHad_V3_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 264 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_width_sigx_ggH_haa_125_TauHadTauHad_V3_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_width_sigx_ggH_haa_125_TauHadTauHad_V3_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 265 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_width_sigx_ggH_haa_125_TauHadTauHad_V3_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_width_sigx_ggH_haa_125_TauHadTauHad_V3_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 266 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_width_sigx_ggH_haa_125_TauMuTauE_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_width_sigx_ggH_haa_125_TauMuTauE_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 267 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_width_sigx_ggH_haa_125_TauMuTauE_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_width_sigx_ggH_haa_125_TauMuTauE_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 268 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_width_sigx_ggH_haa_125_TauMuTauE_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_width_sigx_ggH_haa_125_TauMuTauE_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 269 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_width_sigx_ggH_haa_125_TauMuTauHad_V2_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_width_sigx_ggH_haa_125_TauMuTauHad_V2_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 270 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_width_sigx_ggH_haa_125_TauMuTauHad_V2_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_width_sigx_ggH_haa_125_TauMuTauHad_V2_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 271 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_width_sigx_ggH_haa_125_TauMuTauHad_V2_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_width_sigx_ggH_haa_125_TauMuTauHad_V2_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 272 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_width_sigx_ggH_haa_125_TauMuTauMu_2016_PP --algo impact --redefineSignalPOIs r -P uncrt_width_sigx_ggH_haa_125_TauMuTauMu_2016_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 273 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_width_sigx_ggH_haa_125_TauMuTauMu_2017_PP --algo impact --redefineSignalPOIs r -P uncrt_width_sigx_ggH_haa_125_TauMuTauMu_2017_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 274 ]; then
  combine -M MultiDimFit -n _paramFit_Test_uncrt_width_sigx_ggH_haa_125_TauMuTauMu_2018_PP --algo impact --redefineSignalPOIs r -P uncrt_width_sigx_ggH_haa_125_TauMuTauMu_2018_PP --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 275 ]; then
  combine -M MultiDimFit -n _paramFit_Test_width_jpsi1S_2016 --algo impact --redefineSignalPOIs r -P width_jpsi1S_2016 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 276 ]; then
  combine -M MultiDimFit -n _paramFit_Test_width_jpsi1S_2017 --algo impact --redefineSignalPOIs r -P width_jpsi1S_2017 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 277 ]; then
  combine -M MultiDimFit -n _paramFit_Test_width_jpsi1S_2018 --algo impact --redefineSignalPOIs r -P width_jpsi1S_2018 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 278 ]; then
  combine -M MultiDimFit -n _paramFit_Test_width_jpsi2S_2016 --algo impact --redefineSignalPOIs r -P width_jpsi2S_2016 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 279 ]; then
  combine -M MultiDimFit -n _paramFit_Test_width_jpsi2S_2017 --algo impact --redefineSignalPOIs r -P width_jpsi2S_2017 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi
if [ $1 -eq 280 ]; then
  combine -M MultiDimFit -n _paramFit_Test_width_jpsi2S_2018 --algo impact --redefineSignalPOIs r -P width_jpsi2S_2018 --floatOtherPOIs 1 --saveInactivePOI 1 --unbinned --freezeParameters MA --setParameterRanges MA=7.5,7.5 -t -1 --expectSignal=1 --robustFit 1 -m 125 -d mmmt_mm_h_parametric_unbinned_lowmass_allchs_hm125_amX.root --setParameters MA=7.5
fi