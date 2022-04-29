/***************************************************************************** 
 * Project: RooFit                                                           * 
 *                                                                           * 
 * This code was autogenerated by RooClassFactory                            * 
 *****************************************************************************/ 

// Your description goes here... 

#include "CombineLimitsRunII/Limits/interface/DoubleSidedGaussian.h" 
#include "RooAbsReal.h" 
#include "RooAbsCategory.h" 
#include <math.h> 
#include "TMath.h" 
#include "RooGaussian.h"

ClassImp(DoubleSidedGaussian) 

DoubleSidedGaussian::DoubleSidedGaussian(const char *name, const char *title, 
                       RooAbsReal& _x,
                       RooAbsReal& _mean,
                       RooAbsReal& _sig1,
                       RooAbsReal& _sig2,
                       Double_t _yMax) :
  RooAbsPdf(name,title), 
  x("x","x",this,_x),
  mean("mean","mean",this,_mean),
  sig1("sig1","sig1",this,_sig1),
  sig2("sig2","sig2",this,_sig2),
  yMax(_yMax)
{
} 


DoubleSidedGaussian::DoubleSidedGaussian(const DoubleSidedGaussian& other, const char* name) :  
  RooAbsPdf(other,name), 
  x("x",this,other.x),
  mean("mean",this,other.mean),
  sig1("sig1",this,other.sig1),
  sig2("sig2",this,other.sig2),
  yMax(other.yMax)
{ 
} 



Double_t DoubleSidedGaussian::evaluate() const 
{ 
//   double result = -1;
//   double sqrt2pi = TMath::Power( 2 * TMath::Pi(), 0.5); 
//   double mode = mean - 2 / sqrt2pi * (sig2 - sig1);
// //  if (mode > yMax) 
// //    mode = yMax;
// //  double A = 2 / sqrt2pi / (sig1 + sig2); 
//   double A1 = 1 / (sig1*sqrt2pi), A2 = 1 / (sig2*sqrt2pi);
//   double scaleFactor = sig2 / sig1;
//   double total_integral = 0.5 * (1 + scaleFactor);
//   if ( x < mode)
//     result = A1 * TMath::Exp(-1 * (x-mode) * (x-mode) / (2 * sig1 * sig1)) / total_integral;
//   else
//     result = A2 * TMath::Exp(-1 * (x-mode) * (x-mode) / (2 * sig2 * sig2)) * scaleFactor / total_integral;
//   return result;

  // From wikipedia
  double result = -1;
  double sqrt2OverPi = TMath::Sqrt(2. / TMath::Pi());
  double mode = mean; // redefine mean to mode
  double A = sqrt2OverPi / (sig2+sig1);
  if (x < mode)
    result = A * TMath::Exp( -1 * (x-mode)*(x-mode) / (2*sig1*sig1) );
  else
    result = A * TMath::Exp( -1 * (x-mode)*(x-mode) / (2*sig2*sig2) );
  return result;
} 

