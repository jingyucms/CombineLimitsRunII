import logging

from array import array

import ROOT
from CombineLimitsRunII.Limits.utilities import *

class Model(object):

    def __init__(self,name,**kwargs):
        self.name = name
        self.x = kwargs.pop('x','x')
        self.y = kwargs.pop('y','y')
        self.z = kwargs.pop('z','z')
        self.kwargs = kwargs

    def wsimport(self, ws, *args) :
        # getattr since import is special in python
        # NB RooWorkspace clones object
        if len(args) < 2 :
            # Useless RooCmdArg: https://sft.its.cern.ch/jira/browse/ROOT-6785
            args += (ROOT.RooCmdArg(),)
        return getattr(ws, 'import')(*args)

    def update(self,**kwargs):
        '''Update the floating parameters'''
        self.kwargs.update(kwargs)

    def build(self,ws,label):
        '''Dummy method to add model to workspace'''
        logging.debug('Building {}'.format(label))

    def fit(self,ws,hist,name,save=False,doErrors=False,saveDir='', xFitRange=[0,30], xRange=[]):
        '''Fit the model to a histogram and return the fit values'''

        if isinstance(hist,ROOT.TH1):
            dhname = 'dh_{0}'.format(name)
            hist = ROOT.RooDataHist(dhname, dhname, ROOT.RooArgList(ws.var(self.x)), hist)
        #self.build(ws,name)
        model = ws.pdf(name)
       
        #ws.var('x').setRange('xRange', xFitRange[0], xFitRange[1])
        fr = model.fitTo(hist,ROOT.RooFit.Save(),ROOT.RooFit.SumW2Error(True),ROOT.RooFit.PrintLevel(-1))
        #fr = model.fitTo(hist,ROOT.RooFit.Save(),ROOT.RooFit.SumW2Error(True),ROOT.RooFit.Minos(True))
        pars = fr.floatParsFinal()
        vals = {}
        errs = {}
        for p in range(pars.getSize()):
            vals[pars.at(p).GetName()] = pars.at(p).getValV()
            errs[pars.at(p).GetName()] = pars.at(p).getError()
            #print pars.at(p).GetName(), pars.at(p).getValV(), pars.at(p).getError(), pars.at(p).GetAsymErrorHi(), pars.at(p).GetAsymErrorLo()

        if save:
            if saveDir: python_mkdir(saveDir)
            savename = '{}/{}_{}'.format(saveDir,self.name,name) if saveDir else '{}_{}'.format(self.name,name)
            x = ws.var(self.x)
            if xRange:
                xFrame = x.frame(ROOT.RooFit.Range(*xRange))
            else:
                xFrame = x.frame()
            xFrame.SetTitle('')
            hist.plotOn(xFrame)
            model.plotOn(xFrame)
            chi2Line = "Chi2: " + str(xFrame.chiSquare()) # Adding chi2 info
            pt = ROOT.TPaveText(.72,.1,.90,.2, "brNDC") # Adding chi2 info
            pt.AddText(chi2Line ) # Adding chi2 info
            model.paramOn(xFrame,ROOT.RooFit.Layout(0.72,0.98,0.90))

            resid = xFrame.residHist()
            pull = xFrame.pullHist()

            if xRange:
                xFrame2 = x.frame(ROOT.RooFit.Range(*xRange))
            else:
                xFrame2 = x.frame()
            xFrame2.addPlotable(pull,'P')

            canvas = ROOT.TCanvas(savename,savename,800,800)
            ROOT.SetOwnership(canvas,False)
            #canvas.SetRightMargin(0.3)
            plotpad = ROOT.TPad("plotpad", "top pad", 0.0, 0.21, 1.0, 1.0)
            ROOT.SetOwnership(plotpad,False)
            plotpad.SetBottomMargin(0.00)
            plotpad.SetRightMargin(0.2)
            plotpad.SetLeftMargin(0.16)
            plotpad.Draw()
            ratiopad = ROOT.TPad("ratiopad", "bottom pad", 0.0, 0.0, 1.0, 0.21)
            ROOT.SetOwnership(ratiopad,False)
            ratiopad.SetTopMargin(0.0)
            ratiopad.SetRightMargin(0.2)
            ratiopad.SetBottomMargin(0.5)
            ratiopad.SetLeftMargin(0.16)
            ratiopad.SetTickx(1)
            ratiopad.SetTicky(1)
            ratiopad.Draw()
            if plotpad != ROOT.TVirtualPad.Pad(): plotpad.cd()
            xFrame.Draw()
            pt.Draw()
            #prims = canvas.GetListOfPrimitives()
            prims = plotpad.GetListOfPrimitives()
            for prim in prims:
                if 'paramBox' in prim.GetName():
                    prim.SetTextSize(0.02)
            #mi = xFrame.GetMinimum()
            #ma = xFrame.GetMaximum()
            #if mi<0:
            #    xFrame.SetMinimum(0.1)
            ratiopad.cd()
            xFrame2.Draw()
            #xFrame2.GetYaxis().SetRangeUser(-5,5)
            #xFrame2.GetYaxis().SetNdivisions(505)
            #xFrame2.GetYaxis().SetTitleSize(0.05)
            prims = ratiopad.GetListOfPrimitives()
            #print "==========Look Here============"
            for prim in prims:
                print prim
                if 'frame' in prim.GetName():
                    prim.GetXaxis().SetLabelSize(0.09)
                    prim.GetXaxis().SetTitleSize(0.21)
                    prim.GetXaxis().SetTitleOffset(1.0)
                    prim.GetXaxis().SetLabelOffset(0.03)
                    prim.GetYaxis().SetLabelSize(0.09)
                    prim.GetYaxis().SetLabelOffset(0.006)
                    prim.GetYaxis().SetTitleSize(0.21)
                    prim.GetYaxis().SetTitleOffset(0.30)
                    prim.GetYaxis().SetNdivisions(505)
                    prim.GetYaxis().SetTitle('Pull')
                    prim.GetYaxis().SetRangeUser(-5,5)
                    #continue
            canvas.cd()

            canvas.Print('{0}.png'.format(savename))

        if doErrors:
            return vals, errs
        return vals

    def fit2D(self,ws,hist,name,save=False,doErrors=False,saveDir='', xFitRange=[0,30], yFitRange=[0,30], logy=False, xRange=[], yRange=[]):
        '''Fit the model to a histogram and return the fit values'''
        
        if isinstance(hist,ROOT.TH1):
            dhname = 'dh_{0}'.format(name)
            hist = ROOT.RooDataHist(dhname, dhname, ROOT.RooArgList(ws.var(self.x),ws.var(self.y)), hist)

        #self.build(ws,name)
        model = ws.pdf(name)
        #ws.var('x').setRange('xRange', xFitRange[0], xFitRange[1])
        #ws.var('y').setRange('yRange', yFitRange[0], yFitRange[1])
        #print xRange[0], xRange[1], yRange
        #ws.Print()
        #if yRange:
            #ws.var('invMassMuMu').setRange(xRange[0], xRange[1])
            #ws.var('visFourbodyMass').setRange(yRange[0], yRange[1])
        #print ("X_FIT_RANGE=", xFitRange, "\tY_FIT_RANGE=", yFitRange)

        fr = model.fitTo(hist,ROOT.RooFit.Minimizer("Minuit2", "Minos"), ROOT.RooFit.Save(),ROOT.RooFit.SumW2Error(True),ROOT.RooFit.PrintLevel(-1))
        #fr = model.fitTo(hist,ROOT.RooFit.Minimizer("GSLMultiMin", "conjugatefr"), ROOT.RooFit.Save(),ROOT.RooFit.SumW2Error(True),ROOT.RooFit.PrintLevel(3))
        
        #fr = model.fitTo(hist,ROOT.RooFit.Save(),ROOT.RooFit.SumW2Error(True),ROOT.RooFit.Minos(True))
        pars = fr.floatParsFinal()
        vals = {}
        errs = {}
        for p in range(pars.getSize()):
            vals[pars.at(p).GetName()] = pars.at(p).getValV()
            errs[pars.at(p).GetName()] = pars.at(p).getError()
            #errs[pars.at(p).GetName()] = (pars.at(p).getAsymErrorHi(), pars.at(p).getAsymErrorLo())
            #print pars.at(p).GetName(), pars.at(p).getValV(), pars.at(p).getError(), pars.at(p).getVal(), pars.at(p).getAsymErrorHi(), pars.at(p).getAsymErrorLo()

        #print "xRange:", xRange
        if save:
            if saveDir: python_mkdir(saveDir)
            savename = '{}/{}_{}'.format(saveDir,self.name,name) if saveDir else '{}_{}'.format(self.name,name)
            x = ws.var(self.x)
            if xRange:
                xFrame = x.frame(ROOT.RooFit.Range(*xRange))
            else:
                xFrame = x.frame()
            xFrame.SetTitle('')
            hist.plotOn(xFrame)
            model.plotOn(xFrame)
            chi2Linex = "Chi2: " +  str(xFrame.chiSquare()) # Adding chi2 info
            ptx = ROOT.TPaveText(.72,.1,.90,.2, "brNDC") # Adding chi2 info
            ptx.AddText(chi2Linex) # Adding chi2 info
            model.paramOn(xFrame,ROOT.RooFit.Layout(0.72,0.98,0.90))

            resid = xFrame.residHist()
            pull = xFrame.pullHist()

            if xRange:
                xFrame2 = x.frame(ROOT.RooFit.Range(*xRange))
            else:
                xFrame2 = x.frame()
            xFrame2.addPlotable(pull,'P')

            canvas = ROOT.TCanvas(savename,savename,800,800)
            ROOT.SetOwnership(canvas,False)
            #canvas.SetRightMargin(0.3)
            plotpad = ROOT.TPad("plotpad", "top pad", 0.0, 0.21, 1.0, 1.0)
            ROOT.SetOwnership(plotpad,False)
            plotpad.SetBottomMargin(0.00)
            plotpad.SetRightMargin(0.2)
            plotpad.SetLeftMargin(0.16)
            plotpad.Draw()
            ratiopad = ROOT.TPad("ratiopad", "bottom pad", 0.0, 0.0, 1.0, 0.21)
            ROOT.SetOwnership(ratiopad,False)
            ratiopad.SetTopMargin(0.0)
            ratiopad.SetRightMargin(0.2)
            ratiopad.SetBottomMargin(0.5)
            ratiopad.SetLeftMargin(0.16)
            ratiopad.SetTickx(1)
            ratiopad.SetTicky(1)
            ratiopad.Draw()
            if plotpad != ROOT.TVirtualPad.Pad(): plotpad.cd()
            xFrame.Draw()
            ptx.Draw()
            #prims = canvas.GetListOfPrimitives()
            prims = plotpad.GetListOfPrimitives()
            for prim in prims:
                if 'paramBox' in prim.GetName():
                    prim.SetTextSize(0.02)
            #mi = xFrame.GetMinimum()
            #ma = xFrame.GetMaximum()
            #if mi<0:
            #    xFrame.SetMinimum(0.1)
            ratiopad.cd()
            xFrame2.Draw()
            #xFrame2.GetYaxis().SetRangeUser(-5,5)
            #xFrame2.GetYaxis().SetNdivisions(505)
            #xFrame2.GetYaxis().SetTitleSize(0.05)
            prims = ratiopad.GetListOfPrimitives()
            
            #print "==========Look Here============"
            #print prims
            for prim in prims:
                #print prim
                if 'frame' in prim.GetName():
                    prim.GetXaxis().SetLabelSize(0.09)
                    prim.GetXaxis().SetTitleSize(0.21)
                    prim.GetXaxis().SetTitleOffset(1.0)
                    prim.GetXaxis().SetLabelOffset(0.03)
                    prim.GetYaxis().SetLabelSize(0.09)
                    prim.GetYaxis().SetLabelOffset(0.006)
                    prim.GetYaxis().SetTitleSize(0.21)
                    prim.GetYaxis().SetTitleOffset(0.30)
                    prim.GetYaxis().SetNdivisions(505)
                    prim.GetYaxis().SetTitle('Pull')
                    prim.GetYaxis().SetRangeUser(-5,5)
                    #continue
            canvas.cd()

            canvas.Print('{0}_xproj.png'.format(savename))

            y = ws.var(self.y)
            #yRange = [18.75, 180]
            if yRange:
                yFrame = y.frame(ROOT.RooFit.Range(*yRange))
            else:
                yFrame = y.frame()
            yFrame.SetTitle('')
            hist.plotOn(yFrame)
            #hist.Print('v')
            model.plotOn(yFrame)
            chi2Liney = "Chi2: " + str(yFrame.chiSquare()) # Adding chi2 info
            pty = ROOT.TPaveText(.72,.1,.90,.2, "brNDC") # Adding chi2 info            
            pty.AddText(chi2Liney ) # Adding chi2 info
            model.paramOn(yFrame,ROOT.RooFit.Layout(0.72,0.98,0.90))

            resid = yFrame.residHist()
            pull = yFrame.pullHist()

            if yRange:
                yFrame2 = y.frame(ROOT.RooFit.Range(*yRange))
            else:
                yFrame2 = y.frame()
            yFrame2.addPlotable(pull,'P')

            canvas = ROOT.TCanvas(savename+'y',savename+'y',800,800)
            ROOT.SetOwnership(canvas,False)
            #canvas.SetRightMargin(0.3)
            plotpad = ROOT.TPad("plotpad", "top pad", 0.0, 0.21, 1.0, 1.0)
            ROOT.SetOwnership(plotpad,False)
            plotpad.SetBottomMargin(0.00)
            plotpad.SetRightMargin(0.2)
            plotpad.SetLeftMargin(0.16)
            plotpad.Draw()
            ratiopad = ROOT.TPad("ratiopad", "bottom pad", 0.0, 0.0, 1.0, 0.21)
            ROOT.SetOwnership(ratiopad,False)
            ratiopad.SetTopMargin(0.0)
            ratiopad.SetRightMargin(0.2)
            ratiopad.SetBottomMargin(0.5)
            ratiopad.SetLeftMargin(0.16)
            ratiopad.SetTickx(1)
            ratiopad.SetTicky(1)
            ratiopad.Draw()
            if plotpad != ROOT.TVirtualPad.Pad(): plotpad.cd()
            yFrame.Draw()
            pty.Draw()
            #prims = canvas.GetListOfPrimitives()
            prims = plotpad.GetListOfPrimitives()
            for prim in prims:
                if 'paramBox' in prim.GetName():
                    prim.SetTextSize(0.02)
            #mi = xFrame.GetMinimum()
            #ma = xFrame.GetMaximum()
            #if mi<0:
            #    xFrame.SetMinimum(0.1)
            ratiopad.cd()
            yFrame2.Draw()
            prims = ratiopad.GetListOfPrimitives()
            #print "==========Look Here============"
            #print prims
            for prim in prims:
                #print prim
                if 'frame' in prim.GetName():
                    prim.GetXaxis().SetLabelSize(0.09)
                    prim.GetXaxis().SetTitleSize(0.21)
                    prim.GetXaxis().SetTitleOffset(1.0)
                    prim.GetXaxis().SetLabelOffset(0.03)
                    prim.GetYaxis().SetLabelSize(0.09)
                    prim.GetYaxis().SetLabelOffset(0.006)
                    prim.GetYaxis().SetTitleSize(0.21)
                    prim.GetYaxis().SetTitleOffset(0.30)
                    prim.GetYaxis().SetNdivisions(505)
                    prim.GetYaxis().SetTitle('Pull')
                    prim.GetYaxis().SetRangeUser(-5,5)
                    #continue
            canvas.cd()

            canvas.Print('{0}_yproj.png'.format(savename))

            histM = model.createHistogram('{},{}'.format(self.x,self.y),100,100)
            histM.SetLineColor(ROOT.kBlue)
            histM.Draw('surf3')
            canvas.Print('{0}_model.png'.format(savename))

            if isinstance(hist,ROOT.RooDataSet):
                histD = hist.createHistogram(x,y,20,20,'1','{}_hist'.format(savename))
                histD.SetLineColor(ROOT.kBlack)
                histD.Draw('surf3')
                canvas.Print('{0}_dataset.png'.format(savename))


        if doErrors:
            return vals, errs
        return vals

    def setIntegral(self,integral):
        self.integral = integral

    def getIntegral(self):
        if hasattr(self,'integral'): return self.integral
        return 1

    def getParams(self):
        if hasattr(self,'params'): return self.params
        return []

def buildSpline(ws,label,MH,masses,values):
    if isinstance(values, list):
        if isinstance(MH, list):
            # TODO: doesn't work
            args = ROOT.RooArgList(*[ws.var(mh) for mh in MH])
            tree = ROOT.TTree('tree','tree')
            val = array('d',[0])
            mhs = [array('d',[0]) for mh in MH]
            tree.Branch('f', val, 'f/Float_t')
            for m in range(len(MH)):
                tree.Branch(MH[m], mhs[m], '{}/Float_t'.format(MH[m]))
            for i in range(len(values)):
                val[0] = values[i]
                for m in range(len(MH)):
                    mhs[m][0] = masses[m][i]
                tree.Fill()
            spline = ROOT.RooSplineND(label, label, args, tree, 'f', 1, True)
        else:
            if sorted(masses) != masses:
                print 'Masses are not in increasing order for', label
                print masses
                raise ValueError
            #if "integral" in label:
            #    print label
            #    print array('d',masses)
            #    print array('d',values)
            spline  = ROOT.RooSpline1D(label,  label,  ws.var(MH), len(masses), array('d',masses), array('d',values), "CSPLINE")
    else: # TFn case
        if not isinstance(MH, list): MH = [MH]
        args = ROOT.RooArgList(*[ws.var(mh) for mh in MH])

        # RooTFnBinding
        #params = []
        #for p in range(values.GetNpar()):
        #    name = '{}_p{}'.format(label,p)
        #    ws.factory('{}[{}]'.format(name,values.GetParameter(p)))
        #    params += [ws.var(name)]
        #pargs = ROOT.RooArgList(*params)
        #values.SetName(label)
        #values.SetTitle(label)
        #spline = ROOT.RooTFnBinding(label,label,values,args,pargs)

        # RooFormulaVar
        expr = str(values.GetExpFormula())
        dims = ['x','y','z']
        for d in range(len(MH)):
            expr = expr.replace(dims[d],'@{}'.format(d))
        for p in range(values.GetNpar()):
            expr = expr.replace('[p{}]'.format(p),'({:g})'.format(values.GetParameter(p)))
        spline = ROOT.RooFormulaVar(label, label, expr, args)

    return spline

class ModelSpline(Model):

    def __init__(self,name,**kwargs):
        self.mh = kwargs.pop('MH','MH')
        super(ModelSpline,self).__init__(name,**kwargs)

    def setIntegral(self,masses,integrals):
        self.masses = masses
        self.integrals = integrals

    def getIntegral(self):
        if hasattr(self,'integrals'): return self.integrals
        return 1

    def buildIntegral(self,ws,label):
        if not hasattr(self,'integrals'): return 
        spline = buildSpline(ws,label,self.mh,self.masses,self.integrals)
        # import to workspace
        getattr(ws, "import")(spline, ROOT.RooFit.RecycleConflictNodes())

class Param(object):

    def __init__(self,name,**kwargs):
        self.name = name
        self.kwargs = kwargs

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        paramName = '{}'.format(label) 
        value = self.kwargs.get('value', 0)
        vargs = self.kwargs.get('valueArgs',[])
        shifts = self.kwargs.get('shifts', {})
        uncertainty = self.kwargs.get('uncertainty',0.00)
        args = ROOT.TList()
        if isinstance(value,basestring):
            shiftFormula = value
            for a in vargs:
                av = ws.var(a)
                if not av:
                    av = ws.function(a)
                args.Add(av)
        else:
            shiftFormula = '{}'.format(value)
        for shift in shifts:
            up = shifts[shift]['up']
            down = shifts[shift]['down']
            if isinstance(value,basestring) or abs(up/value)>0.0 or abs(down/value)>0.0:
                ws.factory('{}[0,-10,10]'.format(shift))
                if "integral" in paramName:
                    #shiftFormula += ''
                #if False:
                    shiftFormula += ' + TMath::Max(0,TMath::Exp(@{shift})-1)*({up}) + TMath::Min(0,TMath::Exp(@{shift})-1)*({down})'.format(shift=len(args),up=up,down=down)
                else:
                    shiftFormula += ' + TMath::Max(0,@{shift})*({up}) + TMath::Min(0,@{shift})*({down})'.format(shift=len(args),up=up,down=down)
                args.Add(ws.var(shift))
        if uncertainty > 0:
        #if uncertainty > 0 and not 'lambda_conty' in paramName and not 'erf' in paramName:
            #if abs(uncertainty/value) > 0.2:
            #    uncertainty = abs(0.2*value)
            uncrtTxt = "uncrt_"+paramName
            #if 'lambda_conty' in paramName or 'bg1' in paramName or 'erf' in paramName:
            #if 'lambda_conty' in paramName or 'erf' in paramName:
            #    uncrtTxt = "uncrt_modelcor"
            ws.factory('{}[0,-10,10]'.format(uncrtTxt))
            uncrt = uncertainty
            #if "integral" in paramName or "erfScale" in paramName:
            if "integral" in paramName:
                #shiftFormula += ''
            #if False:
                shiftFormula += ' + TMath::Max(0,TMath::Exp(@{shift})-1)*({up}) + TMath::Min(0,TMath::Exp(@{shift})-1)*({down})'.format(shift=len(args),up=uncrt,down=uncrt)
            else:
                #if 'erf' in paramName:
                #    shiftFormula += ' + TMath::Max(0,@{shift})*({down}) + TMath::Min(0,@{shift})*({up})'.format(shift=len(args),up=uncrt,down=uncrt)
                #else:
                shiftFormula += ' + TMath::Max(0,@{shift})*({up}) + TMath::Min(0,@{shift})*({down})'.format(shift=len(args),up=uncrt,down=uncrt)
            args.Add(ws.var(uncrtTxt))
        
        arglist = ROOT.RooArgList(args)
        param = ROOT.RooFormulaVar(paramName, paramName, shiftFormula, arglist)
        getattr(ws, "import")(param, ROOT.RooFit.RecycleConflictNodes())

class Spline(object):

    def __init__(self,name,**kwargs):
        self.name = name
        self.mh = kwargs.pop('MH','MH')
        self.kwargs = kwargs

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        masses = self.kwargs.get('masses', [])
        values = self.kwargs.get('values', [])
        shifts = self.kwargs.get('shifts', {})
        channel = self.kwargs.get('channel', '')
        uncertainty = self.kwargs.get('uncertainty',0.000)
        splineName = label
        print "Building splines:", label
        if shifts:
            if isinstance(values,list):
                args = ROOT.TList()
                centralName = '{0}_central'.format(label)
                splineCentral = buildSpline(ws,centralName,self.mh,masses,values)
                shiftFormula = '@0'
                args.Add(splineCentral)
                for shift in shifts:
                    up = [u-c for u,c in zip(shifts[shift]['up'],values)]
                    down = [c-d for d,c in zip(shifts[shift]['down'],values)]
                    #print "Shift", shift
                    #print zip(shifts[shift]['up'],values)
                    #print zip(shifts[shift]['down'],values)
                    #print zip(up, values)
                    #print zip(down, values)
                    upName = '{0}_{1}Up'.format(splineName,shift)
                    downName = '{0}_{1}Down'.format(splineName,shift)
                    if any([ v == 0 for v in values]):
                        logging.warning('Zero value for {}: {}'.format(splineName, ' '.join(['{}'.format(v) for v in values])))
                    if any([abs(u/v)>0.0 if v else u for u,v in zip(up,values)]) or any([abs(d/v)>0.0 if v else d for d,v in zip(down,values)]):
                        if shift == 'tauIDScale':
                            shiftText = shift+'_'+channel.split('_')[-1]
                        else:
                            shiftText = channel+'_'+shift
                        ws.factory('{}[0,-10,10]'.format(shiftText))
                        #ws.factory('{}[0,-10,10]'.format(shift))
                        
                        splineUp   = buildSpline(ws,upName,  self.mh,masses,up)
                        splineDown = buildSpline(ws,downName,self.mh,masses,down)
                        
                        #if 'integral' in splineName:
                        if False:
                            shiftFormula += ' + TMath::Max(0,TMath::Exp(@{shift})-1)*({up}) + TMath::Min(0,TMath::Exp(@{shift})-1)*({down})'.format(shift=len(args),up=len(args)+1,down=len(args)+2)
                        else:
                            shiftFormula += ' + TMath::Max(0,@{shift})*@{up} + TMath::Min(0,@{shift})*@{down}'.format(shift=len(args),up=len(args)+1,down=len(args)+2)
                        
                        #print "Building splines:", ws.var(shiftText)
                        args.Add(ws.var(shiftText))
                        args.Add(splineUp)
                        args.Add(splineDown)
                if isinstance(uncertainty,list):
                #if False:
                #if not 'mean_sigx' in splineName or not 'integral' in splineName:
                #if 'integral' in splineName:
                    up = uncertainty
                    down = uncertainty
                    #print "Uncertainty:"
                    #print zip(up,values)
                    #print zip(down,values)
                    upName = '{0}_{1}Up'.format(splineName,"uncrt")
                    downName = '{0}_{1}Down'.format(splineName,"uncrt")
                    shiftText = 'uncrt_'+splineName
                    ws.factory('{}[0,-10,10]'.format(shiftText))
                    #ws.factory('{}[0,-10,10]'.format(shift))
                    splineUp   = buildSpline(ws,upName,  self.mh,masses,up)
                    splineDown = buildSpline(ws,downName,self.mh,masses,down)
                    #if 'integral' in splineName or 'mean' in splineName or 'sigma' in splineName or 'width' in splineName:
                    #if 'integral' in splineName:
                    if False:
                        shiftFormula += ' + TMath::Max(0,TMath::Exp(@{shift})-1)*({up}) + TMath::Min(0,TMath::Exp(@{shift})-1)*({down})'.format(shift=len(args),up=len(args)+1,down=len(args)+2)
                    else:
                        shiftFormula += ' + TMath::Max(0,@{shift})*@{up} + TMath::Min(0,@{shift})*@{down}'.format(shift=len(args),up=len(args)+1,down=len(args)+2)
                    args.Add(ws.var(shiftText))
                    args.Add(splineUp)
                    args.Add(splineDown)
                
                arglist = ROOT.RooArgList(args)
                spline = ROOT.RooFormulaVar(splineName, splineName, shiftFormula, arglist)
            else:
                MH = self.mh
                if not isinstance(MH, list): MH = [MH]
                args = ROOT.RooArgList(*[ws.var(mh) for mh in MH])

                #expr = str(values.GetExpFormula())
                #dims = ['x','y','z']
                #for d in range(len(MH)):
                #    expr = expr.replace(dims[d],'@{}'.format(d))

                params = []
                for p in range(values.GetNpar()):
                    pargs = ROOT.RooArgList()
                    c = values.GetParameter(p)
                    shiftFormula = '({:g})'.format(c)
                    for shift in shifts:
                        u = shifts[shift]['up'].GetParameter(p)
                        d = shifts[shift]['down'].GetParameter(p)
                        up = u-c
                        down = c-d
                        if c and (abs(up/c)<uncertainty and abs(down/c)<uncertainty): continue
                        ws.factory('{}[0,-10,10]'.format(shift))
                        shiftFormula += ' + TMath::Max(0,@{shift})*({up:g}) + TMath::Min(0,@{shift})*({down:g})'.format(shift=len(pargs),up=up,down=down)
                        pargs.add(ws.var(shift))
                    pname = 'p{}_{}'.format(p,splineName)
                    pform = ROOT.RooFormulaVar(pname,pname,shiftFormula,pargs)
                    params += [pform]
                    #args.add(pform)
                    #expr = expr.replace('[p{}]'.format(p),'@{}'.format(len(MH)+p))

                #spline = ROOT.RooFormulaVar(splineName, splineName, expr, args)

                pargs = ROOT.RooArgList(*params)
                values.SetName(splineName)
                values.SetTitle(splineName)
                spline = ROOT.RooTFnBinding(splineName,splineName,values,args,pargs)


                #up = shifts[shift]['up']
                #down = shifts[shift]['down']
                #upName = '{0}_{1}Up'.format(splineName,shift)
                #downName = '{0}_{1}Down'.format(splineName,shift)
                #ws.factory('{}[0,-10,10]'.format(shift))
                #splineUp   = buildSpline(ws,upName,  self.mh,masses,up)
                #splineDown = buildSpline(ws,downName,self.mh,masses,down)
                #shiftFormula += ' + TMath::Max(0,@{shift})*(@{up}-@0) + TMath::Min(0,@{shift})*(@0-@{down})'.format(shift=len(args),up=len(args)+1,down=len(args)+2)
                #args.Add(ws.var(shift))
                #args.Add(splineUp)
                #args.Add(splineDown)
        else:
            spline = buildSpline(ws,splineName,self.mh,masses,values)
        getattr(ws, "import")(spline, ROOT.RooFit.RecycleConflictNodes())

class Polynomial(Model):

    def __init__(self,name,**kwargs):
        print 'DONT USE POLYNOMIAL'
        raise
        super(Polynomial,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        order = self.kwargs.get('order',1)
        params = ['p{}_{}'.format(o,label) for o in range(order)]
        ranges = [self.kwargs.get('p{}'.format(o),[0,-1,1]) for o in range(order)]
        ws.factory('Polynomial::{}({}, {{ {} }})'.format(label, self.x, ', '.join(['{}[{}]'.format(p,','.join([str(r) for r in rs])) for p,rs in zip(params,ranges)])))
        self.params = params

class PolynomialSpline(ModelSpline):

    def __init__(self,name,**kwargs):
        print 'DONT USE POLYNOMIAL'
        raise
        super(PolynomialSpline,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        order = self.kwargs.get('order',1)
        masses = self.kwargs.get('masses',[])
        paramSplines = {}
        params = []
        for o in range(order):
            ps = self.kwargs.get('p{}'.format(o), [])
            paramName = 'p{}_{}'.format(o,label)
            paramsSplines[o] = buildSpline(ws,paramName,self.mh,masses,ps)
            getattr(ws, "import")(paramSplines[o], ROOT.RooFit.RecycleConflictNodes())
            params += [paramName]
        ws.factory('Polynomial::{}({}, {{ {} }})'.format(label, self.x, ', '.join(['{}[0, -10, 10]'.format(p) for p in params])))
        self.params = params

class Chebychev(Model):

    def __init__(self,name,**kwargs):
        super(Chebychev,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        order = self.kwargs.get('order',1)
        params = ['p{}_{}'.format(o,label) for o in range(order)]
        ranges = [self.kwargs.get('p{}'.format(o),[0,-1,1]) for o in range(order)]
        for p,rs in zip(params,ranges):
            ws.factory('{}[{}]'.format(p,', '.join([str(r) for r in rs])))
        #ws.factory('Chebychev::{}({}, {{ {} }})'.format(label, self.x, ', '.join(['{}[{}]'.format(p,','.join([str(r) for r in rs])) for p,rs in zip(params,ranges)])))
        ws.factory('Chebychev::{}({}, {{ {} }})'.format(label, self.x, ', '.join(params)))
        self.params = params

class ChebychevSpline(ModelSpline):

    def __init__(self,name,**kwargs):
        super(ChebychevSpline,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        order = self.kwargs.get('order',1)
        masses = self.kwargs.get('masses',[])
        paramSplines = {}
        params = []
        for o in range(order):
            ps = self.kwargs.get('p{}'.format(o), [])
            paramName = 'p{}_{}'.format(o,label)
            paramsSplines[o] = buildSpline(ws,paramName,self.mh,masses,ps)
            getattr(ws, "import")(paramSplines[o], ROOT.RooFit.RecycleConflictNodes())
            params += [paramName]
        ws.factory('Chebychev::{}({}, {{ {} }})'.format(label, self.x, ', '.join(['{}[0, -10, 10]'.format(p) for p in params])))
        self.params = params

class Gaussian(Model):

    def __init__(self,name,**kwargs):
        super(Gaussian,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        mean = self.kwargs.get('mean',[1,0,1000])
        sigma = self.kwargs.get('sigma',[1,0,100])
        meanName  = mean if isinstance(mean,str) else 'mean_{0}'.format(label)
        sigmaName = sigma if isinstance(sigma,str) else 'sigma_{0}'.format(label)
        # variables
        if not isinstance(mean,str): ws.factory('{0}[{1}]'.format(meanName,', '.join(['{}'.format(m) for m in mean])))
        if not isinstance(sigma,str): ws.factory('{0}[{1}, {2}, {3}]'.format(sigmaName,*sigma))
        # build model
        ws.factory("Gaussian::{0}({1}, {2}, {3})".format(label,self.x,meanName,sigmaName))
        self.params = [meanName,sigmaName]

class GaussianSpline(ModelSpline):

    def __init__(self,name,**kwargs):
        super(GaussianSpline,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        masses = self.kwargs.get('masses', [])
        means  = self.kwargs.get('means',  [])
        sigmas = self.kwargs.get('sigmas', [])
        meanName  = 'mean_{0}'.format(label)
        sigmaName = 'sigma_{0}'.format(label)
        # splines
        meanSpline = buildSpline(ws,meanName,self.mh,masses,means)
        sigmaSpline = buildSpline(ws,sigmaName,self.mh,masses,sigmas)
        # import
        getattr(ws, "import")(meanSpline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(sigmaSpline, ROOT.RooFit.RecycleConflictNodes())
        # build model
        ws.factory("Gaussian::{0}({1}, {2}, {3})".format(label,self.x,meanName,sigmaName))
        self.params = [meanName,sigmaName]

class BreitWigner(Model):

    def __init__(self,name,**kwargs):
        super(BreitWigner,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        mean  = self.kwargs.get('mean',  [1,0,1000])
        width = self.kwargs.get('width', [1,0,100])
        meanName = mean if isinstance(mean,str) else 'mean_{0}'.format(label)
        widthName = width if isinstance(width,str) else 'width_{0}'.format(label)
        # variables
        if not isinstance(mean,str): ws.factory('{0}[{1}, {2}, {3}]'.format(meanName,*mean))
        if not isinstance(width,str): ws.factory('{0}[{1}, {2}, {3}]'.format(widthName,*width))
        # build model
        ws.factory("BreitWigner::{0}({1}, {2}, {3})".format(label,self.x,meanName,widthName))
        self.params = [meanName,widthName]

class BreitWignerSpline(ModelSpline):

    def __init__(self,name,**kwargs):
        super(BreitWignerSpline,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        masses = self.kwargs.get('masses', [])
        means  = self.kwargs.get('means',  [])
        widths = self.kwargs.get('widths', [])
        meanName  = 'mean_{0}'.format(label)
        widthName = 'width_{0}'.format(label)
        # splines
        meanSpline = buildSpline(ws,meanName,self.mh,masses,means)
        widthSpline = buildSpline(ws,sigmaName,self.mh,masses,widths)
        # import
        getattr(ws, "import")(meanSpline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(widthSpline, ROOT.RooFit.RecycleConflictNodes())
        # build model
        ws.factory("BreitWigner::{0}({1}, {2}, {3})".format(label,self.x,meanName,widthName))
        self.params = [meanName,widthName]

class Voigtian(Model):

    def __init__(self,name,**kwargs):
        super(Voigtian,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        mean  = self.kwargs.get('mean',  [1,0,1000])
        width = self.kwargs.get('width', [1,0,100])
        sigma = self.kwargs.get('sigma', [1,0,100])
        meanName  = mean if isinstance(mean,str) else 'mean_{0}'.format(label)
        widthName = width if isinstance(width,str) else 'width_{0}'.format(label)
        sigmaName = sigma if isinstance(sigma,str) else 'sigma_{0}'.format(label)
        # variables
        if not isinstance(mean,str): ws.factory('{0}[{1}, {2}, {3}]'.format(meanName,*mean))
        if not isinstance(width,str): ws.factory('{0}[{1}, {2}, {3}]'.format(widthName,*width))
        if not isinstance(sigma,str): ws.factory('{0}[{1}, {2}, {3}]'.format(sigmaName,*sigma))
        # build model
        ws.factory("Voigtian::{0}({1}, {2}, {3}, {4})".format(label,self.x,meanName,widthName,sigmaName))
        self.params = [meanName,widthName,sigmaName]

class VoigtianSpline(ModelSpline):

    def __init__(self,name,**kwargs):
        super(VoigtianSpline,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        masses = self.kwargs.get('masses', [])
        means  = self.kwargs.get('means',  [])
        widths = self.kwargs.get('widths', [])
        sigmas = self.kwargs.get('sigmas', [])
        meanName = 'mean_{0}'.format(label)
        widthName = 'width_{0}'.format(label)
        sigmaName = 'sigma_{0}'.format(label)
        # splines
        meanSpline = buildSpline(ws,meanName,self.mh,masses,means)
        widthSpline = buildSpline(ws,sigmaName,self.mh,masses,widths)
        sigmaSpline = buildSpline(ws,sigmaName,self.mh,masses,sigmas)
        # import
        getattr(ws, "import")(meanSpline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(widthSpline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(sigmaSpline, ROOT.RooFit.RecycleConflictNodes())
        # build model
        ws.factory("Voigtian::{0}({1}, {2}, {3}, {4})".format(label,self.x,meanName,widthName,sigmaName))
        self.params = [meanName,widthName,sigmaName]

class CrystalBall(Model):

    def __init__(self,name,**kwargs):
        super(CrystalBall,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        mean  = self.kwargs.get('mean',  [1,0,1000])
        width = self.kwargs.get('width', [1,0,100])
        sigma = self.kwargs.get('sigma', [1,0,100])
        a     = self.kwargs.get('a', [1,0,100])
        n     = self.kwargs.get('n', [1,0,100])
        meanName  = mean if isinstance(mean,str) else 'mean_{0}'.format(label)
        sigmaName = sigma if isinstance(sigma,str) else 'sigma_{0}'.format(label)
        aName     = a if isinstance(a,str) else 'a_{0}'.format(label)
        nName     = n if isinstance(n,str) else 'n_{0}'.format(label)
        # variables
        if not isinstance(mean,str): ws.factory('{0}[{1}, {2}, {3}]'.format(meanName,*mean))
        if not isinstance(sigma,str): ws.factory('{0}[{1}, {2}, {3}]'.format(sigmaName,*sigma))
        if not isinstance(a,str): ws.factory('{0}[{1}, {2}, {3}]'.format(aName,*a))
        if not isinstance(n,str): ws.factory('{0}[{1}, {2}, {3}]'.format(nName,*n))
        # build model
        ws.factory("RooCBShape::{0}({1}, {2}, {3}, {4}, {5})".format(label,self.x,meanName,sigmaName,aName,nName))
        self.params = [meanName,sigmaName,aName,nName]

class CrystalBallSpline(ModelSpline):

    def __init__(self,name,**kwargs):
        super(CrystalBallSpline,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        masses = self.kwargs.get('masses', [])
        means  = self.kwargs.get('means',  [])
        sigmas = self.kwargs.get('sigmas', [])
        a_s    = self.kwargs.get('a_s', [])
        n_s    = self.kwargs.get('n_s', [])
        meanName  = 'mean_{0}'.format(label)
        sigmaName = 'sigma_{0}'.format(label)
        aName     = 'a_{0}'.format(label)
        nName     = 'n_{0}'.format(label)
        # splines
        meanSpline  = buildSpline(ws,meanName,self.mh,masses,means)
        sigmaSpline = buildSpline(ws,sigmaName,self.mh,masses,sigmas)
        aSpline     = buildSpline(ws,aName,self.mh,masses,a_s)
        nSpline     = buildSpline(ws,nName,self.mh,masses,n_s)
        # import
        getattr(ws, "import")(meanSpline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(sigmaSpline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(aSpline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(nSpline, ROOT.RooFit.RecycleConflictNodes())
        # build model
        ws.factory("RooCBShape::{0}({1}, {2}, {3}, {4}, {5})".format(label,self.x,meanName,sigmaName,aName,nName))
        self.params = [meanName,sigmaName,aName,nName]

class DoubleCrystalBall(Model):

    def __init__(self,name,**kwargs):
        super(DoubleCrystalBall,self).__init__(name,**kwargs)
        

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        mean  = self.kwargs.get('mean',  [1,0,1000])
        sigma = self.kwargs.get('sigma', [1,0,100])
        a1     = self.kwargs.get('a1', [1,0,100])
        n1     = self.kwargs.get('n1', [1,0,100])
        a2     = self.kwargs.get('a2', [1,0,100])
        n2     = self.kwargs.get('n2', [1,0,100])    
        meanName  = mean if isinstance(mean,str) else 'mean_{0}'.format(label)
        sigmaName = sigma if isinstance(sigma,str) else 'sigma_{0}'.format(label)
        a1Name    = a1 if isinstance(a1,str) else 'a1_{0}'.format(label)
        n1Name    = n1 if isinstance(n1,str) else 'n1_{0}'.format(label)
        a2Name    = a2 if isinstance(a2,str) else 'a2_{0}'.format(label)
        n2Name    = n2 if isinstance(n2,str) else 'n2_{0}'.format(label)
        # variables
        if not isinstance(mean,str): ws.factory('{0}[{1}, {2}, {3}]'.format(meanName,*mean))
        if not isinstance(sigma,str): ws.factory('{0}[{1}, {2}, {3}]'.format(sigmaName,*sigma))
        if not isinstance(a1,str): ws.factory('{0}[{1}, {2}, {3}]'.format(a1Name,*a1))
        if not isinstance(n1,str): ws.factory('{0}[{1}, {2}, {3}]'.format(n1Name,*n1))
        if not isinstance(a2,str): ws.factory('{0}[{1}, {2}, {3}]'.format(a2Name,*a2))
        if not isinstance(n2,str): ws.factory('{0}[{1}, {2}, {3}]'.format(n2Name,*n2))

        # build model
        doubleCB = ROOT.DoubleCrystalBall(label, label, ws.arg(self.x), ws.arg(meanName), ws.arg(sigmaName), 
                   ws.arg(a1Name), ws.arg(n1Name), ws.arg(a2Name), ws.arg(n2Name) )
        self.wsimport(ws, doubleCB)
        ws.importClassCode(label)
        self.params = [meanName,sigmaName,a1Name,n1Name,a2Name,n2Name]

class DoubleCrystalBallSpline(ModelSpline):

    def __init__(self,name,**kwargs):
        super(DoubleCrystalBallSpline,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        masses = self.kwargs.get('masses', [])
        means  = self.kwargs.get('means',  [])
        sigmas = self.kwargs.get('sigmas', [])
        a1s    = self.kwargs.get('a1s', [])
        n1s    = self.kwargs.get('n1s', [])
        a2s    = self.kwargs.get('a2s', [])
        n2s    = self.kwargs.get('n2s', [])
        meanName  = 'mean_{0}'.format(label)
        sigmaName = 'sigma_{0}'.format(label)
        a1Name    = 'a1_{0}'.format(label)
        n1Name    = 'n1_{0}'.format(label)
        a2Name    = 'a2_{0}'.format(label)
        n2Name    = 'n2_{0}'.format(label)
        # splines
        meanSpline  = buildSpline(ws,meanName,self.mh,masses,means)
        sigmaSpline = buildSpline(ws,sigmaName,self.mh,masses,sigmas)
        a1Spline    = buildSpline(ws,a1Name,self.mh,masses,a1s)
        n1Spline    = buildSpline(ws,n1Name,self.mh,masses,n1s)
        a2Spline    = buildSpline(ws,a2Name,self.mh,masses,a2s)
        n2Spline    = buildSpline(ws,n2Name,self.mh,masses,n2s)
        # import
        getattr(ws, "import")(meanSpline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(sigmaSpline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(a1Spline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(n1Spline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(a2Spline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(n2Spline, ROOT.RooFit.RecycleConflictNodes())

        # build model
        doubleCB = ROOT.DoubleCrystalBall(label, label, ws.arg(self.x), ws.arg(meanName), ws.arg(sigmaName), 
                   ws.arg(a1Name), ws.arg(n1Name), ws.arg(a2Name), ws.arg(n2Name) )
        self.wsimport(ws, doubleCB)
        ws.importClassCode(label)
        self.params = [meanName,sigmaName,a1Name,n1Name,a2Name,n2Name]

class DoubleSidedGaussian(Model):

    def __init__(self,name,**kwargs):
        super(DoubleSidedGaussian,self).__init__(name,**kwargs)
        

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        mean   = self.kwargs.get('mean',  [1,0,1000])
        sigma1 = self.kwargs.get('sigma1', [1,0,100])
        sigma2 = self.kwargs.get('sigma2', [1,0,100])
        yMax   = self.kwargs.get('yMax',9999999)
        meanName   = mean if isinstance(mean,str) else 'mean_{0}'.format(label)
        sigma1Name = sigma1 if isinstance(sigma1,str) else 'sigma1_{0}'.format(label)
        sigma2Name = sigma2 if isinstance(sigma2,str) else 'sigma2_{0}'.format(label)
        # variables
        if not isinstance(mean,str): ws.factory('{0}[{1}, {2}, {3}]'.format(meanName,*mean))
        if not isinstance(sigma1,str): ws.factory('{0}[{1}, {2}, {3}]'.format(sigma1Name,*sigma1))
        if not isinstance(sigma2,str): ws.factory('{0}[{1}, {2}, {3}]'.format(sigma2Name,*sigma2))

        # build model
        doubleG = ROOT.DoubleSidedGaussian(label, label, ws.arg(self.x), ws.arg(meanName), ws.arg(sigma1Name), ws.arg(sigma2Name), yMax )
        self.wsimport(ws, doubleG)
        ws.importClassCode(label)
        self.params = [meanName,sigma1Name,sigma2Name]

class DoubleSidedGaussianSpline(ModelSpline):

    def __init__(self,name,**kwargs):
        super(DoubleSidedGaussianSpline,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        masses  = self.kwargs.get('masses', [])
        means   = self.kwargs.get('means',  [])
        sigma1s = self.kwargs.get('sigma1s', [])
        sigma2s = self.kwargs.get('sigma2s', [])
        yMax    = self.kwargs.get('yMax')
        meanName   = 'mean_{0}'.format(label)
        sigma1Name = 'sigma1_{0}'.format(label)
        sigma2Name = 'sigma2_{0}'.format(label)
        # splines
        meanSpline   = buildSpline(ws,meanName,self.mh,masses,means)
        sigma1Spline = buildSpline(ws,sigma1Name,self.mh,masses,sigma1s)
        sigma2Spline = buildSpline(ws,sigma2Name,self.mh,masses,sigma2s)
        # import
        getattr(ws, "import")(meanSpline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(sigma1Spline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(sigma2Spline, ROOT.RooFit.RecycleConflictNodes())

        # build model
        doubleG = ROOT.DoubleSidedGaussian(label, label, ws.arg(self.x), ws.arg(meanName), ws.arg(sigma1Name), ws.arg(sigma2Name), yMax )
        self.wsimport(ws, doubleG)
        ws.importClassCode(label)
        self.params = [meanName,sigma1Name,sigma2Name] 

class DoubleSidedVoigtian(Model):

    def __init__(self,name,**kwargs):
        super(DoubleSidedVoigtian,self).__init__(name,**kwargs)
        

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        mean   = self.kwargs.get('mean',  [1,0,1000])
        sigma1 = self.kwargs.get('sigma1', [1,0,100])
        sigma2 = self.kwargs.get('sigma2', [1,0,100])
        width1 = self.kwargs.get('width1', [1,0,100])
        width2 = self.kwargs.get('width2', [1,0,100])
        yMax   = self.kwargs.get('yMax')
        meanName   = mean if isinstance(mean,str) else 'mean_{0}'.format(label)
        sigma1Name = sigma1 if isinstance(sigma1,str) else 'sigma1_{0}'.format(label)
        sigma2Name = sigma2 if isinstance(sigma2,str) else 'sigma2_{0}'.format(label)
        width1Name = width1 if isinstance(width1,str) else 'width1_{0}'.format(label)
        width2Name = width2 if isinstance(width2,str) else 'width2_{0}'.format(label)
        # variables
        if not isinstance(mean,str): ws.factory('{0}[{1}, {2}, {3}]'.format(meanName,*mean))
        if not isinstance(sigma1,str): ws.factory('{0}[{1}, {2}, {3}]'.format(sigma1Name,*sigma1))
        if not isinstance(sigma2,str): ws.factory('{0}[{1}, {2}, {3}]'.format(sigma2Name,*sigma2))
        if not isinstance(width1,str): ws.factory('{0}[{1}, {2}, {3}]'.format(width1Name,*width1))
        if not isinstance(width2,str): ws.factory('{0}[{1}, {2}, {3}]'.format(width2Name,*width2))

        # build model
        doubleV = ROOT.DoubleSidedVoigtian(label, label, ws.arg(self.x), ws.arg(meanName), ws.arg(sigma1Name), ws.arg(sigma2Name), ws.arg(width1Name), ws.arg(width2Name), yMax )
        self.wsimport(ws, doubleV)
        ws.importClassCode(label)
        self.params = [meanName,sigma1Name,sigma2Name,width1Name,width2Name]

class DoubleSidedVoigtianSpline(ModelSpline):

    def __init__(self,name,**kwargs):
        super(DoubleSidedVoigtianSpline,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        masses  = self.kwargs.get('masses', [])
        means   = self.kwargs.get('means',  [])
        sigma1s = self.kwargs.get('sigma1s', [])
        sigma2s = self.kwargs.get('sigma2s', [])
        width1s = self.kwargs.get('width1s', [])
        width2s = self.kwargs.get('width2s', [])  
        yMax    = self.kwargs.get('yMax')
        meanName   = 'mean_{0}'.format(label)
        sigma1Name = 'sigma1_{0}'.format(label)
        sigma2Name = 'sigma2_{0}'.format(label)
        width1Name = 'width1_{0}'.format(label)
        width2Name = 'width2_{0}'.format(label)
        # splines
        meanSpline   = buildSpline(ws,meanName,self.mh,masses,means)
        sigma1Spline = buildSpline(ws,sigma1Name,self.mh,masses,sigma1s)
        sigma2Spline = buildSpline(ws,sigma2Name,self.mh,masses,sigma2s)
        width1Spline = buildSpline(ws,width1Name,self.mh,masses,width1s)
        width2Spline = buildSpline(ws,width2Name,self.mh,masses,width2s)
        # import
        getattr(ws, "import")(meanSpline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(sigma1Spline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(sigma2Spline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(width1Spline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(width2Spline, ROOT.RooFit.RecycleConflictNodes())

        # build model
        doubleV = ROOT.DoubleSidedVoigtian(label, label, ws.arg(self.x), ws.arg(meanName), ws.arg(sigma1Name), ws.arg(sigma2Name), ws.arg(width1Name), ws.arg(width2Name), yMax )
        self.wsimport(ws, doubleV)
        ws.importClassCode(label)
        self.params = [meanName,sigma1Name,sigma2Name,width1Name,width2Name] 

class Exponential(Model):

    def __init__(self,name,**kwargs):
        super(Exponential,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        lamb = self.kwargs.get('lamb',  [-1,-5,0])
        lambdaName = lamb if isinstance(lamb,str) else 'lambda_{0}'.format(label)
        # variables
        if not isinstance(lamb,str): ws.factory('{0}[{1}, {2}, {3}]'.format(lambdaName,*lamb))
        # build model
        ws.factory("RooExponential::{0}({1}, {2})".format(label,self.x,lambdaName))
        self.params = [lambdaName]

class PolynomialExpr(Model):

    def __init__(self,name,**kwargs):
        super(PolynomialExpr,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))

        # variables
        order = self.kwargs.get('order',1)
        ranges = [self.kwargs.get('p{}'.format(o),[0,-1,1]) for o in range(order+1)]
        params = []
        for i in range(order+1):
            if isinstance(ranges[i],str):
                params += [ranges[i]]
            else:
                name = 'p{}_{}'.format(i,label)
                params += [name]
                ws.factory('{}[{}, {}, {}]'.format(name,*ranges[i]))

        # build model
        expr = "EXPR::{0}('".format(label)
        for i in range(order+1):
            if i>1:
                expr += " + {1}*TMath::Power({0},{2})".format(self.x,params[i],i)
            elif i==1:
                expr += " + {1}*{0}".format(self.x,params[i])
            else:
                expr += "{0}".format(params[i])
        expr += "', {0}".format(self.x)
        for i in range(order+1):
            expr += ", {0}".format(params[i])
        expr += ")"
        ws.factory(expr)
        self.params = params

class ExpoPoly(Model):
    
    def __init__(self,name,**kwargs):
        super(ExpoPoly,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        order = self.kwargs.get('order',1)
        ranges = [self.kwargs.get('p{}'.format(o),[0,-1,1]) for o in range(order+1)]
        params = []
        for i in range(order+1):
            if isinstance(ranges[i],str):
                params += [ranges[i]]
            else:
                name = 'p{}_{}'.format(i,label)
                params += [name]
                ws.factory('{}[{}, {}, {}]'.format(name,*ranges[i]))
        # build model
        expr = "EXPR::{0}('TMath::Exp(".format(label)
        for i in range(order+1):
            if i>1:
                expr += " + {1}*TMath::Power({0},{2})".format(self.x,params[i],i)
            elif i==1:
                expr += " + {1}*{0}".format(self.x,params[i])
            else:
                expr += "{0}".format(params[i])
        expr += ")', {0}".format(self.x)
        for i in range(order+1):
            expr += ", {0}".format(params[i])
        expr += ")"
        ws.factory(expr)
        self.params = params

class Erf(Model):

    def __init__(self,name,**kwargs):
        super(Erf,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        erfScale = self.kwargs.get('erfScale', [1,0,10])
        erfShift = self.kwargs.get('erfShift', [0,0,100])
        erfScaleName = erfScale if isinstance(erfScale,str) else 'erfScale_{0}'.format(label)
        erfShiftName = erfShift if isinstance(erfShift,str) else 'erfShift_{0}'.format(label)
        # variables
        if not isinstance(erfScale,str): ws.factory('{0}[{1}, {2}, {3}]'.format(erfScaleName,*erfScale))
        if not isinstance(erfShift,str): ws.factory('{0}[{1}, {2}, {3}]'.format(erfShiftName,*erfShift))
        # build model
        # Warning, doesnt speed up and current integral is broken.
        #erfPdf = ROOT.RooErf(label, label, ws.arg(self.x), ws.arg(erfShiftName), ws.arg(erfScaleName))
        #self.wsimport(ws, erfPdf)
        #ws.importClassCode(label)
        ws.factory("EXPR::{0}('0.5*(TMath::Erf({2}*({1}-{3}))+1)', {1}, {2}, {3})".format(
            label,self.x,erfScaleName,erfShiftName)
        )
        self.params = [erfScaleName,erfShiftName]

class ErfSpline(ModelSpline):
        
    def __init__(self,name,**kwargs):
        super(ErfSpline,self).__init__(name,**kwargs)
    
    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        masses    = self.kwargs.get('masses', [])
        erfScales = self.kwargs.get('erfScales',  [])
        erfShifts = self.kwargs.get('erfShifts', [])
        erfScaleName = 'erfScale_{0}'.format(label)
        erfShiftName = 'erfShift_{0}'.format(label)
        # splines  
        erfScaleSpline = buildSpline(ws,erfScaleName,self.mh,masses,erfScales)
        erfShiftSpline = buildSpline(ws,erfShiftName,self.mh,masses,erfShifts)
        # import
        getattr(ws, "import")(erfScaleSpline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(erfShiftSpline, ROOT.RooFit.RecycleConflictNodes())
        # build model
        ws.factory("EXPR::{0}('0.5*(TMath::Erf({2}*({1}-{3}))+1)', {1}, {2}, {3})".format(
                   label,self.x,erfScaleName,erfShiftName)
        )
        self.params = [erfScaleName,erfShiftName]

class MaxwellBoltzmann(Model):

    def __init__(self,name,**kwargs):
        super(MaxwellBoltzmann,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        scale = self.kwargs.get('scale', [1,0,10])
        scaleName = scale if isinstance(scale,str) else 'scale_{0}'.format(label)
        # variables
        if not isinstance(scale,str): ws.factory('{0}[{1}, {2}, {3}]'.format(scaleName,*scale))
        # build model
        ws.factory("EXPR::{0}('{1}^2/{2}^3*exp(-{1}^2/(2*{2}^2))', {1}, {2})".format(
            label,self.x,scaleName)
        )
        self.params = [scaleName]

class MaxwellBoltzmannSpline(ModelSpline):
        
    def __init__(self,name,**kwargs):
        super(MaxwellBoltzmannSpline,self).__init__(name,**kwargs)
    
    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        masses    = self.kwargs.get('masses', [])
        scales = self.kwargs.get('scales',  [])
        scaleName = 'scale_{0}'.format(label)
        # splines  
        scaleSpline = buildSpline(ws,scaleName,self.mh,masses,scales)
        # import
        getattr(ws, "import")(scaleSpline, ROOT.RooFit.RecycleConflictNodes())
        # build model
        ws.factory("EXPR::{0}('{1}^2/{2}^3*exp(-{1}^2/(2*{2}^2))', {1}, {2})".format(
                   label,self.x,scaleName)
        )
        self.params = [scaleName]

class Beta(Model):

    def __init__(self,name,**kwargs):
        super(Beta,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        betaScale = self.kwargs.get('betaScale', [1,0,1])
        betaA = self.kwargs.get('betaA', [5,0,10])
        betaB = self.kwargs.get('betaB', [2,0,10])
        betaScaleName = betaScale if isinstance(betaScale,str) else 'betaScale_{0}'.format(label)
        betaAName = betaA if isinstance(betaA,str) else 'betaA_{0}'.format(label)
        betaBName = betaB if isinstance(betaB,str) else 'betaB_{0}'.format(label)
        # variables
        if not isinstance(betaScale,str): ws.factory('{0}[{1}, {2}, {3}]'.format(betaScaleName,*betaScale))
        if not isinstance(betaA,str): ws.factory('{0}[{1}, {2}, {3}]'.format(betaAName,*betaA))
        if not isinstance(betaB,str): ws.factory('{0}[{1}, {2}, {3}]'.format(betaBName,*betaB))
        # build model
        ws.factory("EXPR::{0}('TMath::BetaDist({1}*{2},{3},{4})', {1}, {2}, {3}, {4})".format(
            label,self.x,betaScaleName,betaAName,betaBName)
        )
        self.params = [betaScaleName,betaAName,betaBName]

class BetaConv(Model):

    def __init__(self,name,**kwargs):
        super(BetaConv,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        betaScale = self.kwargs.get('betaScale', [1,0,1])
        betaA = self.kwargs.get('betaA', [5,0,10])
        betaB = self.kwargs.get('betaB', [2,0,10])
        mean = self.kwargs.get('mean',[0])
        sigma = self.kwargs.get('sigma',[1,0,10])
        betaScaleName = betaScale if isinstance(betaScale,str) else 'betaScale_{0}'.format(label)
        betaAName = betaA if isinstance(betaA,str) else 'betaA_{0}'.format(label)
        betaBName = betaB if isinstance(betaB,str) else 'betaB_{0}'.format(label)
        meanName = mean if isinstance(mean,str) else 'mean_{0}'.format(label)
        sigmaName = sigma if isinstance(sigma,str) else 'sigma_{0}'.format(label)
        # variables
        if not isinstance(betaScale,str): ws.factory('{0}[{1}, {2}, {3}]'.format(betaScaleName,*betaScale))
        if not isinstance(betaA,str): ws.factory('{0}[{1}, {2}, {3}]'.format(betaAName,*betaA))
        if not isinstance(betaB,str): ws.factory('{0}[{1}, {2}, {3}]'.format(betaBName,*betaB))
        if not isinstance(mean,str): ws.factory('{0}[{1}]'.format(meanName,*mean))
        if not isinstance(sigma,str): ws.factory('{0}[{1}, {2}, {3}]'.format(sigmaName,*sigma))
        # build model
        ws.factory("EXPR::{0}_beta('TMath::BetaDist({1}*{2},{3},{4})', {1}, {2}, {3}, {4})".format(
            label,self.x,betaScaleName,betaAName,betaBName)
        )
        g = Gaussian('{}_gaus'.format(label),
                     mean = mean,
                     sigma = sigma,
        )
        print "Ploop"
        g.build(ws,'{}_gaus'.format(label))
        print "Pliip"
        f = ROOT.RooFFTConvPdf(label,label,ws.var(self.x),ws.pdf('{}_beta'.format(label)),ws.pdf('{}_gaus'.format(label)),2) 
        
        #f = ROOT.RooNumConvPdf(label,label,ws.var(self.x),ws.pdf('{}_beta'.format(label)),ws.pdf('{}_gaus'.format(label))) 
        getattr(ws,'import')(f)
        self.params = [betaScaleName,betaAName,betaBName,meanName,sigmaName]

class BetaSpline(ModelSpline):
        
    def __init__(self,name,**kwargs):
        super(BetaSpline,self).__init__(name,**kwargs)
    
    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        masses    = self.kwargs.get('masses', [])
        betaScales = self.kwargs.get('betaScales',  [])
        betaAs = self.kwargs.get('betaAs',  [])
        betaBs = self.kwargs.get('betaBs',  [])
        betaScaleName = 'betaScale_{0}'.format(label)
        betaAName = 'betaA_{0}'.format(label)
        betaBName = 'betaB_{0}'.format(label)
        # splines  
        betaScaleSpline = buildSpline(ws,betaScaleName,self.mh,masses,betaScales)
        betaASpline = buildSpline(ws,betaAName,self.mh,masses,betaAs)
        betaBSpline = buildSpline(ws,betaBName,self.mh,masses,betaBs)
        # import
        getattr(ws, "import")(betaScaleSpline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(betaASpline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(betaBSpline, ROOT.RooFit.RecycleConflictNodes())
        # build model
        ws.factory("EXPR::{0}('TMath::BetaDist({1}*{2},{3},{4})', {1}, {2}, {3}, {4})".format(
                   label,self.x,betaScaleName,betaAName,betaBName)
        )
        self.params = [betaScaleName,betaAName,betaBName]

class Landau(Model):

    def __init__(self,name,**kwargs):
        super(Landau,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        mu    = self.kwargs.get('mu', [1,0,10])
        sigma = self.kwargs.get('sigma', [1,0,100])
        muName    = mu    if isinstance(mu,str)    else 'mu_{0}'.format(label)
        sigmaName = sigma if isinstance(sigma,str) else 'sigma_{0}'.format(label)
        # variables
        if not isinstance(mu,str):    ws.factory('{0}[{1}, {2}, {3}]'.format(muName,*mu))
        if not isinstance(sigma,str): ws.factory('{0}[{1}, {2}, {3}]'.format(sigmaName,*sigma))
        # build model
        ws.factory("RooLandau::{0}({1}, {2}, {3})".format(
            label,self.x,muName,sigmaName)
        )
        self.params = [muName,sigmaName]

class LandauSpline(ModelSpline):
        
    def __init__(self,name,**kwargs):
        super(LandauSpline,self).__init__(name,**kwargs)
    
    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        masses    = self.kwargs.get('masses', [])
        mus       = self.kwargs.get('mus',  [])
        sigmas    = self.kwargs.get('sigmas', [])
        muName    = 'mu_{0}'.format(label)
        sigmaName = 'sigma_{0}'.format(label)
        # splines  
        muSpline    = buildSpline(ws,muName,self.mh,masses,mus)
        sigmaSpline = buildSpline(ws,sigmaName,self.mh,masses,sigmas)
        # import
        getattr(ws, "import")(muSpline, ROOT.RooFit.RecycleConflictNodes())
        getattr(ws, "import")(sigmaSpline, ROOT.RooFit.RecycleConflictNodes())
        # build model
        ws.factory("RooLandau::{0}({1}, {2}, {3})".format(
                   label,self.x,muName,sigmaName)
        )
        self.params = [muName,sigmaName]

class Sum(Model):

    def __init__(self,name,**kwargs):
        self.doRecursive = kwargs.pop('recursive',False)
        self.doExtended = kwargs.pop('extended',False)
        super(Sum,self).__init__(name,**kwargs)

    #def recurse(self,curr,remaining):
    #    if len(remaining):
    #        return '{0}_frac*{0} + (1-{0}_frac)*({2})'.format(curr,self.recurse(remaining[0],remaining[1:]))
    #    else:
    #        return '{0}_frac*{0}'.format(curr)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        pdfs = []
        sumpdfs = []
        sumnames = []
        for n, (pdf, r) in enumerate(sorted(self.kwargs.iteritems())):
            if isinstance(r,str):
                sumnames += [r]
                sumpdfs += [pdf]
            elif len(r)==2:
                name = '{}_frac'.format(pdf)
                ws.factory('{0}[{1},{2}]'.format(name,*r))
                sumnames += [name]
                sumpdfs += [pdf]
            elif len(r)==3:
                name = '{}_frac'.format(pdf)
                ws.factory('{0}[{1},{2},{3}]'.format(name,*r))
                sumnames += [name]
                sumpdfs += [pdf]
            pdfs += [pdf]
        # build model
        if self.doRecursive:
            sumargs = ['{0}*{1}'.format(name,pdf) for name,pdf in zip(sumnames[:-1],sumpdfs[:-1])] + [sumpdfs[-1]]
            ws.factory("RSUM::{0}({1})".format(label, ', '.join(sumargs)))
        elif self.doExtended:
            sumargs = ['{0}*{1}'.format(name,pdf) for name,pdf in zip(sumnames,sumpdfs)]
            ws.factory("SUM::{0}({1})".format(label, ', '.join(sumargs)))
        else: # Don't do this if you have more than 2 pdfs ...
            if len(sumpdfs)>1: logging.warning('This sum is not guaranteed to be positive because there are more than two arguments. Better to use the option recursive=True.')
            sumargs = ['{0}*{1}'.format(name,pdf) for name,pdf in zip(sumnames[:-1],sumpdfs[:-1])] + [sumpdfs[-1]]
            ws.factory("SUM::{0}({1})".format(label, ', '.join(sumargs)))
        self.params = sumnames

class Expression(Model):

    def __init__(self,name,**kwargs):
        super(Expression,self).__init__(name,**kwargs)

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        expr = self.kwargs.pop('expr','')
        thevars = self.kwargs.pop('variables',[])
        for tv in thevars:
            v = self.kwargs.get(tv,'')
            if not isinstance(v,str): ws.factory('{name}[{vals}]'.format(name=tv, vals=', '.join([str(x) for x in v])))
        if expr:
            ws.factory('expr::{name}("{expr}",{thevars})'.format(name=label, expr=expr, thevars=', '.join(thevars)))
        self.params = thevars

class Prod(Model):

    def __init__(self,name,*args,**kwargs):
        super(Prod,self).__init__(name,**kwargs)
        self.args = args

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        ws.factory("PROD::{0}({1})".format(label, ', '.join(self.args)))
        self.params = []

class ProdSpline(ModelSpline):

    def __init__(self,name,*args,**kwargs):
        super(ProdSpline,self).__init__(name,**kwargs)
        self.args = args

    def build(self,ws,label):
        logging.debug('Building {}'.format(label))
        ws.factory("PROD::{0}({1})".format(label, ', '.join(self.args)))
        self.params = []
