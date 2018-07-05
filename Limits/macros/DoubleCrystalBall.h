/*****************************************************************************
 * Project: RooFit                                                           *
 *                                                                           *
  * This code was autogenerated by RooClassFactory                            * 
 *****************************************************************************/

#ifndef MY_DOUBLE_CrystalBall
#define MY_DOUBLE_CrystalBall

#include "RooAbsPdf.h"
#include "RooRealProxy.h"
#include "RooCategoryProxy.h"
#include "RooAbsReal.h"
#include "RooAbsCategory.h"
 
class DoubleCrystalBall : public RooAbsPdf {
public:
  DoubleCrystalBall() {} ; 
  DoubleCrystalBall(const char *name, const char *title,
	      RooAbsReal& _x,
	      RooAbsReal& _mean,
	      RooAbsReal& _sig,
	      RooAbsReal& _a1,
	      RooAbsReal& _n1,
	      RooAbsReal& _a2,
	      RooAbsReal& _n2);
  DoubleCrystalBall(const DoubleCrystalBall& other, const char* name=0) ;
  virtual TObject* clone(const char* newname) const { return new DoubleCrystalBall(*this,newname); }
  inline virtual ~DoubleCrystalBall() { }

protected:

  RooRealProxy x ;
  RooRealProxy mean ;
  RooRealProxy sig ;
  RooRealProxy a1 ;
  RooRealProxy n1 ;
  RooRealProxy a2 ;
  RooRealProxy n2 ;
  
  Double_t evaluate() const ;

private:

  ClassDef(DoubleCrystalBall,1) // Your description goes here...
};
 
#endif

