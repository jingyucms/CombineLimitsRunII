#!/usr/bin/python
import ROOT
from ROOT import RooFit
import os

channel = "TauHadTauHad_V3"

fakebaseDir='/afs/cern.ch/user/f/fengwang/workplace/public/ForRedwan/sidebandFilesAndTransferFactors/'
baseDir = "/afs/cern.ch/user/f/fengwang/workplace/public/ForRedwan/sidebandFilesAndTransferFactors/"
outputDir= "/afs/cern.ch/user/f/fengwang/workplace/CombinedLimits/CMSSW_10_2_18/src/CombineLimitsRunII/outputRooDataset/"+channel+"/"

years=["2016","2017","2018"]
disc=["DeepDiTauDCM=0.832;1"]

dmodematch={
    "decayMode0":0.0,
    "decayMode1":1.0,
    "decayMode10":10.0
}

systLabel = ["fakeUp", "nominal", "fakeDown"]
systSF = [1.1, 1, 0.9]

for iy,y in enumerate(years):
    fin=ROOT.TFile(baseDir+y+"/data_0.832.root")
    treein = fin.Get("TreeTauTau")

    invMassMuMu = ROOT.RooRealVar("invMassMuMu", "invMassMuMu", 2.5, 60)
    visFourbodyMass = ROOT.RooRealVar("visFourbodyMass", "visFourbodyMass", 0, 2000)

    for j, jsyst in enumerate(systSF):
        globals()["fakeRateEfficiency" + str(j)] = ROOT.RooRealVar("fakeRateEfficiency", "fakeRateEfficiency", 0, 4)
        globals()["dataColl" + str(j)] = ROOT.RooDataSet("dataColl", "dataColl", ROOT.RooArgSet(invMassMuMu, visFourbodyMass, globals()["fakeRateEfficiency" + str(j)]))

    for event in treein:
        for id,d in enumerate(disc):
            finFakeEff = ROOT.TFile(fakebaseDir+y+"/"+"fakeTauEff_TauHadTauHad.root")
            histFakeEff = ROOT.TH1D()
            histFakeEff = finFakeEff.Get(d)
            nbins = histFakeEff.GetNbinsX()

            for ibin in xrange(nbins):
                binlowEdge = histFakeEff.GetXaxis().GetBinLowEdge(ibin+1)
                binhighEdge = histFakeEff.GetXaxis().GetBinLowEdge(ibin+1) + histFakeEff.GetXaxis().GetBinWidth(ibin+1)
                if (event.tauPt_tt >= binlowEdge and event.tauPt_tt < binhighEdge):
                    for j,jsyst in enumerate(systSF):
                        fakeEff = histFakeEff.GetBinContent(ibin+1)/(1.0-histFakeEff.GetBinContent(ibin+1))
                        globals()["fakeRateEfficiency" + str(j)].setVal(fakeEff*systSF[j])
        if event.tauDisc_tt > 0.688:
            #print "here!"
            invMassMuMu.setVal(event.invMassMu1Mu2_tt)
            visFourbodyMass.setVal(event.visMass2Mu2Tau_tt)
            for j,jsyst in enumerate(systSF):
                globals()["dataColl" + str(j)].add(ROOT.RooArgSet(invMassMuMu, visFourbodyMass, globals()["fakeRateEfficiency" + str(j)]))

    outputpath = outputDir+y+"/"+"DataDriven/"
    if not os.path.exists(outputpath):
        os.makedirs(outputpath)

    for j,jsyst in enumerate(systSF):
        globals()["fout" + str(j)] = ROOT.TFile(outputDir+y+"/"+"DataDriven/"+channel + "_"+y+"_MVAMedium_" +"signalRegion_" + systLabel[j] + ".root", "RECREATE")
        globals()["dataColl" + str(j)].Write()
        globals()["fout" + str(j)].Close()

        globals()["foutcopy" + str(j)] = ROOT.TFile(outputDir+y+"/"+"DataDriven/"+channel + "_"+y+"_MVAMedium_" +"sideBand_" + systLabel[j] + ".root", "RECREATE")
        globals()["dataColl" + str(j)].Write()
        globals()["foutcopy" + str(j)].Close()

    # for unblind
    # for event in treeinSignal:
    #     if event.tauDisc_tt >0.3:
    #         invMassMuMu.setVal(event.invMassMu1Mu2_tt)
    #         visFourbodyMass.setVal(event.visMass2Mu2Tau_tt)
    #         #fakeRateEfficiency.setVal(1.0)
    #         dataCollSignal.add(ROOT.RooArgSet(invMassMuMu, visFourbodyMass, fakeRateEfficiency))
exit()
