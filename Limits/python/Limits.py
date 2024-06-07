import os
import sys
import logging
import numbers

import ROOT

from CombineLimitsRunII.Limits.Models import Model, ModelSpline
from utilities import *

class Limits(object):
    '''
    Limits

    A class to encapsulate an analysis selection and produce 
    a datacard that can be read by the Higgs Combine tool.
    '''

    def __init__(self,name='w'):
        self.bins = []        # analysis bin
        self.observed = {}    # there is one observable per era/analysis/channel combination
        self.processes = {}   # background and signal processes
        self.groups = {}      # groups of systematics
        self.signals = []
        self.backgrounds = []
        self.models = {}      # models to add
        self.expected = {}    # expected yield, one per process/era/analysis/chanel combination
        self.systematics = {} # systematic uncertainties
        self.param_systematics = {}
        self.rates = []
        #self.rates = {}
        self.shapes = {}
        self.name = name
        self.channels = []
        self.workspace = self.buildWorkspace(self.name)

    def buildWorkspace(self,name):
        return ROOT.RooWorkspace(name)

    def wsimport(self, *args) :
        # getattr since import is special in python
        # NB RooWorkspace clones object
        if len(args) < 2 :
            # Useless RooCmdArg: https://sft.its.cern.ch/jira/browse/ROOT-6785
            args += (ROOT.RooCmdArg(),)
        return getattr(self.workspace, 'import')(*args)

    def __unwrap(self,hist):
        '''Convert 2D histogram to 1D'''
        nbins = hist.GetNbinsX()*hist.GetNbinsY()
        result = ROOT.TH1F(hist.GetName(),hist.GetTitle(),nbins,0,nbins)
        result.SetBinContent(0,hist.GetBinContent(0))
        result.SetBinError(0,hist.GetBinError(0))
        result.SetBinContent(nbins+1,hist.GetBinContent(nbins+1))
        result.SetBinError(nbins+1,hist.GetBinError(nbins+1))
        for nx in range(hist.GetNbinsX()):
            for ny in range(hist.GetNbinsY()):
                b = hist.GetBin(nx+1,ny+1)
                result.SetBinContent(b,hist.GetBinContent(b))
                result.SetBinError(b,hist.GetBinError(b))
        return result

    def addVar(self, var, varMin, varMax, unit='', label='', **kwargs):
        workspace = kwargs.pop('workspace',self.workspace)
        workspace.factory('{}[{}, {}]'.format(var,varMin,varMax))
        if unit:  workspace.var(var).setUnit(unit)
        if label: workspace.var(var).setPlotLabel(label)
        if label: workspace.var(var).SetTitle(label)

    def addMH(self, mhMin, mhMax, unit='', label='', **kwargs):
        self.addVar('MH',mhMin,mhMax,unit,label,**kwargs)

    def addMA(self, maMin, maMax, unit='', label='', **kwargs):
        self.addVar('MA',maMin,maMax,unit,label,**kwargs)

    def addX(self, xMin, xMax, unit='', label='',**kwargs):
        self.addVar('x',xMin,xMax,unit,label,**kwargs)

    def addY(self, yMin, yMax, unit='', label='',**kwargs):
        self.addVar('y',yMin,yMax,unit,label,**kwargs)

    def __check(self,test,stored,name='Object'):
        goodToAdd = True
        if 'all' in test: return goodToAdd
        for t in test:
            if t not in stored:
                logging.warning('{0} {1} not recognized.'.format(name,t))
                goodToAdd = False
        return goodToAdd

    def __checkBins(self,bins):
        return self.__check(bins,self.bins,name='Bin')

    def __checkProcesses(self,processes):
        return self.__check(processes,self.processes,name='Process')

    def setChannels(self,c):
        '''Add channel'''
        self.channels = c

    def addBin(self,b):
        '''Add bin to analysis'''
        if b in self.bins:
            logging.warning('Bin {0} already added.'.format(b))
        else:
            logging.debug('Adding bin {}'.format(b))
            self.bins += [b]

    def addProcess(self,proc,signal=False):
        '''
        Add a process to the datacard.
            parameters:
                signal   - bool            - Declares process to be a signal, default False
        '''
        if proc in self.processes:
            logging.warning('Process {0} already added.'.format(proc))
        else:
            logging.debug('Adding process {}'.format(proc))
            self.processes[proc] = {
                'signal'  : signal,
            }
            if signal:
                self.signals += [proc]
            else:
                self.backgrounds += [proc]

    def addSystematic(self,systname,mode,systematics={}):
        '''
        Add a systematic uncertainty. The name can include the following string
        formatting replacements to set uncorrelated:
            {process}  : uncorrelate process
            {bin}      : uncorrelate bin
        The supported modes are:
            'lnN'  : log normal uncertainty shape
            'gmN X': gamma function uncertainty shape
            'shape': for shape based uncertainties
            'param': for parameter on unbinned uncertainty
            'flatParam': for freely floating parameter
        The values are set with the 'systematics' arguments. They are dictionaries with the form:
            systematics = {
               (processes,bins) : value,
            }
        where the key is a tuple of process, bin the systematic covers, each
        of which is another tuple of the components this sytematic covers.
        'value' is either a number for a rate systematic or a TH1 histogram for a shape uncertainty.
        For asymmetric uncertainties, a tuple should be passed with the first the shift up
        and the second the shift down.
        '''
        logging.debug('addSystematic')
        logging.debug(', '.join([systname,mode,str(systematics)]))
        if systname in self.systematics:
            logging.warning('Systematic {0} already added.'.format(systname))
        else:
            logging.debug('Adding systematic {} ({})'.format(systname,mode))
            if mode in ['param','flatParam']:
                self.param_systematics[systname] = {
                    'mode'  : mode,
                    'values': systematics,
                }
            else:
                goodToAdd = True
                for syst in systematics:
                    processes,bins = syst
                    #goodToAdd = goodToAdd and self.__checkProcesses(processes)
                    #goodToAdd = goodToAdd and self.__checkBins(bins)
                if goodToAdd:
                    self.systematics[systname] = {
                        'mode'  : mode,
                        'values': systematics,
                    }

    def addGroup(self,groupname,*systnames):
        '''Add a group name for a list of systematics'''
        logging.debug('Adding group {}'.format(groupname))
        self.groups[groupname] = systnames

    def addRateParam(self,ratename,bin,process,filename=None,workspace=None):
        logging.debug('Adding rate param {}'.format(ratename))
        self.rates += [{
            'name': ratename,
            'bin': bin,
            'process': process,
        }]
        if filename: self.rates[-1]['filename'] = filename
        if workspace: self.rates[-1]['workspace'] = workspace
        #self.rates[ratename] = {
        #    'name': ratename,
        #    'bin': bin,
        #    'process': process,
        #}
        #if filename: self.rates[ratename]['filename'] = filename
        #if workspace: self.rates[ratename]['workspace'] = workspace
        
    def addShape(self,bin,process,shape):
        '''
        Add a shape definition. By default, shapes are stored
        as [$WORKSPACE:]$PROCESS_$BIN[_$SYSTEMATIC].
        To override, pass the name of the PDF/histogram for a
        given bin/process as "shape".
        Example:
            addShape("bin0","sig","signal")
            will change [$WORKSPACE:]sig_bin0[_$SYSTEMATIC] default to [$WORKSPACE:]signal[_$SYSTEMATIC]
        '''
        self.shapes[(bin,process)] = shape

    def getSystematic(self,systname,process,bin):
        '''Return the systematic value for a given systematic/process/bin combination.'''
        # make sure it exists:
        result = 1.
        for syst in self.systematics:
            fullSystName = syst.format(process=process,bin=bin)
            if fullSystName != systname: continue
            # check if there is a systematic value for this combination
            for syst_vals in self.systematics[syst]['values']:
                #print "DEBUG3:", syst_vals
                s_processes, s_bins = syst_vals
                if process not in s_processes and 'all' not in s_processes: continue
                if bin not in s_bins and 'all' not in s_bins: continue
                # return the value
                result = self.systematics[syst]['values'][syst_vals]
        if isinstance(result,ROOT.TH2):
            result = self.__unwrap(result)
        if isinstance(result,tuple) or isinstance(result,list):
            if len(result)==2 and isinstance(result[0],ROOT.TH2):
                result = (self.__unwrap(result[0]),self.__unwrap(result[1]),)
        return result

    def __getSystematicRows(self,syst,processes,bin):
        '''
        Return a dictionary of the systematic values of the form:
            systs = {
                systname : {
                    'mode' : 'lnN',
                    'systs': {
                        (bin,'proc_1'): 1.,
                        ...
                    },
                },
            }
        '''
        systs = {}
        for process in processes:
            systname = syst.format(process=process,bin=bin)
            if systname not in systs:
                systs[systname] = {
                    'mode' : self.systematics[syst]['mode'], 
                    'systs': {},
                }
            systs[systname]['systs'][(bin,process)] = self.getSystematic(systname,process,bin)
        return systs

    def __combineSystematics(self,*systs):
        '''Combine systematics of the form output by __getSystematicRows.'''
        combinedSyst = {}
        for syst in systs:
            for systname in syst:
                if systname not in combinedSyst:
                    combinedSyst[systname] = {
                        'mode' : syst[systname]['mode'],
                        'systs': {},
                    }
                combinedSyst[systname]['systs'].update(syst[systname]['systs'])
        return combinedSyst

    def setObserved(self,bin,value):
        '''Set the observed value for a given bin.'''
        goodToAdd = True
        goodToAdd = goodToAdd and self.__checkBins([bin])
        if goodToAdd:
            logging.debug('Adding observed {} {}'.format(bin,value))
            self.observed[(bin)] = value

    def getObserved(self,bin,blind=True,addSignal=False):
        '''Get the observed value. If blinded returns the sum of the expected background.'''
        result = 0.
        if blind:
            bgs = self.backgrounds
            if addSignal: bgs += self.signals
            exp = [self.getExpected(process,bin) for process in bgs]
            if len(exp) and isinstance(exp[0],ROOT.TH1):
                hists = ROOT.TList()
                for e in exp:
                    hists.Add(e)
                if hists.IsEmpty():
                    result = 0.
                else:
                    hist = hists[0].Clone('h_exp')
                    hist.Reset()
                    hist.Merge(hists)
                    for b in range(hist.GetNbinsX()+1):
                        val = int(hist.GetBinContent(b))
                        err = val**0.5
                        hist.SetBinContent(b,val)
                        hist.SetBinError(b,err)
                    result = hist
            else:
                result = sum(exp)
        else:
            key = (bin)
            result = self.observed[key] if key in self.observed else 0.
        if isinstance(result,ROOT.TH2):
            result = self.__unwrap(result)
        logging.debug('Getting observed {} {}'.format(bin,result))
        return result


    def setExpected(self,process,bin,value):
        '''Set the expected value for a given process,bin.'''
        goodToAdd = True
        #goodToAdd = goodToAdd and self.__checkProcesses([process])
        #goodToAdd = goodToAdd and self.__checkBins([bin])
        if goodToAdd:
            logging.debug('Adding expected {} {} {}'.format(process,bin,value))
            self.expected[(process,bin)] = value

    def getExpected(self,process,bin):
        #print "expected:", self.expected
        '''Get the expected value.'''
        key = (process,bin)
        #print key
        val = self.expected[key] if key in self.expected else 0.
        if isinstance(val,ROOT.TH2):
            val = self.__unwrap(val)
        logging.debug('Getting expected {} {} {}'.format(process,bin,val))
        return val

    def printCard(self,filename,bins=['all'],processes=['all'],blind=True,addSignal=False,saveWorkspace=False,suffix=''):
        '''
        Print a datacard to file.
        Select the bins you want to include.
        Each will correspond to one bin in the datacard.
        '''

        shapes = self._printMultipleCards(filename,bins,processes,blind,addSignal,saveWorkspace,suffix)
        
        # shape file
        if saveWorkspace or shapes:
            outname = filename+'.root'
            if saveWorkspace:
                self.workspace.Print()
                self.workspace.SaveAs(outname)
                outfile = ROOT.TFile.Open(outname,'UPDATE')
            else:
                outfile = ROOT.TFile.Open(outname,'RECREATE')
            for shape in shapes:
                shape.Write('',ROOT.TObject.kOverwrite)
            outfile.Write()
            outfile.Close()

    def _printMultipleCards(self,filename,bins,processes,blind,addSignal,saveWorkspace,suffix):
        shapes = []
        print "_printMultipleCards"
        print "processes", processes
        if isinstance(bins,dict):
            for k,v in bins.iteritems():
                shapes += self._printMultipleCards(filename,v,processes,blind,addSignal,saveWorkspace,'{0}_{1}'.format(suffix,k))
        elif isinstance(processes,dict):
            for k,v in processes.iteritems():
                print "DEBUG2", filename, k, v, addSignal, '{0}_{1}'.format(suffix,k)
                shapes += self._printMultipleCards(filename,bins,v,blind,addSignal,saveWorkspace,'{0}_{1}'.format(suffix,k))
        else:
            print "printSingleCard"
            shapes += self._printSingleCard(filename,bins,processes,blind,addSignal,saveWorkspace,suffix)
        print "shapes:", shapes

        return shapes



    def _printSingleCard(self,filename,bins,processes,blind,addSignal,saveWorkspace,suffix):
        logging.info('Preparing {0}{1}.txt'.format(filename,suffix))
        goodToPrint = True
        goodToPrint = goodToPrint and self.__checkBins(bins)
        if not goodToPrint: return

        channels = self.channels

        backgroundsOrig = self.backgrounds

        signalName = ['ggH_haa'+suffix.replace("_amX", "").replace("hm", "")]
        
        if bins==['all']: bins = self.bins
        #if processes==['all']: processes = self.processes.keys()
        #signals = [x+'_'+y for x in self.signals for y in channels]
        signals = [x+'_'+y for x in signalName for y in channels]
        backgrounds = [x+'_'+y for x in self.backgrounds for y in channels]
        year = channels[0].split('_')[-1]
        control = [x+'_'+'control'+'_'+year for x in self.controls]
        print "DEBUG controls:", control, self.controls
        #control = [x.split('_')[0]+'_'+'control' for x in self.backgrounds]
        shapes = []

        #print "DEBUG0", signals, bins
        #print "DEBUG0", backgroundsOrig

        #nsignals=len(self.signals)
        nsignals = len(signals)
        nbackgrounds=len(self.backgrounds)
        
        # setup bins
        binRows = ['bin']
        observations = ['observation']
        binName = '{bin}'
        for bin in bins:
            blabel = binName.format(bin=bin)
            binRows += [blabel]
            obs = self.getObserved(bin,blind=blind,addSignal=addSignal)
            label = 'data_obs_{0}'.format(blabel)
            if isinstance(obs,ROOT.TH1):
                logging.debug('{0}: {1}'.format(label,obs.Integral()))
                obs.SetName(label)
                obs.SetTitle(label)
                shapes += [obs]
                if saveWorkspace:
                    datahist = ROOT.RooDataHist(label, label, ROOT.RooArgList(self.workspace.var("x")), obs)
                    logging.debug('Importing {}'.format(label))
                    self.wsimport(datahist)
                    obs = -1
                else:
                    obs = obs.Integral()
            else:
                logging.debug('{0}: {1}'.format(label,obs))
            # TODO: unbinned data handling
            observations += ['{0}'.format(obs)]
        imax = len(binRows)-1

        # setup processes
        jmax = len(processes)-1

        #totalColumns = len(bins)*len(processes)
        totalColumns = len(bins)*(nsignals+nbackgrounds)
        processesOrdered = signals + backgrounds + control
        binsForRates = ['bin','']+['']*totalColumns
        processNames = ['process','']+['']*totalColumns
        processNumbers = ['process','']+['']*totalColumns
        rates = ['rate','']+['']*totalColumns
        norms = []
        colpos = 2
        toSkip = []


        #processesOrderedNew=[]
        #for b in bins:
        #    for p in processesOrdered:
        #        process = p+'_'+bin.split('_')[-1]
        #        if "control" in b: processesOrderedNew += [p]
        #        elif process.split('_')[-1] == b.split('_')[0]:
        #            processOrderedNew += [process]

        #processesOrdered = processesOrderedNew
                    
        #print "DEBUG1",processesOrdered
        
        for bin in bins:
            #print "----------------"
            #print "bin:", bin
            print "processesOrdered", processesOrdered
            for process in processesOrdered:
                if 'control' in bin:
                    processText = process
                else:                    
                    processText = process+'_'+bin.split('_')[-1]
                exp = self.getExpected(processText,bin)
                print "exp",processText, bin, exp
                if not exp:
                    #print "DEBUG***"
                    toSkip += [(bin,processText)]
                    logging.warning('Skipping {} {}'.format(processText,bin))
                    continue
                binsForRates[colpos] = binName.format(bin=bin)
                #print "colpos:", colpos, "process:", processText, "binsForRates[colpos]:", binsForRates[colpos]
                
                #if binsForRates[colpos] == 'control':
                #    processNames[colpos] = process.split('_')[0]
                #else:
                #    processNames[colpos] = process
                processNames[colpos] = processText
                #print colpos, backgroundsOrig.index(process.split('_')[0])+1, len(signals)
                if 'haa' in process:
                    processNumbers[colpos] = '{0:<10}'.format(0)
                    #print "processNumbers[colpos]", colpos, processNumbers[colpos]
                else:
                    print "processNumbers[colpos]", backgroundsOrig, process, process.split('_')[0], '{0:<10}'.format(backgroundsOrig.index(process.split('_')[0])+1)
                    processNumbers[colpos] = '{0:<10}'.format(backgroundsOrig.index(process.split('_')[0])+1)
                    #print "processNumbers[colpos]", backgroundsOrig, process, bin, self.rstrip(process,'_'+bin), '{0:<10}'.format(backgroundsOrig.index(self.rstrip(process,'_'+bin))+1)
                    #processNumbers[colpos] = '{0:<10}'.format(backgroundsOrig.index(process.split('_')[0])+1)
                    #processNumbers[colpos] = '{0:<10}'.format(backgroundsOrig.index(self.rstrip(process,'_'+bin))+1)
                    #print "processNumbers[colpos]", colpos, processNumbers[colpos]
                #processNumbers[colpos] = '{0:<10}'.format(processesOrdered.index(process)-len(signals)+1)
                label = '{0}_{1}'.format(processNames[colpos],binsForRates[colpos])
                if isinstance(exp,ROOT.TH1): # it is a histogram (for shape analysis)
                    logging.debug('{0}: {1}'.format(label,exp.Integral()))
                    exp.SetName(label)
                    exp.SetTitle(label)
                    shapes += [exp]
                    if saveWorkspace:
                        datahist = ROOT.RooDataHist(label, label, ROOT.RooArgList(self.workspace.var("x")), exp)
                        logging.debug('Importing {}'.format(label))
                        self.wsimport(datahist)
                        exp = -1
                    else:
                        exp = exp.Integral()
                elif isinstance(exp,basestring): # it is in the workspace (for unbinned shape analysis)
                    logging.debug('{}: {}'.format(label,exp))
                    exp = 1
                elif isinstance(exp,numbers.Number): # it is a value (for binned analysis)
                    logging.debug('{0}: {1}'.format(label,exp))
                else:
                    logging.error('Failed to understand: {} {}'.format(bin,process))
                    #print exp
                    raise
                rates[colpos] = '{0:<10.4g}'.format(exp)
                # TODO: unbinned handling
                colpos += 1

        #print "DEBUG2",processesOrdered
        # other rateParams
        #print "rates:", self.rates
        for rate in self.rates:
            #print "rate:", rate
            n = rate['name']
            b = rate['bin']
            p = rate['process']
            f = rate.get('filename',filename+'.root')
            w = rate.get('workspace',self.name)
            #n = self.rates[rate]['name']
            #b = self.rates[rate]['bin']
            #p = self.rates[rate]['process']
            #f = self.rates[rate].get('filename',filename+'.root')
            #w = self.rates[rate].get('workspace',self.name)
            #if b in bins and p in processes:
            #    if b=='control':
            #        p=p.split('_')[0]
            #        n=n.replace('_TauETauHad','').replace('_TauMuTauHad','').replace('_TauETauMu','').replace('_TauHadTauHad','')
            norms += [[n,'rateParam',b,p,'{}:{}'.format(f,w)]]

        #print "SYSTS..."
        #print "systematics:", self.systematics
        # setup nuissances
        logging.debug('Systs available: {0}'.format([str(x) for x in sorted(self.systematics.keys())]))

        processes=[]
        for b in bins:
            if b == 'control': continue
            for proc in processesOrdered:
                if 'control' in proc: continue
                processes += [proc+'_'+b.split('_')[-1]]
        
        systs = {}
        keys = []
        for bin in bins:
            key = (bin)
            keys += [key]
            systs[key] = {}
            for syst in self.systematics:
                systs[key].update(self.__getSystematicRows(syst,processes,bin))


        #print "systs:", systs
        combinedSysts = self.__combineSystematics(*[systs[key] for key in systs])
        #print "combinedSysts", combinedSysts
        logging.debug('Systs to add: {0}'.format([str(x) for x in sorted(combinedSysts.keys())]))
        systRows = []
        for syst in sorted(combinedSysts.keys()):
            print "syst:", syst
            thisRow = [syst,combinedSysts[syst]['mode']]
            keep = False
            print "thisRow:",thisRow
            for bin in bins:
                for process in processesOrdered:
                    if bin == 'control':
                        processText = process
                    else:                    
                        processText = process+'_'+bin.split('_')[-1]
                    key = (bin,processText)
                    #print "key:", key
                    if key in toSkip: continue
                    s = '-'
                    #print "---:", combinedSysts[syst]['systs']
                    if key in combinedSysts[syst]['systs']:
                        s = combinedSysts[syst]['systs'][key]
                        #print s
                        if s==1:
                            s = '-'
                        elif isinstance(s,ROOT.TH1):
                            label = '{0}_{1}_{2}'.format(process,binName.format(bin=bin),syst)
                            s.SetName(label)
                            s.SetTitle(label)
                            shapes += [s]
                            if saveWorkspace:
                                datahist = ROOT.RooDataHist(label, label, ROOT.RooArgList(self.workspace.var("x")), s)
                                logging.debug('Importing {}'.format(label))
                                self.wsimport(datahist)
                            s = '1'
                            keep = True
                        elif isinstance(s,basestring):
                            label = '{0}_{1}_{2}'.format(process,binName.format(bin=bin),syst)
                            s = '1'
                            keep = True
                        elif (isinstance(s,tuple) or isinstance(s,list)) and len(s)==2:
                            if isinstance(s[0],ROOT.TH1):
                                label_up = '{0}_{1}_{2}Up'.format(process,binName.format(bin=bin),syst)
                                label_down = '{0}_{1}_{2}Down'.format(process,binName.format(bin=bin),syst)
                                s[0].SetName(label_up)
                                s[0].SetTitle(label_up)
                                s[1].SetName(label_down)
                                s[1].SetTitle(label_down)
                                shapes += s
                                if saveWorkspace:
                                    datahist_up = ROOT.RooDataHist(label_up, label_up, ROOT.RooArgList(self.workspace.var("x")), s[0])
                                    datahist_down = ROOT.RooDataHist(label_down, label_down, ROOT.RooArgList(self.workspace.var("x")), s[1])
                                    logging.debug('Importing {}'.format(label_up))
                                    self.wsimport(datahist_up)
                                    logging.debug('Importing {}'.format(label_down))
                                    self.wsimport(datahist_down)
                                s = '1'
                                keep = True
                            elif isinstance(s[0],basestring):
                                label_up = '{0}_{1}_{2}Up'.format(process,binName.format(bin=bin),syst)
                                label_down = '{0}_{1}_{2}Down'.format(process,binName.format(bin=bin),syst)
                                s = '1'
                                keep = True
                            elif isinstance(s[0],numbers.Number):
                                s = '{0:>4.4g}/{1:<4.4g}'.format(*s)
                                keep = True
                            else:
                                logging.error('Do not know how to handle {0}'.format(s))
                                raise
                        elif isinstance(s,numbers.Number):
                            s = '{0:<10.4g}'.format(s)
                            keep = True
                    thisRow += [s]
                    print "thisRow", thisRow
            if keep: systRows += [thisRow]
            #print "sysRows:", sysRows

        print 'Params systs to add: {0}'.format([str(x) for x in sorted(self.param_systematics.keys())])
        print self.param_systematics
        logging.debug('Params systs to add: {0}'.format([str(x) for x in sorted(self.param_systematics.keys())]))
        paramRows = []
        for param in sorted(self.param_systematics.keys()):
            #matching = [proc for proc in processesOrdered if proc in param]
            matching = []
            for proc in processesOrdered:
                if proc in param: matching+=[param]
            if not "ggH_haa" in param or param in matching:
                mode = self.param_systematics[param]['mode']
                if mode in ['flatParam']:
                    paramRows += [[param,mode]]
                else:
                    values = self.param_systematics[param]['values']
                    paramRows += [[param,mode]+values]

        kmax = len(systRows)

        # now write to file
        logging.info('Writing {0}{1}.txt'.format(filename,suffix))
        python_mkdir(os.path.dirname(filename))
        with open(filename+suffix+'.txt','w') as f:
            allRows = [binRows,observations,binsForRates,processNames,processNumbers,rates]+systRows
            lineWidth = 80
            firstWidth = max([len(x[0]) for x in allRows])+1
            restWidth = max([max([len(y) for y in x[1:]]) for x in allRows])+1
            def getline(row):
                try:
                    return '{0} {1}\n'.format(row[0][:firstWidth]+' '*max(0,firstWidth-len(row[0])), ''.join([r[:restWidth]+' '*max(0,restWidth-len(r)) for r in row[1:]]))
                except:
                    print row
                    e = sys.exc_info()[0]
                    print e
                    raise

            def getparamline(row):
                try:
                    return ' '.join([str(x) for x in row])+'\n'
                except:
                    print row
                    e = sys.exc_info()[0]
                    print e
                    raise

            # header
            #f.write('imax {0} number of bins\n'.format(imax))
            f.write('imax * number of bins\n')
            #f.write('jmax {0} number of processes\n'.format(jmax))
            f.write('jmax * number of processes\n')
            f.write('kmax * number of nuissances\n')
            f.write('-'*lineWidth+'\n')

            # shape information
            if saveWorkspace or shapes:
                for b in binRows[1:]:
                    #print "***b", b, "processes", processesOrdered
                    #print "self.shapes", self.shapes
                    if 'control' in b:
                        procString = '$PROCESS'
                    else:
                        procString = '$PROCESS_{0}'.format(b)
                    if saveWorkspace: procString = '{0}:{1}'.format(self.name,procString)
                    f.write('shapes * {0} {1}.root {2} {2}_$SYSTEMATIC\n'.format(b,filename,procString))
                    #print 'shapes * {0} {1}.root {2} {2}_$SYSTEMATIC\n'.format(b,filename,procString)
                    for proc in processesOrdered:
                        procText = proc+'_'+b.split('_')[-1]
                        key = (b,procText)
                        #print key
                        if key in self.shapes:
                            procString = self.shapes[key]
                            if saveWorkspace: procString = '{}:{}'.format(self.name,procString)
                            f.write('shapes {0} {1} {2}.root {3} {3}_$SYSTEMATIC\n'.format(procText,b,filename,procString))
                            #print 'shapes {0} {1} {2}.root {3} {3}_$SYSTEMATIC\n'.format(procText,b,filename,procString)

            else:
                f.write('shapes * * FAKE\n')
            f.write('-'*lineWidth+'\n')
            
            # observation
            f.write(getline(binRows))
            f.write(getline(observations))
            f.write('-'*lineWidth+'\n')

            # process definition
            logging.debug('Bins: {0}'.format([str(x) for x in binsForRates]))
            #print "binsForRates:", binsForRates
            #print "binsForRates:", processNames
            #print "binsForRates:", processNumbers
            f.write(getline(binsForRates))
            f.write(getline(processNames))
            f.write(getline(processNumbers))
            logging.debug('Rates: {0}'.format([str(x) for x in rates]))
            f.write(getline(rates))
            f.write('-'*lineWidth+'\n')

            # nuissances
            for systRow in systRows:
                logging.debug('Systematic row: {0}'.format([str(x) for x in systRow]))
                f.write(getline(systRow))
            f.write('-'*lineWidth+'\n')

            # rateParams
            for norm in norms:
                print "norm", norm
                if "ggH_haa_" in norm[0] and signalName[0] not in norm[0]: continue
                logging.debug('Rate param: {0}'.format([str(x) for x in norm]))
                f.write(getparamline(norm))

            # other params
            for paramRow in paramRows:
                logging.debug('Param: {}'.format([str(x) for x in paramRow]))
                f.write(getparamline(paramRow))

            # nuissance categories
            for group in self.groups:
                f.write('{0} group = {1}'.format(group,' '.join(self.groups[group])))

            #f.write('pdf_gg param 0 1')

        return shapes
