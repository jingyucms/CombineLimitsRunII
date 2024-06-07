#!/usr/bin/python
import ROOT
from ROOT import RooFit
import os

baseDir="/afs/cern.ch/user/f/fengwang/workplace/public/ForRedwan/JECTrees/"
outDir="/afs/cern.ch/user/f/fengwang/workplace/CombinedLimits/CMSSW_10_2_18/src/CombineLimitsRunII/outputRooDataset/TauETauHad/"

scale =0.001
higgs_SM_xsec=48.58
higgs_BSM_xsec=0.0363647

fakerateUncertainty=0.20
scaleUp=1.0+fakerateUncertainty
scaleDown=1.0-fakerateUncertainty

years=["2016","2017","2018"]

lumi_map={"2017":41.529*1000,
          "2016":35.92*1000,
          "2018":59.74*1000
}

hXsecmap={"hm125":48.58,
          "hm250":10.2,
          "hm500":1.7089,
          "hm750":0.4969,
          "hm1000":0.1845


}


mh=["hm125","hm250","hm500","hm750","hm1000"]
#mh = ["hm125", "hm1000"]
hamap ={
    "hm125":["am3p6","am4","am5","am6","am7","am8","am9","am10","am11","am12","am13","am14","am15","am16","am17","am18","am19","am20","am21"], #am4 missing in 2018 so left out for now
    "hm250":["am5","am10","am15","am20"],
    "hm500":["am5","am10","am15","am20"],
    "hm750":["am10","am15","am20","am25","am30"],
    "hm1000":["am10","am20","am30","am40"]
}

regions = ["FP", "PP"]
regionsTag = {"FP":"sideBand", "PP":"signalRegion"}

sfmaplow={
    "2016":{"nominal":0.63,"scaleUp":0.74,"scaleDown":0.52},
    "2017":{"nominal":1.00,"scaleUp":1.11,"scaleDown":0.89},
    "2018":{"nominal":0.94,"scaleUp":1.02,"scaleDown":0.86}
}


sfmaphigh={
    "2016":{"nominal":0.92,"scaleUp":0.96,"scaleDown":0.88},
    "2017":{"nominal":0.82,"scaleUp":0.86,"scaleDown":0.78},
    "2018":{"nominal":0.78,"scaleUp":0.82,"scaleDown":0.74}
}


for y in years:
    outputpath = outDir+y+"/SignalMC/"
    if not os.path.exists(outputpath):
        os.makedirs(outputpath)
    for h in mh:
        for ia,a in enumerate(hamap[h]):
            for ir,r in enumerate(regions):
                fname= baseDir+y+"/"+r+"/"+h+"/"+a+"/HAA_MC_JECSyst_0.root"
                print a,ir,y,lumi_map[y]
                print fname
                globals()["fin"+ a+ r]=ROOT.TFile(fname)
                globals()["treein"+ a+ r]=globals()["fin" + a + r].Get("TreeEleTau")
                globals()["dimuMass" + a + r] = ROOT.RooRealVar("invMassMuMu","invMassMuMu",2.5,60)
                globals()["visFourbodyMass" + a + r] = ROOT.RooRealVar("visFourbodyMass", "visFourbodyMass", 0, 2000)
                globals()["eventWeight" + a + r] = ROOT.RooRealVar("eventWeight", "eventWeight", -1, 1)
                globals()["dataColl" + a + r] = ROOT.RooDataSet("dataColl", "dataColl", ROOT.RooArgSet(globals()["dimuMass" + a + r], globals()["visFourbodyMass" + a + r], globals()["eventWeight" + a + r]))
                globals()["dataCollUp" + a + r] = ROOT.RooDataSet("dataColl", "dataColl", ROOT.RooArgSet(globals()["dimuMass" + a + r], globals()["visFourbodyMass" + a + r], globals()["eventWeight" + a + r]))
                globals()["dataCollDown" + a + r] = ROOT.RooDataSet("dataColl", "dataColl", ROOT.RooArgSet(globals()["dimuMass" + a + r], globals()["visFourbodyMass" + a + r], globals()["eventWeight" + a + r]))
                print "nominal"
                for event in globals()["treein" + a + r]:
                    if event.elePt_et < 6.0:
                        continue
                    if event.invMassMu1Mu2_et > event.visMassEleTau_et:
                        globals()["dimuMass" + a + r].setVal(event.invMassMu1Mu2_et)
                        globals()["visFourbodyMass" + a + r].setVal(event.visMass2MuEleTau_et)
                        if event.tauPt_et > 10 and event.tauPt_et < 20:
                            #print "low sf nominal:",sfmaplow[y]["nominal"],event.eventWeight_et*scale*lumi_map[y]*hXsecmap[h]*sfmaplow[y]["nominal"]
                            globals()["eventWeight" + a + r].setVal(event.eventWeight_et*scale*lumi_map[y]*hXsecmap[h]*sfmaplow[y]["nominal"])

                        if event.tauPt_et > 20 and event.tauPt_et < 10000:
                            #print "high sf nominal:",sfmaphigh[y]["nominal"],event.eventWeight_et*scale*lumi_map[y]*hXsecmap[h]*sfmaphigh[y]["nominal"]
                            globals()["eventWeight" + a + r].setVal(event.eventWeight_et*scale*lumi_map[y]*hXsecmap[h]*sfmaphigh[y]["nominal"])
                        globals()["dataColl" + a + r].add(ROOT.RooArgSet(globals()["dimuMass" + a + r], globals()["visFourbodyMass" + a + r], globals()["eventWeight" + a + r]))
                globals()["fout"+ a + r]=ROOT.TFile(outDir+y+"/SignalMC/"+"Haa_MC_"+h+"_"+a+"_"+"TauETauHad"+"_"+y+"_"+"MVAMedium"+"_"+regionsTag[r]+"_"+"nominal.root","RECREATE")
                print outDir+y+"/signalMC/"+"Haa_MC_"+h+"_"+a+"_"+"TauETauHad"+"_"+y+"_"+"MVAMedium"+"_"+regionsTag[r]+"_"+"nominal.root"
                globals()["dataColl" + a + r].Write()
                globals()["fout"+ a + r].Close()

                print "tauScaleUp"

                for event in globals()["treein" + a + r]:
                    if event.elePt_et < 6.0:
                        continue
                    #if event.mu2Pt_mt > event.mu3Pt_mt:
                    if event.invMassMu1Mu2_et > event.visMassEleTau_et:
                        globals()["dimuMass" + a + r].setVal(event.invMassMu1Mu2_et)
                        globals()["visFourbodyMass" + a + r].setVal(event.visMass2MuEleTau_et)
                        if event.tauPt_et > 10 and event.tauPt_et < 20:
                            #print "low sfscaleUp:",sfmaplow[y]["scaleUp"],event.eventWeight_et*scale*lumi_map[y]*hXsecmap[h]*sfmaplow[y]["scaleUp"]
                            globals()["eventWeight" + a + r].setVal(event.eventWeight_et*scale*lumi_map[y]*hXsecmap[h]*sfmaplow[y]["scaleUp"])
                        if event.tauPt_et > 20 and event.tauPt_et < 10000:
                            #print "high sf scaleUp:",sfmaphigh[y]["scaleUp"],event.eventWeight_et*scale*lumi_map[y]*hXsecmap[h]*sfmaphigh[y]["scaleUp"]
                            globals()["eventWeight" + a + r].setVal(event.eventWeight_et*scale*lumi_map[y]*hXsecmap[h]*sfmaphigh[y]["scaleUp"])
                        globals()["dataCollUp" + a + r].add(ROOT.RooArgSet(globals()["dimuMass" + a + r], globals()["visFourbodyMass" + a + r], globals()["eventWeight" + a + r]))
                globals()["foutUp"+ a + r]=ROOT.TFile(outDir+y+"/SignalMC/"+"Haa_MC_"+h+"_"+a+"_"+"TauETauHad"+"_"+y+"_"+"MVAMedium"+"_"+regionsTag[r]+"_"+"tauScaleUp.root","RECREATE")
                print outDir+y+"/signalMC/"+"Haa_MC_"+h+"_"+a+"_"+"TauETauHad"+"_"+y+"_"+"MVAMedium"+"_"+regionsTag[r]+"_"+"tauScaleUp.root"
                globals()["dataCollUp" + a + r].Write()
                globals()["foutUp"+ a + r].Close()

                print "tauScaleDown"

                for event in globals()["treein" + a + r]:
                    if event.elePt_et < 6.0:
                        continue
                    if event.invMassMu1Mu2_et > event.visMassEleTau_et:
                        globals()["dimuMass" + a + r].setVal(event.invMassMu1Mu2_et)
                        globals()["visFourbodyMass" + a + r].setVal(event.visMass2MuEleTau_et)
                        if event.tauPt_et > 10 and event.tauPt_et < 20:
                            #print "low sf scaleDown:",sfmaplow[y]["scaleDown"],event.eventWeight_et*scale*lumi_map[y]*hXsecmap[h]*sfmaplow[y]["scaleDown"]
                            globals()["eventWeight" + a + r].setVal(event.eventWeight_et*scale*lumi_map[y]*hXsecmap[h]*sfmaplow[y]["scaleDown"])
                        if event.tauPt_et > 20 and event.tauPt_et < 10000:
                            #print "high sf scaleDown:",sfmaphigh[y]["scaleDown"],event.eventWeight_et*scale*lumi_map[y]*hXsecmap[h]*sfmaphigh[y]["scaleDown"]
                            globals()["eventWeight" + a + r].setVal(event.eventWeight_et*scale*lumi_map[y]*hXsecmap[h]*sfmaphigh[y]["scaleDown"])
                        globals()["dataCollDown" + a + r].add(ROOT.RooArgSet(globals()["dimuMass" + a + r], globals()["visFourbodyMass" + a + r], globals()["eventWeight" + a + r]))
                globals()["foutDown"+ a + r]=ROOT.TFile(outDir+y+"/SignalMC/"+"Haa_MC_"+h+"_"+a+"_"+"TauETauHad"+"_"+y+"_"+"MVAMedium"+"_"+regionsTag[r]+"_"+"tauScaleDown.root","RECREATE")
                print outDir+y+"/signalMC/"+"Haa_MC_"+h+"_"+a+"_"+"TauETauHad"+"_"+y+"_"+"MVAMedium"+"_"+regionsTag[r]+"_"+"tauScaleDown.root"
                globals()["dataCollDown" + a + r].Write()
                globals()["foutDown"+ a + r].Close()

exit()
