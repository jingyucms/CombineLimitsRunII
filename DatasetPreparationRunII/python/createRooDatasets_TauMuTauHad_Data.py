#!/usr/bin/python
import ROOT
from ROOT import RooFit
import os

fakebaseDir='/afs/cern.ch/user/f/fengwang/workplace/public/ForRedwan/fakeRate/'
baseDir = "/afs/cern.ch/user/f/fengwang/workplace/public/ForRedwan/sidebandFilesAndTransferFactors/"
outputDir= "/afs/cern.ch/user/f/fengwang/workplace/CombinedLimits/CMSSW_10_2_18/src/CombineLimitsRunII/outputRooDataset/TauMuTauHad_V2/"

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
    fin=ROOT.TFile(baseDir+y+"/data_0.832.root")
    treein = fin.Get("TreeMuTau")
    invMassMuMu = ROOT.RooRealVar("invMassMuMu", "invMassMuMu", 2.5, 60)
    visFourbodyMass = ROOT.RooRealVar("visFourbodyMass", "visFourbodyMass", 0, 1200)

    for j, jsyst in enumerate(systSF):
        globals()["fakeRateEfficiency" + str(j)] = ROOT.RooRealVar("fakeRateEfficiency", "fakeRateEfficiency", 0, 2)
        globals()["dataColl" + str(j)] = ROOT.RooDataSet("dataColl", "dataColl", ROOT.RooArgSet(invMassMuMu, visFourbodyMass, globals()["fakeRateEfficiency" + str(j)]))
        globals()["weight" + str(j)] = ROOT.RooRealVar("weight", "weight", 0, 2)
        globals()["dataCollcopy" + str(j)] = ROOT.RooDataSet("dataColl", "dataColl", ROOT.RooArgSet(invMassMuMu, visFourbodyMass, globals()["weight" + str(j)]))

    for event in treein:
        for id,d in enumerate(dmodes):
            finFakeEff = ROOT.TFile(fakebaseDir+y+"/"+"fakeTauEff_TauMuTauHad.root")
            histFakeEff = ROOT.TH1D()
            histFakeEff = finFakeEff.Get(d)
            nbins = histFakeEff.GetNbinsX()

            for ibin in xrange(nbins):
                binlowEdge = histFakeEff.GetXaxis().GetBinLowEdge(ibin+1)
                binhighEdge = histFakeEff.GetXaxis().GetBinLowEdge(ibin+1) + histFakeEff.GetXaxis().GetBinWidth(ibin+1)
                if event.tauDM_mt == dmodematch[d] and (event.tauPt_mt >= binlowEdge and event.tauPt_mt < binhighEdge):
                    for j,jsyst in enumerate(systSF):
                        fakeEff = histFakeEff.GetBinContent(ibin+1)/(1.0-histFakeEff.GetBinContent(ibin+1))
                        globals()["fakeRateEfficiency" + str(j)].setVal(fakeEff*systSF[j])
                        globals()["weight" + str(j)].setVal(systSF[j])
        if event.mu2Pt_mt > event.mu3Pt_mt and event.invMassMu1Mu2_mt > event.visMassMu3Tau_mt:
            invMassMuMu.setVal(event.invMassMu1Mu2_mt)
            visFourbodyMass.setVal(event.visMass3MuTau_mt)
            for j,jsyst in enumerate(systSF):
                globals()["dataColl" + str(j)].add(ROOT.RooArgSet(invMassMuMu, visFourbodyMass, globals()["fakeRateEfficiency" + str(j)]))
                globals()["dataCollcopy" + str(j)].add(ROOT.RooArgSet(invMassMuMu, visFourbodyMass, globals()["weight" + str(j)]))

    outputpath = outputDir+y+"/"+"DataDriven/"
    if not os.path.exists(outputpath):
        os.makedirs(outputpath)

    for j,jsyst in enumerate(systSF):
        globals()["fout" + str(j)] = ROOT.TFile(outputDir+y+"/"+"DataDriven/"+"TauMuTauHad_V2" + "_"+y+"_MVAMedium_" +"signalRegion_" + systLabel[j] + ".root", "RECREATE")
        globals()["dataColl" + str(j)].Write()
        globals()["fout" + str(j)].Close()

        globals()["foutcopy" + str(j)] = ROOT.TFile(outputDir+y+"/"+"DataDriven/"+"TauMuTauHad_V2" + "_"+y+"_MVAMedium_" +"sideBand_" + systLabel[j] + ".root", "RECREATE")
        globals()["dataCollcopy" + str(j)].Write()
        globals()["foutcopy" + str(j)].Close()

exit()
