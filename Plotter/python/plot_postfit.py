import os, sys
import json

import ROOT
ROOT.gROOT.SetBatch(ROOT.kTRUE)

import CombineLimitsRunII.Plotter.CMS_lumi as CMS_lumi
import CombineLimitsRunII.Plotter.tdrstyle as tdrstyle

ROOT.gROOT.ProcessLine("gErrorIgnoreLevel = 2001;")
tdrstyle.setTDRStyle()

def floatToText(x):
    s = '{:.1E}'.format(x).split('E')
    return '{} #times 10^{{{}}}'.format(int(float(s[0])),int(s[1]))

isprelim = True
yvar = 'h'
h = 1000
xVar = 'invMassMuMu'
yVar = 'visFourbodyMass'
#massRange = 'lowmass'
#massRange = 'upsilon'
#massRange = 'highmass'
#year = '2018'

massRange = sys.argv[1]
year = sys.argv[2]

if massRange == 'lowmass':
    xRange = [2.5,8.5]
    xBinWidth = 0.1
    a = 5
elif massRange == 'upsilon':
    xRange = [6,14]
    xBinWidth = 0.1
    a = 11.
elif massRange == 'highmass':
    xRange = [11,45]
    xBinWidth = 0.5
    a = 40

if year == '2018':
    lumi = 59.830
elif year == '2017':
    lumi = 41.480
elif year == '2016':
    lumi = 36.330

yRange = [0,800]
yBinWidth = 10
blind = False
br = 0.005
doPostfit = False

amasses = ['3p6','5','9','13','17','21']
colors = [ROOT.kBlue-4, ROOT.kCyan+1, ROOT.kGreen+1, ROOT.kOrange-3, ROOT.kRed+1, ROOT.kMagenta+1]


rfile = '../../HaaLimits/python/datacards_shape/MuMuTauTau/mmmt_mm_{}_parametric_unbinned_unblind_{}_TauMuTauHad_V2_{}_MVAMedium_DG_DoubleExpo_yRange_wFakeTauScaleFit_PPonly.root'.format(yvar,massRange,year)
#rfile = '../../HaaLimits/python/datacards_shape/MuMuTauTau/mmmt_mm_{}_parametric_unbinned_unblind_{}_TauMuTauHad_V2_2018_MVAMedium_DG_DoubleExpo_yRange_wFakeTauScaleFit_PPonly.root'.format(yvar,massRange)
tfile = ROOT.TFile.Open(rfile)
print rfile

ws = tfile.Get('w')
#ws.Print()
pdf_x = ws.pdf('bg_TauMuTauHad_V2_{}_PP_x'.format(year))
pdf_x_cont = ws.pdf('cont_TauMuTauHad_V2_{}_PP_x'.format(year))
if massRange == 'lowmass':
    pdf_x_res = ws.pdf('jpsi_TauMuTauHad_V2_{}_PP_x'.format(year))
elif massRange == 'upsilon':
    pdf_x_res = ws.pdf('upsilon_TauMuTauHad_V2_{}_PP_x'.format(year))
else:
    pdf_x_res = None
pdf_y = ws.pdf('bg_TauMuTauHad_V2_{}_PP_y'.format(year))


pdf_control = ws.pdf("bg_control_{}".format(year))
pdf_control_cont = ws.pdf("contpoly_control_{}".format(year))
if massRange == 'lowmass':
    pdf_control_res = ws.pdf("jpsi_control_{}".format(year))
elif massRange == 'upsilon':
    pdf_control_res = ws.pdf("upsilon_control_{}".format(year))
else:
    pdf_control_res = None


fpostfit = open('../../HaaLimits/python/Impacts_TauMuTauHad_{}_{}_h1000/fit.log'.format(massRange,year))
params={}
print "Fitted Params"
for line in fpostfit.readlines():
    txt = []
    if len(line.split()) > 3:
        txt = line.split()[3]
    if not '+/-' in txt: continue
    param = line.split()[0]
    val = line.split()[2]
    var = ws.var(param)
    
    if var:
        print param, val, float(val)
        #var.setVal(float(val))
        params[param]=float(val)

#print params.keys()

data = ws.data('data_obs_TauMuTauHad_V2_{}_PP'.format(year))
data_control = ws.data('data_obs')

integral_postfit = data.sumEntries()

mh = ws.var('MH')
mh.setVal(h)
ma = ws.var('MA')
ma.setVal(a)

sig_x = ws.pdf('ggH_haa_{}_TauMuTauHad_V2_{}_PP_x'.format(h,year))
sig_y = ws.pdf('ggH_haa_{}_TauMuTauHad_V2_{}_PP_y'.format(h,year))
sig_y1 = ws.pdf('ggH_haa_{}_TauMuTauHad_V2_{}_PP_y'.format(250,year))
sig_y2 = ws.pdf('ggH_haa_{}_TauMuTauHad_V2_{}_PP_y'.format(500,year))

## if massRange == 'lowmass':
##     integral_postfit_cont = params['integral_cont1_TauMuTauHad_V2_2018_PP'] + params['integral_cont2_TauMuTauHad_V2_2018_PP']
## else:
##     integral_postfit_cont = params['integral_cont_TauMuTauHad_V2_2018_PP']
## 
## if massRange == 'lowmass':
##     integral_postfit_res = params['integral_jpsi1S_TauMuTauHad_V2_2018_PP']+params['relNorm_jpsi2S_2018']*params['integral_jpsi1S_TauMuTauHad_V2_2018_PP']
## elif massRange == 'upsilon':
##     integral_postfit_res = params['integral_upsilon1S_TauMuTauHad_V2_2018_PP']+params['relNorm_upsilon2S_2018']*params['integral_upsilon1S_TauMuTauHad_V2_2018_PP']+params['relNorm_upsilon3S_2018']*params['integral_upsilon1S_TauMuTauHad_V2_2018_PP']
## else:
##     integral_postfit_res = 0
## integral_postfit = integral_postfit_cont+integral_postfit_res


integral_control_cont = params['integral_contpoly_control_{}'.format(year)]
if massRange == 'lowmass':
    integral_control_res = params['integral_jpsi1S_control_{}'.format(year)]+params['relNorm_jpsi2S_{}'.format(year)]*params['integral_jpsi1S_control_{}'.format(year)]
elif massRange == 'upsilon':
    integral_control_res = params['integral_upsilon1S_control_{}'.format(year)]+params['relNorm_upsilon2S_{}'.format(year)]*params['integral_upsilon1S_control_{}'.format(year)]+params['relNorm_upsilon3S_{}'.format(year)]*params['integral_upsilon1S_control_{}'.format(year)]
else:
    integral_control_res = 0
integral_control = integral_control_cont+integral_control_res


sigintegral = ws.function('fullIntegral_ggH_haa_{}_TauMuTauHad_V2_{}_PP'.format(h,year)).getVal() * br/0.001
#sigintegral = -13.2224
#sigintegral = 0
mh.setVal(250)
sigintegral_1 = ws.function('fullIntegral_ggH_haa_{}_TauMuTauHad_V2_{}_PP'.format(250,year)).getVal() * br/0.001
mh.setVal(500)
sigintegral_2 = ws.function('fullIntegral_ggH_haa_{}_TauMuTauHad_V2_{}_PP'.format(500,year)).getVal() * br/0.001

#print sigintegral,sigintegral_heavy
#data.Print()
#print integral_postfit
#data_control.Print()
#print integral_control

################################ control ######################################
x = ws.var('invMassMuMu_control_{}'.format(year))
print x.getBins()
data_control.Print("V")
x.setUnit('GeV')
x.setPlotLabel('m(#mu#mu)')
x.SetTitle('m(#mu#mu)')

bWidth = 0.1

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

## xFrame = x.frame(ROOT.RooFit.Range(*xRange),ROOT.RooFit.Binning(int((xRange[1]-xRange[0])/bWidth)))
## if pdf_control_res:
##     pdf_control_cont.plotOn(xFrame,ROOT.RooFit.Normalization(integral_control_cont),ROOT.RooFit.LineColor(ROOT.kBlue), ROOT.RooFit.LineStyle(ROOT.kDashed), ROOT.RooFit.Name('cont'))
##     pdf_control_res.plotOn(xFrame,ROOT.RooFit.Normalization(integral_control_res),ROOT.RooFit.AddTo('cont'), ROOT.RooFit.LineColor(ROOT.kBlue), ROOT.RooFit.Name('central'))
## else:
##     pdf_control_cont.plotOn(xFrame,ROOT.RooFit.Normalization(integral_control_cont),ROOT.RooFit.LineColor(ROOT.kBlue), ROOT.RooFit.Name('cont'))


#pdf_control.plotOn(xFrame,ROOT.RooFit.Normalization(integral_control),ROOT.RooFit.LineColor(ROOT.kBlue))
#data_control.plotOn(xFrame,ROOT.RooFit.Binning(int((xRange[1]-xRange[0])/bWidth)))
#pdf_control.plotOn(xFrame)
#data_control.plotOn(xFrame)
#print data_control.sumEntries("invMassMuMu_control_2018>3.5"), integral_control_cont+integral_control_res

#pull = xFrame.pullHist()
#data_control.Print("V")
#print "chi square:", xFrame.chiSquare()
#print "total norm:", data_control.sumEntries()
#xFrame.Print("V")

newRange=[2.5,8.5]
#newRange = [6,14]
newVar = ws.var('invMassMuMu_control_{}'.format(year))
newVar.setRange("fullRange",*newRange)
newFrame = newVar.frame(ROOT.RooFit.Range("fullRange"),ROOT.RooFit.Binning(int((newRange[1]-newRange[0])/bWidth)))

#pull = data_control.createHistogram('d',newVar,ROOT.RooFit.Binning(int((xRange[1]-xRange[0])/bWidth)))
#den = pdf_control.createHistogram('bg',newVar,ROOT.RooFit.Normalization(data_control.sumEntries()),ROOT.RooFit.Binning(int((xRange[1]-xRange[0])/bWidth)))
#pull.Draw('ap')
#den.Draw('same')

pdf_control.plotOn(newFrame,ROOT.RooFit.Range("fullRange"),ROOT.RooFit.Normalization(data_control.sumEntries("invMassMuMu_control_{}>{} && invMassMuMu_control_{}<{}".format(year,newRange[0],year,newRange[1]))),ROOT.RooFit.Binning(int((newRange[1]-newRange[0])/bWidth)),ROOT.RooFit.Name('central'))
data_control.plotOn(newFrame,ROOT.RooFit.Binning(int((newRange[1]-newRange[0])/bWidth)),ROOT.RooFit.MarkerSize(0.01))

#print "chi square:", newFrame.chiSquare()
#newFrame.Print('V')

#newRange=[2.5,3.5]
#newVar = ws.var('invMassMuMu_control_2018')
#newVar.setRange(*newRange)
#newFrame = newVar.frame(ROOT.RooFit.Range(*newRange),ROOT.RooFit.Binning(int((newRange[1]-newRange[0])/xBinWidth)))

#pdf_control.plotOn(newFrame)
#data_control.plotOn(newFrame)
#print "chi square:", newFrame.chiSquare()

#pull = newFrame.pullHist()
#pull = data_control.divide(data_control)
#data_control.createPlotProjection()
#pdf_control.createPlotProjection(newVar,newVar)

newWidth = 0.01

if True: 
    num = data_control.createHistogram('d',newVar,ROOT.RooFit.Binning(int((newRange[1]-newRange[0])/newWidth)),ROOT.RooFit.Range("fullRange"))
    den = pdf_control.createHistogram('d',newVar,ROOT.RooFit.Binning(int((newRange[1]-newRange[0])/newWidth)),ROOT.RooFit.Normalization(data_control.sumEntries()))
    print newVar,type(newVar)
    print den.GetNbinsX(), den.Integral()
    print num.GetNbinsX(), num.Integral()
    
    
    pull = num.Clone('clone')
    
    for b in range(pull.GetNbinsX()):
        print num.GetBinContent(b+1),num.GetBinError(b+1),den.GetBinContent(b+1)*data_control.sumEntries()
        n = num.GetBinContent(b+1)
        d = den.GetBinContent(b+1)*data_control.sumEntries()
        en = num.GetBinError(b+1)
        pull.SetBinContent(b+1,n/d)
        pull.SetBinError(b+1,en/d)
    
    print pull.Integral()
    pull.Rebin(10)
    pull.Scale(0.1)
else:
    num = data_control.createHistogram('d',newVar,ROOT.RooFit.Binning(int((newRange[1]-newRange[0])/bWidth)))
    norm_pdf = pdf_control.createIntegral(ROOT.RooArgSet(newVar),ROOT.RooFit.NormSet(ROOT.RooArgSet(newVar)),ROOT.RooFit.Range("fullRange")).getVal()
    norm_data = data_control.sumEntries()
    print "DEBUG:",norm_pdf,norm_data
    pull = num.Clone('clone')
    
    for b in range(int((xRange[1]-xRange[0])/bWidth)):
        lowEdge = xRange[0]+b*bWidth
        highEdge = xRange[0]+(b+1)*bWidth
        
        newVar.setRange("binRange",lowEdge,highEdge)
        n = num.GetBinContent(b+1)
        d0 = pdf_control.createIntegral(ROOT.RooArgSet(newVar),ROOT.RooFit.NormSet(ROOT.RooArgSet(newVar)),ROOT.RooFit.Range("binRange"))
        d = (d0.getVal()/norm_pdf)*norm_data
        print lowEdge,highEdge,d0.getVal(),d,n
        en = num.GetBinError(b+1)
        pull.SetBinContent(b+1,n/d)
        pull.SetBinError(b+1,en/d)

    print pull.Integral()
#pull = newFrame.pullHist()

canvas.cd()
padUp.cd()

newFrame.Draw()
newFrame.GetYaxis().SetTitle('Events / {} GeV'.format(bWidth))

padDown.cd()
padDown.SetGridy(1)
print pull, type(pull)
#pull.Draw('alp')
pull.Draw()
pull.GetXaxis().SetRangeUser(*newRange)
#pull.GetXaxis().SetLimits(*xRange)
#pull.GetXaxis().SetMaximum(800)
pull.SetMaximum(1.1)
pull.SetMinimum(0.9)
pull.SetMarkerSize(1)
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
pull.GetYaxis().SetTitle('Obs/Exp')
pull.GetYaxis().SetNdivisions(502)

CMS_lumi.cmsText = 'CMS'
CMS_lumi.writeExtraText = isprelim
#CMS_lumi.extraText = 'Preliminary'
CMS_lumi.extraText = 'Control Region'
CMS_lumi.lumi_13TeV = "%0.1f fb^{-1}" % (lumi)
CMS_lumi.CMS_lumi(canvas,4,11)

if massRange == 'lowmass':
    xmax = newFrame.GetMaximum()
    newFrame.SetMaximum(xmax*10)
    newFrame.SetMinimum(100)
elif massRange == 'upsilon':
    xmax = newFrame.GetMaximum()
    newFrame.SetMaximum(xmax*1.2)
newFrame.GetYaxis().SetTitleOffset(1.1)
newFrame.GetXaxis().SetLabelSize(0)
#newFrame.SetMaximum(200)

legend = ROOT.TLegend(0.55,0.65,0.92,0.88)
legend.SetTextFont(42)
legend.SetBorderSize(0)
legend.SetFillColor(0)
legend.SetFillStyle(0000)
#legend.SetNColumns(2)

for prim in reversed(padUp.GetListOfPrimitives()):
    #print prim.GetTitle()
    if 'data_obs' in prim.GetTitle():
        title = 'Predicted' if blind else 'Observed'
        legend.AddEntry(prim, title, 'elp')
    elif 'ggH' in prim.GetTitle():
        title = 'm_{{H}} = {} GeV, m_{{a}} = {} GeV'.format(h,a)
        #legend.AddEntry(prim, title, 'l')
legend.AddEntry('central', 'Background Model', 'l')
#legend.AddEntry('Fake', 'Tight-to-Loose Ratio Uncertainty', 'l')
prim = padUp.GetListOfPrimitives()[-1]
prim.SetMarkerSize(0)
prim.SetLineColor(0)
#title = 'B(h #rightarrow aa #rightarrow #mu#mu#tau#tau) = {}'.format(floatToText(br))
#legend.AddEntry(prim, title, 'ep')

padUp.cd()
legend.Draw()

if massRange == 'lowmass':
    padUp.SetLogy()
canvas.RedrawAxis()

for ext in ['png']:
    canvas.Print('postfit_mm_control_{}_{}.{}'.format(massRange,year,ext))


################################ x ######################################
x = ws.var(xVar)
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

## if pdf_x_res:
##     pdf_x_cont.plotOn(xFrame,ROOT.RooFit.Normalization(integral_postfit_cont),ROOT.RooFit.LineColor(ROOT.kBlue), ROOT.RooFit.LineStyle(ROOT.kDashed), ROOT.RooFit.Name('cont'))
##     pdf_x_res.plotOn(xFrame,ROOT.RooFit.Normalization(integral_postfit_res),ROOT.RooFit.AddTo('cont'),ROOT.RooFit.LineColor(ROOT.kBlue), ROOT.RooFit.Name('central'))
## else:
##     pdf_x_cont.plotOn(xFrame,ROOT.RooFit.Normalization(integral_postfit_cont),ROOT.RooFit.LineColor(ROOT.kBlue), ROOT.RooFit.Name('cont'))
sig_x.plotOn(xFrame,ROOT.RooFit.Normalization(sigintegral),ROOT.RooFit.LineColor(ROOT.kRed))

pdf_x.plotOn(xFrame,ROOT.RooFit.Normalization(integral_postfit),ROOT.RooFit.LineColor(ROOT.kBlue))
#pdf_x.plotOn(xFrame,ROOT.RooFit.LineColor(ROOT.kBlue))
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
CMS_lumi.extraText = '#tau_{#mu}#tau_{h}'
CMS_lumi.lumi_13TeV = "%0.1f fb^{-1}" % (lumi)
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
    #print prim.GetTitle()
    if 'data_obs' in prim.GetTitle():
        title = 'Predicted' if blind else 'Observed'
        legend.AddEntry(prim, title, 'ep')
    elif 'ggH' in prim.GetTitle():
        title = 'm_{{H}} = {} GeV, m_{{a}} = {} GeV'.format(h,a)
        legend.AddEntry(prim, title, 'l')
legend.AddEntry('central', 'Background Model', 'l')
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

for ext in ['png']:
    canvas.Print('postfit_mm_TauMuTauHad_{}_{}.{}'.format(massRange,year,ext))

################################ y ######################################
y = ws.var(yVar)
y.setUnit('GeV')
if yvar=='h':
    y.setPlotLabel('m(#mu#mu#tau_{#mu}#tau_{h})')
    y.SetTitle('m(#mu#mu#tau_{#mu}#tau_{h})')
else:
    y.setPlotLabel('m(#tau_{#mu}#tau_{h})')
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

sig_y.plotOn(yFrame,ROOT.RooFit.Normalization(sigintegral),ROOT.RooFit.LineColor(ROOT.kRed))#,
sig_y1.plotOn(yFrame,ROOT.RooFit.Normalization(sigintegral_1),ROOT.RooFit.LineColor(ROOT.kOrange-6))#,
sig_y2.plotOn(yFrame,ROOT.RooFit.Normalization(sigintegral_2),ROOT.RooFit.LineColor(ROOT.kGreen+3))#,
pdf_y.plotOn(yFrame,ROOT.RooFit.Normalization(integral_postfit),ROOT.RooFit.LineColor(ROOT.kBlue), ROOT.RooFit.Name('central'))

data.plotOn(yFrame)

pull = yFrame.pullHist()

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
pull.GetXaxis().SetTitle('m(#mu#mu#tau_{#mu}#tau_{h}) (GeV)')
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
CMS_lumi.extraText = '#tau_{#mu}#tau_{h}'
CMS_lumi.lumi_13TeV = "%0.1f fb^{-1}" % (lumi)
CMS_lumi.CMS_lumi(canvas,4,11)


ymax = yFrame.GetMaximum()
yFrame.SetMaximum(ymax*10)
yFrame.SetMinimum(0.01)
yFrame.GetYaxis().SetTitleOffset(1.1)
yFrame.GetXaxis().SetLabelSize(0)

legend = ROOT.TLegend(0.45,0.55,0.92,0.88)
legend.SetTextFont(42)
legend.SetBorderSize(0)
legend.SetFillColor(0)
#legend.SetNColumns(2)

for prim in reversed(padUp.GetListOfPrimitives()):
    #print prim.GetTitle()
    if 'data_obs' in prim.GetTitle():
        title = 'Predicted' if blind else 'Observed'
        legend.AddEntry(prim, title, 'ep')
    #elif 'bg' in prim.GetTitle():
    #    legend.AddEntry(prim, 'Background Model', 'l')
    elif 'ggH' in prim.GetTitle() and '125' in prim.GetTitle():
        #title = '#splitline{{m_{{H}} = {} GeV, m_{{a}} = {} GeV}}{{B(h #rightarrow aa #rightarrow #mu#mu#tau#tau) = {}}}'.format(h,a,floatToText(br))
        title = 'm_{{H}} = {} GeV, m_{{a}} = {} GeV'.format(h,a)
        legend.AddEntry(prim, title, 'l')
    elif 'ggH' in prim.GetTitle() and '250' in prim.GetTitle():
        #title = '#splitline{{m_{{H}} = {} GeV, m_{{a}} = {} GeV}}{{B(h #rightarrow aa #rightarrow #mu#mu#tau#tau) = {}}}'.format(h,a,floatToText(br))
        title = 'm_{{H}} = {} GeV, m_{{a}} = {} GeV'.format(250,a)
        legend.AddEntry(prim, title, 'l')
    elif 'ggH' in prim.GetTitle() and '500' in prim.GetTitle():
        #title = '#splitline{{m_{{H}} = {} GeV, m_{{a}} = {} GeV}}{{B(h #rightarrow aa #rightarrow #mu#mu#tau#tau) = {}}}'.format(h,a,floatToText(br))
        title = 'm_{{H}} = {} GeV, m_{{a}} = {} GeV'.format(500,a)
        legend.AddEntry(prim, title, 'l')
    elif 'ggH' in prim.GetTitle() and '1000' in prim.GetTitle():
        #title = '#splitline{{m_{{H}} = {} GeV, m_{{a}} = {} GeV}}{{B(h #rightarrow aa #rightarrow #mu#mu#tau#tau) = {}}}'.format(h,a,floatToText(br))
        title = 'm_{{H}} = {} GeV, m_{{a}} = {} GeV'.format(1000,a)
        legend.AddEntry(prim, title, 'l')
legend.AddEntry('central', 'Background Model', 'l')
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

for ext in ['png']:
    #canvas.Print('bg_{}_TauMuTauHad_Erfb_{}.{}'.format(yvar,massRange,ext))
    canvas.Print('postfit_{}_TauMuTauHad_{}_{}.{}'.format(yvar,massRange,year,ext))

