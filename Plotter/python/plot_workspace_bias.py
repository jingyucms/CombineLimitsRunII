import os, sys
import json

import ROOT
ROOT.gROOT.SetBatch(ROOT.kTRUE)

import CombineLimitsRunII.Plotter.CMS_lumi as CMS_lumi
import CombineLimitsRunII.Plotter.tdrstyle as tdrstyle

sys.path.append(r'/Users/chris/ModulesAndPackages')

ROOT.gROOT.ProcessLine("gErrorIgnoreLevel = 2001;")
tdrstyle.setTDRStyle()

isprelim = True
yvar = 'h'
h = 125
xVar = 'invMassMuMu'
yVar = 'visFourbodyMass'
#massRange = 'lowmass'
#massRange = 'upsilon'
massRange = 'highmass'
if massRange == 'lowmass':
    xRange = [2.5,8.5]
    xBinWidth = 0.1
    a = 5
elif massRange == 'upsilon':
    xRange = [6,14]
    xBinWidth = 0.1
    a = 11
elif massRange == 'highmass':
    xRange = [11,45]
    xBinWidth = 0.5
    a = 30

year='2018'

yRange = [0,1200]
yBinWidth = 10
blind = False
br = 0.0005
doPostfit = False

amasses = ['3p6','5','9','13','17','21']
colors = [ROOT.kBlue-4, ROOT.kCyan+1, ROOT.kGreen+1, ROOT.kOrange-3, ROOT.kRed+1, ROOT.kMagenta+1]


##jfile = '../../HaaLimits/python/fitParams/HaaLimits2D_unbinned_{}/{}_TauHadTauHad_V3_{}_MVAMedium_DG_DoubleExpo_yRange_wFakeJECFit_PPonly/background_TauHadTauHad_V3_{}_PP.json'.format(yvar,massRange,year,year)
##with open(jfile,'r') as f:
##    results = json.load(f)
##
##jfile_fakeUp = '../../HaaLimits/python/fitParams/HaaLimits2D_unbinned_{}/{}_TauHadTauHad_V3_{}_MVAMedium_DG_DoubleExpo_yRange_wFakeJECFit_PPonly/background_TauHadTauHad_V3_{}_PP_fakeUp.json'.format(yvar,massRange,year,year)
##with open(jfile_fakeUp,'r') as f:
##    results_fakeUp = json.load(f)
##
##jfile_fakeDown = '../../HaaLimits/python/fitParams/HaaLimits2D_unbinned_{}/{}_TauHadTauHad_V3_{}_MVAMedium_DG_DoubleExpo_yRange_wFakeJECFit_PPonly/background_TauHadTauHad_V3_{}_PP_fakeDown.json'.format(yvar,massRange,year,year)
##with open(jfile_fakeDown,'r') as f:
##    results_fakeDown = json.load(f)



rfile1 = '../../HaaLimits/python/datacards_shape/MuMuTauTau/mmmt_mm_{}_parametric_unbinned_{}_TauHadTauHad_V3_{}_MVAMedium_DG_DoubleExpo_yRange_wFakeJECFit_PPonly.root'.format(yvar,massRange,year)
tfile1 = ROOT.TFile.Open(rfile1)
print rfile1

rfile2 = '../../HaaLimits/python/datacards_shape/MuMuTauTau/mmmt_mm_{}_parametric_unbinned_{}_TauHadTauHad_V3_{}_MVAMedium_DG_DoubleExpo_HHPoly5_yRange_wFakeJECFit_PPonly.root'.format(yvar,massRange,year)
tfile2 = ROOT.TFile.Open(rfile2)
print rfile2

rfile3 = '../../HaaLimits/python/datacards_shape/MuMuTauTau/mmmt_mm_{}_parametric_unbinned_{}_TauHadTauHad_V3_{}_MVAMedium_DG_DoubleExpo_HHDE_yRange_wFakeJECFit_PPonly.root'.format(yvar,massRange,year)
tfile3 = ROOT.TFile.Open(rfile3)
print rfile3

rfile4 = '../../HaaLimits/python/datacards_shape/MuMuTauTau/mmmt_mm_{}_parametric_unbinned_{}_TauHadTauHad_V3_{}_MVAMedium_DG_yRange_wFakeJECFit_PPonly.root'.format(yvar,massRange,year)
tfile4 = ROOT.TFile.Open(rfile4)
print rfile4

rfile5 = '../../HaaLimits/python/datacards_shape/MuMuTauTau/mmmt_mm_{}_parametric_unbinned_{}_TauHadTauHad_V3_{}_MVAMedium_DG_Landau_yRange_wFakeJECFit_PPonly.root'.format(yvar,massRange,year)
tfile5 = ROOT.TFile.Open(rfile5)
print rfile4


ws1 = tfile1.Get('w')
ws2 = tfile2.Get('w')
ws3 = tfile3.Get('w')
ws4 = tfile4.Get('w')
ws5 = tfile5.Get('w')


#uncert = ws.var('uncrt_lambda_conty2_TauHadTauHad_V3_{}_PP_y'.format(year))
#uncert.setVal(-10)

pdf_x1 = ws1.pdf('bg_TauHadTauHad_V3_{}_PP_x'.format(year))
pdf_x2 = ws2.pdf('bg_TauHadTauHad_V3_{}_PP_x'.format(year))
pdf_x3 = ws3.pdf('bg_TauHadTauHad_V3_{}_PP_x'.format(year))
pdf_y1 = ws1.pdf('bg_TauHadTauHad_V3_{}_PP_y'.format(year))
pdf_y2 = ws4.pdf('bg_TauHadTauHad_V3_{}_PP_y'.format(year))
pdf_y3 = ws5.pdf('bg_TauHadTauHad_V3_{}_PP_y'.format(year))

# override values
params = [
    # x
    'lambda_cont1_PP_x',
    'lambda_cont3_PP_x',
    'mean_jpsi1S',
    'sigma_jpsi1S',
    'width_jpsi1S',
    'mean_jpsi2S',
    'sigma_jpsi2S',
    'width_jpsi2S',
    'mean_upsilon1S',
    'sigma_upsilon1S',
    'width_upsilon1S',
    'mean_upsilon2S',
    'sigma_upsilon2S',
    'width_upsilon2S',
    'mean_upsilon3S',
    'sigma_upsilon3S',
    'width_upsilon3S',


    # y
    'lambda_conty1_PP_y',
    'erfShift_erf1_PP_y',
    'erfScale_erf1_PP_y',
]

def floatToText(x):
    s = '{:.1E}'.format(x).split('E')
    return '{} #times 10^{{{}}}'.format(int(float(s[0])),int(s[1]))

data = ws1.data('data_obs_TauHadTauHad_V3_{}_PP'.format(year))
integral = data.sumEntries()

mh = ws1.var('MH')
mh.setVal(h)
ma = ws1.var('MA')
ma.setVal(a)

sig_x = ws1.pdf('ggH_haa_{}_TauHadTauHad_V3_{}_PP_x'.format(h,year))
sig_y = ws1.pdf('ggH_haa_{}_TauHadTauHad_V3_{}_PP_y'.format(h,year))
sig_y_heavy = ws1.pdf('ggH_haa_{}_TauHadTauHad_V3_{}_PP_y'.format(1000,year))

sigintegral = ws1.function('fullIntegral_ggH_haa_{}_TauHadTauHad_V3_{}_PP'.format(h,year)).getVal() * br/0.001
mh.setVal(250)
sigintegral_heavy = ws1.function('fullIntegral_ggH_haa_{}_TauHadTauHad_V3_{}_PP'.format(1000,year)).getVal() * br/0.001

print sigintegral,sigintegral_heavy



################################ x ######################################
x = ws1.var(xVar)
x.setUnit('GeV')
x.setPlotLabel('m(#mu#mu)')
x.SetTitle('m(#mu#mu)')

canvas = ROOT.TCanvas('c','c',800,800)
canvas.Divide(1,1)
canvas.cd()
padDown=ROOT.TPad("","",0,0,1,0.25)
padDown.SetTopMargin(0.035)
padDown.SetBottomMargin(0.4)
padDown.Draw()
canvas.cd()
padUp=ROOT.TPad("","",0,0.25,1,1)
padUp.SetBottomMargin(0.03)
padUp.SetTopMargin(0.07)
padUp.Draw()

xFrame = x.frame()

#uncert = ws.var('TauHadTauHad_V3_{}_fake'.format(year))
#uncert.setVal(-1)
#pdf_x.plotOn(xFrame,ROOT.RooFit.Normalization(integral_fakeDown),ROOT.RooFit.LineColor(ROOT.kOrange+1), ROOT.RooFit.LineStyle(ROOT.kDashed), ROOT.RooFit.Name('Fake'))
#uncert.setVal(1)
#pdf_x.plotOn(xFrame,ROOT.RooFit.Normalization(integral_fakeUp),ROOT.RooFit.LineColor(ROOT.kOrange+1), ROOT.RooFit.LineStyle(ROOT.kDashed))
sig_x.plotOn(xFrame,ROOT.RooFit.Normalization(sigintegral),ROOT.RooFit.LineColor(ROOT.kRed))#,ROOT.RooFit.NormRange("fullrange"),ROOT.RooFit.Range("range"))
#uncert.setVal(0)

pdf_x2.plotOn(xFrame,ROOT.RooFit.Normalization(integral),ROOT.RooFit.LineColor(ROOT.kOrange+7), ROOT.RooFit.LineWidth(3), ROOT.RooFit.Name('Central2'))#,ROOT.RooFit.NormRange("fullrange"),ROOT.RooFit.Range("range"))
pdf_x3.plotOn(xFrame,ROOT.RooFit.Normalization(integral),ROOT.RooFit.LineColor(ROOT.kGreen+3) ,ROOT.RooFit.LineWidth(2), ROOT.RooFit.Name('Central3'))#,ROOT.RooFit.NormRange("fullrange"),ROOT.RooFit.Range("range"))

pdf_x1.plotOn(xFrame,ROOT.RooFit.Normalization(integral),ROOT.RooFit.LineColor(ROOT.kBlue),ROOT.RooFit.LineWidth(2), ROOT.RooFit.Name('Central1'))#,ROOT.RooFit.NormRange("fullrange"),ROOT.RooFit.Range("range"))
data.plotOn(xFrame,ROOT.RooFit.Binning(int((xRange[1]-xRange[0])/xBinWidth)))

pull = xFrame.pullHist()

padDown.cd()
padDown.SetGridy(1)
pull.Draw('ap')
#pull.GetXaxis().SetRangeUser(0,810)
pull.GetXaxis().SetLimits(*xRange)
#pull.GetXaxis().SetMaximum(800)
pull.SetMaximum(2)
pull.SetMinimum(-2)
#pull.SetMarkerStyle(20)

pull.GetXaxis().SetTitleSize(0.16)
pull.GetXaxis().SetLabelSize(0.12)
pull.GetXaxis().SetTitleOffset(1)
pull.GetXaxis().SetTitle('m(#mu#mu) (GeV)')
pull.GetXaxis().SetNdivisions(510)
pull.GetXaxis().SetTickLength(0.09)

pull.GetYaxis().SetTitleSize(0.16)
pull.GetYaxis().SetLabelSize(0.12)
pull.GetYaxis().SetTitleOffset(0.4)
pull.GetYaxis().SetTitle('Pull')
pull.GetYaxis().SetNdivisions(502)

canvas.cd()
padUp.cd()

xFrame.Draw()
xFrame.GetYaxis().SetTitle('Events / {} GeV'.format(xBinWidth))

CMS_lumi.cmsText = 'CMS'
CMS_lumi.writeExtraText = isprelim
 #CMS_lumi.extraText = 'Preliminary'
CMS_lumi.extraText = '#tau_{h}#tau_{h}'
CMS_lumi.lumi_13TeV = "%0.1f fb^{-1}" % (59.8)
#CMS_lumi.lumi_13TeV = "%0.1f fb^{-1}" % (41.5)
CMS_lumi.CMS_lumi(canvas,4,11)

if massRange == 'lowmass':
    xmax = xFrame.GetMaximum()
    xFrame.SetMaximum(xmax*5)
    xFrame.SetMinimum(0.5)
elif massRange == 'upsilon':
    xFrame.SetMaximum(30)
xFrame.GetYaxis().SetTitleOffset(1.1)
xFrame.GetXaxis().SetLabelSize(0)

legend = ROOT.TLegend(0.45,0.55,0.92,0.88)
legend.SetTextFont(42)
legend.SetBorderSize(0)
legend.SetFillColor(0)
legend.SetFillStyle(0000)
#legend.SetNColumns(2)

for prim in reversed(padUp.GetListOfPrimitives()):
    print prim.GetTitle()
    if 'data_obs' in prim.GetTitle():
        title = 'Predicted' if blind else 'Observed'
        legend.AddEntry(prim, title, 'ep')
    elif 'ggH' in prim.GetTitle():
        title = 'm_{{H}} = {} GeV, m_{{a}} = {} GeV'.format(h,a)
        legend.AddEntry(prim, title, 'l')
legend.AddEntry('Central1', 'Expo', 'l')
legend.AddEntry('Central2', 'Poly5', 'l')
legend.AddEntry('Central3', 'Double Expo', 'l')
#legend.AddEntry('Fake', 'Tight-to-Loose Ratio Uncertainty', 'l')
prim = padUp.GetListOfPrimitives()[-1]
prim.SetMarkerSize(0)
prim.SetLineColor(0)
title = 'B(h #rightarrow aa #rightarrow #mu#mu#tau#tau) = {}'.format(floatToText(br))
legend.AddEntry(prim, title, 'ep')

padUp.cd()
legend.Draw()

if massRange == 'lowmass':
    padUp.SetLogy()
canvas.RedrawAxis()

for ext in ['png','pdf']:
    canvas.Print('bias_mm_TauHadTauHad_{}_{}.{}'.format(massRange,year,ext))

################################ y ######################################
y = ws1.var(yVar)
y.setUnit('GeV')
if yvar=='h':
    y.setPlotLabel('m(#mu#mu j)')
    y.SetTitle('m(#mu#mu j)')
else:
    y.setPlotLabel('m(#tau_{h}#tau_{h})')
    y.SetTitle('m(#tau_{#mu}#tau_{h})')
#y.setRange('fullrange',2.5,25)
y.setRange(*yRange)
y.setBins(int((yRange[1]-yRange[0])/yBinWidth))
#print y.getBinningNames()


canvas = ROOT.TCanvas('c','c',800,800)
canvas.Divide(1,1)
canvas.cd()
padDown=ROOT.TPad("","",0,0,1,0.25)
padDown.SetTopMargin(0.035)
padDown.SetBottomMargin(0.4)
padDown.Draw()
canvas.cd()
padUp=ROOT.TPad("","",0,0.25,1,1)
padUp.SetBottomMargin(0.03)
padUp.SetTopMargin(0.07)
padUp.Draw()

yFrame = y.frame()

#uncert = ws.var('uncrt_lambda_conty1_TauHadTauHad_V3_{}_PP_y'.format(year))
#uncert = ws.var('uncrt_erfShift_erf1_TauHadTauHad_V3_{}_PP_y'.format(year))
#uncert = ws.var('TauHadTauHad_V3_{}_fake'.format(year))
#uncert.setVal(-1)
#pdf_y1.plotOn(yFrame,ROOT.RooFit.Normalization(integral_fakeDown),ROOT.RooFit.LineColor(ROOT.kOrange+1), ROOT.RooFit.LineStyle(ROOT.kDashed),ROOT.RooFit.Name('Fake'))
#uncert.setVal(1)

sig_y.plotOn(yFrame,ROOT.RooFit.Normalization(sigintegral),ROOT.RooFit.LineColor(ROOT.kRed))#,
sig_y_heavy.plotOn(yFrame,ROOT.RooFit.Normalization(sigintegral_heavy),ROOT.RooFit.LineColor(ROOT.kGreen+3))


pdf_y3.plotOn(yFrame,ROOT.RooFit.Normalization(integral),ROOT.RooFit.LineColor(ROOT.kPink+7), ROOT.RooFit.Name('Central3'))
pdf_y2.plotOn(yFrame,ROOT.RooFit.Normalization(integral),ROOT.RooFit.LineColor(ROOT.kOrange+7), ROOT.RooFit.Name('Central2'))
pdf_y1.plotOn(yFrame,ROOT.RooFit.Normalization(integral),ROOT.RooFit.LineColor(ROOT.kBlue), ROOT.RooFit.Name('Central1'))

data.plotOn(yFrame)
pull = yFrame.pullHist()

#pdf_y = ws.pdf('bg_TauHadTauHad_V3_{}_PP_y'.format(year))
#uncert.setVal(0)
#pdf_y.plotOn(yFrame,ROOT.RooFit.Normalization(integral),ROOT.RooFit.LineColor(ROOT.kBlue), ROOT.RooFit.Name('central'))

padDown.cd()
padDown.SetGridy(1)
pull.Draw('ap')
#pull.GetXaxis().SetRangeUser(0,810)
pull.GetXaxis().SetLimits(*yRange)
#pull.GetXaxis().SetMaximum(800)
pull.SetMaximum(2)
pull.SetMinimum(-2)
#pull.SetMarkerStyle(20)

pull.GetXaxis().SetTitleSize(0.16)
pull.GetXaxis().SetLabelSize(0.12)
pull.GetXaxis().SetTitleOffset(1)
pull.GetXaxis().SetTitle('m(#mu#muj) (GeV)')
pull.GetXaxis().SetNdivisions(510)
pull.GetXaxis().SetTickLength(0.09)

pull.GetYaxis().SetTitleSize(0.16)
pull.GetYaxis().SetLabelSize(0.12)
pull.GetYaxis().SetTitleOffset(0.4)
pull.GetYaxis().SetTitle('Pull')
pull.GetYaxis().SetNdivisions(502)

canvas.cd()
padUp.cd()
yFrame.Draw()
yFrame.GetYaxis().SetTitle('Events / {} GeV'.format(yBinWidth))
yFrame.GetXaxis().SetLimits(*yRange)

CMS_lumi.cmsText = 'CMS'
CMS_lumi.writeExtraText = isprelim
#CMS_lumi.extraText = 'Preliminary'
CMS_lumi.extraText = '#tau_{h}#tau_{h}'
CMS_lumi.lumi_13TeV = "%0.1f fb^{-1}" % (59.8)
#CMS_lumi.lumi_13TeV = "%0.1f fb^{-1}" % (41.5)
CMS_lumi.CMS_lumi(canvas,4,11)


ymax = yFrame.GetMaximum()
yFrame.SetMaximum(ymax*10)
yFrame.SetMinimum(0.1)
yFrame.GetYaxis().SetTitleOffset(1.1)
yFrame.GetXaxis().SetLabelSize(0)

legend = ROOT.TLegend(0.45,0.55,0.92,0.88)
legend.SetTextFont(42)
legend.SetBorderSize(0)
legend.SetFillColor(0)
#legend.SetNColumns(2)

for prim in reversed(padUp.GetListOfPrimitives()):
    print prim.GetTitle()
    if 'data_obs' in prim.GetTitle():
        title = 'Predicted' if blind else 'Observed'
        legend.AddEntry(prim, title, 'ep')
    #elif 'bg' in prim.GetTitle():
    #    legend.AddEntry(prim, 'Background Model', 'l')
    elif 'ggH' in prim.GetTitle() and '125' in prim.GetTitle():
        #title = '#splitline{{m_{{H}} = {} GeV, m_{{a}} = {} GeV}}{{B(h #rightarrow aa #rightarrow #mu#mu#tau#tau) = {}}}'.format(h,a,floatToText(br))
        title = 'm_{{H}} = {} GeV'.format(h,a)
        legend.AddEntry(prim, title, 'l')
    elif 'ggH' in prim.GetTitle() and '1000' in prim.GetTitle():
        #title = '#splitline{{m_{{H}} = {} GeV, m_{{a}} = {} GeV}}{{B(h #rightarrow aa #rightarrow #mu#mu#tau#tau) = {}}}'.format(h,a,floatToText(br))
        title = 'm_{{H}} = {} GeV'.format(1000,a)
        legend.AddEntry(prim, title, 'l')
legend.AddEntry('Central1', 'Double Expo', 'l')
legend.AddEntry('Central2', 'Single Expo', 'l')
legend.AddEntry('Central3', 'Landau', 'l')
#legend.AddEntry('Fake', 'Tight-to-Loose Ratio Uncertainty', 'l')
legend.SetFillStyle(0000)
    
prim = padUp.GetListOfPrimitives()[-1]
prim.SetMarkerSize(0)
prim.SetLineColor(0)
title = 'B(h #rightarrow aa #rightarrow #mu#mu#tau#tau) = {}'.format(floatToText(br))
legend.AddEntry(prim, title, 'ep')

padUp.cd()
legend.Draw()

padUp.RedrawAxis()
padUp.SetLogy()

for ext in ['png','pdf']:
    #canvas.Print('bg_{}_TauHadTauHad_Erfb_{}.{}'.format(yvar,massRange,ext))
    canvas.Print('bias_{}_TauHadTauHad_{}_{}.{}'.format(yvar,massRange,year,ext))

