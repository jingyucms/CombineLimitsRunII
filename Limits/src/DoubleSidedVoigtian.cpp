/***************************************************************************** 
 * Project: RooFit                                                           * 
 *                                                                           * 
 * This code was autogenerated by RooClassFactory                            * 
 *****************************************************************************/ 

// Your description goes here... 

#include "CombineLimitsRunII/Limits/interface/DoubleSidedVoigtian.h" 
#include "RooAbsReal.h" 
#include "RooAbsCategory.h" 
#include <math.h> 
#include <complex>
#include "TMath.h" 
#include "RooMath.h"
#include "RooVoigtian.h"

ClassImp(DoubleSidedVoigtian) 

DoubleSidedVoigtian::DoubleSidedVoigtian(const char *name, const char *title, 
                       RooAbsReal& _x,
                       RooAbsReal& _mean,
                       RooAbsReal& _sig1,
                       RooAbsReal& _sig2,
                       RooAbsReal& _wid1,
                       RooAbsReal& _wid2,
                       Double_t _yMax) :
  RooAbsPdf(name,title), 
  x("x","x",this,_x),
  mean("mean","mean",this,_mean),
  sig1("sig1","sig1",this,_sig1),
  sig2("sig2","sig2",this,_sig2),
  wid1("wid1","wid1",this,_wid1),
  wid2("wid2","wid2",this,_wid2),
  yMax(_yMax)
{ 
} 


DoubleSidedVoigtian::DoubleSidedVoigtian(const DoubleSidedVoigtian& other, const char* name) :  
  RooAbsPdf(other,name), 
  x("x",this,other.x),
  mean("mean",this,other.mean),
  sig1("sig1",this,other.sig1),
  sig2("sig2",this,other.sig2),
  wid1("wid1",this,other.wid1),
  wid2("wid2",this,other.wid2),
  yMax(other.yMax)
{ 
} 



Double_t DoubleSidedVoigtian::evaluate() const 
{ 
  double sqrttwologtwo = TMath::Power( 2*TMath::Log(2), 0.5);
  double gau1_width = sig1*sqrttwologtwo, gau2_width = sig2*sqrttwologtwo;
  double voigt1_width = 0.5346*wid1 + TMath::Power(.2166*wid1*wid1+gau1_width*gau1_width, 0.5);
  double voigt2_width = 0.5346*wid2 + TMath::Power(.2166*wid2*wid2+gau2_width*gau2_width, 0.5);
  double mode = mean - TMath::Power(2/TMath::Pi(), 0.5) * (voigt2_width - voigt1_width);
  if (mode > yMax)
    mode = yMax;
  double C1 = 1 / (TMath::Sqrt(2.0)*sig1); 
  double C2 = 1 / (TMath::Sqrt(2.0)*sig2);
  Double_t A1 = 0.5*C1*wid1;
  Double_t A2 = 0.5*C2*wid2;
  Double_t U1 = C1*(x-mean);
  Double_t U2 = C2*(x-mean);
  std::complex<Double_t> Z1(U1,A1) ;
  std::complex<Double_t> Z2(U2,A2) ;
  std::complex<Double_t> voigt(0.) ;
  std::complex<Double_t> Z1_at_mean(0,A1) ;
  std::complex<Double_t> Z2_at_mean(0,A2) ;
  std::complex<Double_t> voigt1_at_mean = RooMath::faddeeva(Z1_at_mean);
  std::complex<Double_t> voigt2_at_mean = RooMath::faddeeva(Z2_at_mean);
  //std::complex<Double_t> voigt1_at_mean = RooMath::faddeeva(Z1);
  //std::complex<Double_t> voigt2_at_mean = RooMath::faddeeva(Z2);
  double scale_factor = (voigt1_at_mean.real() / voigt2_at_mean.real()) * (sig2/sig1);
  double total_integral = .5 * (1+scale_factor);
  
  if ( x < mean)
  {
    voigt = RooMath::faddeeva(Z1);
    return 0.5 * C1 * voigt.real() / TMath::Power(TMath::Pi(), 0.5) / total_integral;
  }//if
  else
  {
    voigt = RooMath::faddeeva(Z2);
    return 0.5 * C2 * voigt.real() / TMath::Power(TMath::Pi(), 0.5) * scale_factor / total_integral;
  }//else

} 



