//--------------------------------------------------------------------------
/**
 * @file phaseJack.cpp
 * @brief JK err for phase shift
 * @ingroup YAMADA
 * @author  M.YAMADA 
 * @date    Tue Jun 18 2013
 */
//--------------------------------------------------------------------------

#include "../include/io.h"
#include "../include/jack.h"
#include "../include/analys.h"
using namespace std;

int main(){
  string inPath = "/home/sinyamada/results/set1/ts22/spin00.bin50/phase/bin";
  string outPath = "/home/sinyamada/results/set1/ts22/spin00.bin50/phase/jack";
  string physInfo = "RC16x32_B1830Kud013760Ks013710C1761";
  string staticsInfoIn = "1g1y3D_energy";
  string staticsInfoOut = "1g1y3D_energy_jack";

  IODATA iod;
  iod.setReadBinaryMode(false);
  iod.setWriteBinaryMode(false);
  iod.setConfSize(binnumber);
  int datasize = 1;

  for (int it =T_in; it<T_fi+1; it++) {
    JACK jackPot(Confsize,binsize,datasize);
     for (int j= 0; j <binnumber; j++) {
      double* yData = new double[datasize]();
      double* ryData = new double[datasize]();
      iod.callData(yData,1,inPath,staticsInfoIn,physInfo,j,it);
      // for (int id =0; id <500; id++) {        cout << id<<" "<<xData[id]<<"   "<<yData[id] <<endl;}
	ryData[0] = yData[0];
        cout <<ryData[0] <<endl;
	jackPot.setBinData(ryData,j);
	//jackPot.setData(yData,j);
	//iod.outData(data ,outPath ,staticsInfo,physInfo, j,it,300);                                                                                                                                    
      delete[] yData; 
    }
    double* xData = new double[datasize]();
    double* err= new double[datasize];
    double* ave= new double[datasize];
    err= jackPot.calcErr();
    ave= jackPot.calcAve();
    for(int id = 0;id<datasize;id++){cout<<ave[id]<<" "<<err[id]<<endl;}
    iod.outErr(xData,ave,err,outPath,staticsInfoOut,physInfo,700,it,datasize);  
  }
  
  cout<<"@End of all"<<endl;
  return 0;
}
