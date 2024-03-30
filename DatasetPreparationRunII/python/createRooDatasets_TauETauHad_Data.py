#!/usr/bin/python
import ROOT
from ROOT import RooFit
import os

fakebaseDir='/afs/cern.ch/user/f/fengwang/workplace/public/ForRedwan/fakeRate/'
baseDir = "/afs/cern.ch/user/f/fengwang/workplace/public/ForRedwan/sidebandFilesAndTransferFactors/"
outputDir= "/afs/cern.ch/user/f/fengwang/workplace/CombinedLimits/CMSSW_10_2_18/src/CombineLimitsRunII/outputRooDataset/TauETauHad/"

years=["2016","2017","2018"]
dmodes=["decayMode0","decayMode1","decayMode10"]

dmodematch={
    "decayMode0":0.0,
    "decayMode1":1.0,
    "decayMode10":10.0
}

systLabel = ["fakeUp", "nominal", "fakeDown"]
systSF = [1.2, 1, 0.8]

for iy,y in enumerate(years):
    fname = baseDir+y+"/data_0.832.root"
    fin=ROOT.TFile(fname)
    treein = fin.Get("TreeEleTau")
    invMassMuMu = ROOT.RooRealVar("invMassMuMu", "invMassMuMu", 2.5, 60)
    visFourbodyMass = ROOT.RooRealVar("visFourbodyMass", "visFourbodyMass", 0, 2000)

    for j, jsyst in enumerate(systSF):
        globals()["fakeRateEfficiency" + str(j)] = ROOT.RooRealVar("fakeRateEfficiency", "fakeRateEfficiency", 0, 2)
        globals()["dataColl" + str(j)] = ROOT.RooDataSet("dataColl", "dataColl", ROOT.RooArgSet(invMassMuMu, visFourbodyMass, globals()["fakeRateEfficiency" + str(j)]))

    for event in treein:
        if event.elePt_et < 6.0:
            continue
        for id,d in enumerate(dmodes):
            finFakeEff = ROOT.TFile(fakebaseDir+y+"/"+"fakeTauEff_TauETauHad.root")
            histFakeEff = ROOT.TH1D()
            histFakeEff = finFakeEff.Get(d)
            nbins = histFakeEff.GetNbinsX()

            for ibin in xrange(nbins):
                binlowEdge = histFakeEff.GetXaxis().GetBinLowEdge(ibin+1)
                binhighEdge = histFakeEff.GetXaxis().GetBinLowEdge(ibin+1) + histFakeEff.GetXaxis().GetBinWidth(ibin+1)
                if event.tauDM_et == dmodematch[d] and (event.tauPt_et >= binlowEdge and event.tauPt_et < binhighEdge):
                    for j,jsyst in enumerate(systSF):
                        fakeEff = histFakeEff.GetBinContent(ibin+1)/(1.0-histFakeEff.GetBinContent(ibin+1))
                        globals()["fakeRateEfficiency" + str(j)].setVal(fakeEff*systSF[j])
        if event.invMassMu1Mu2_et > event.visMassEleTau_et:
            invMassMuMu.setVal(event.invMassMu1Mu2_et)
            visFourbodyMass.setVal(event.visMass2MuEleTau_et)
            for j,jsyst in enumerate(systSF):
                globals()["dataColl" + str(j)].add(ROOT.RooArgSet(invMassMuMu, visFourbodyMass, globals()["fakeRateEfficiency" + str(j)]))

    outputpath = outputDir+y+"/"+"DataDriven/"
    if not os.path.exists(outputpath):
        os.makedirs(outputpath)

    for j,jsyst in enumerate(systSF):
        globals()["fout" + str(j)] = ROOT.TFile(outputDir+y+"/"+"DataDriven/"+"TauETauHad" + "_"+y+"_MVAMedium_" +"signalRegion_" + systLabel[j] + ".root", "RECREATE")
        globals()["dataColl" + str(j)].Write()
        globals()["fout" + str(j)].Close()

        globals()["foutcopy" + str(j)] = ROOT.TFile(outputDir+y+"/"+"DataDriven/"+"TauETauHad" + "_"+y+"_MVAMedium_" +"sideBand_" + systLabel[j] + ".root", "RECREATE")
        globals()["dataColl" + str(j)].Write()
        globals()["foutcopy" + str(j)].Close()

exit()
