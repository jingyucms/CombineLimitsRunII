#!/usr/bin/python
import ROOT
from ROOT import RooFit
import os

outDir="/afs/cern.ch/user/f/fengwang/workplace/CombinedLimits/CMSSW_10_2_18/src/CombineLimitsRunII/outputRooDataset/control/"

baseDir = "/afs/cern.ch/user/f/fengwang/workplace/public/ForRedwan/controlRegion/"

years=["2016", "2017", "2018"]  #["2016","2017",

for iy,y in enumerate(years):
    #fname = baseDir+y+"/Histogram/"+"control_"+y+".root"
    fname = baseDir + "data_" + y + ".root"
    print fname
    globals()["fin"+ y]=ROOT.TFile(fname)
    globals()["treein"+ y]=globals()["fin" + y].Get("TreeMuMuTauTau")
    globals()["dimuMass"+ y] = ROOT.RooRealVar("invMassMuMu","invMassMuMu",2.5,60)
    globals()["dataColl" + y] = ROOT.RooDataSet("dataColl", "dataColl", ROOT.RooArgSet(globals()["dimuMass" + y]))
    for event in globals()["treein" + y]:
                    if (event.invMassMuMu) < 2.5: continue
                    globals()["dimuMass" + y].setVal(event.invMassMuMu)
                    globals()["dataColl" + y].add(ROOT.RooArgSet(globals()["dimuMass" + y]))
    print y,"==done=="

    outputpath = outDir+y
    if not os.path.exists(outputpath):
        os.makedirs(outputpath)

    globals()["fout"+ y]=ROOT.TFile(outDir+y+"/"+"control_RooDataset_"+y+".root","RECREATE")
    globals()["dataColl" + y].Write()
    globals()["fout"+ y].Close()
