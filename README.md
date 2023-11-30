# CombineLimits
Standalone limits to run with combine in the CMSSW framework

## Setup

```bash
setenv SCRAM_ARCH slc7_amd64_gcc700
cmsrel CMSSW_10_2_13
cd CMSSW_10_2_13/src
cmsenv
git cms-init
git clone git@github.com:jingyucms/CombineLimitsRunII.git
./CombineLimitsRunII/recipe/recipe.sh
scramv1 b clean; scramv1 b 
```

## To produce datacard, 
```bash
cd CombineLimitsRunII/HaaLimits/python/
./run_fit.csh
```
