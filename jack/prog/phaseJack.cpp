//--------------------------------------------------------------------------
/**
 * @file phaseJack.cpp
 * @brief JK err for phase shift
 * @ingroup YAMADA
 * @author  M.YAMADA 
 * @date    Tue Jun 18 2013
 */
//--------------------------------------------------------------------------

#include <boost/lexical_cast.hpp>
#include <boost/foreach.hpp>
#include "../include/io.h"
#include "../include/jack.h"
#include "../include/analys.h"

using namespace std;
using boost::lexical_cast;

int main(){
  string inPath = "/home/sinyamada/results/set1/ts" + lexical_cast<string>(Tshiftsize) +
    "/spin00.bin" + lexical_cast<string>( binsize ) + "/phase/bin";
  string outPath = "/home/sinyamada/results/set1/ts" + lexical_cast<string>(Tshiftsize) +
    "/spin00.bin" + lexical_cast<string>( binsize ) + "/phase/jack";
  string physInfo = "RC16x32_B1830Kud013760Ks013710C1761";
  string func_array[] = {"1g1y1D_phase", 
			 "1g1y3D_phase", 
			 "1g1yy1D_phase", 
			 "1g1yy3D_phase" };  
  
  
  IODATA iod;
  iod.setReadBinaryMode(false);
  iod.setWriteBinaryMode(false);
  iod.setConfSize(binnumber);
  iod.setD("1D");
  int datasize = 1500;
  
  root_mkdir("outPath");
  
 BOOST_FOREACH( string funcType, func_array ){
   string staticsInfoIn = funcType;
   string staticsInfoOut = funcType + "_jack";
   
   
   for (int it =T_in; it<T_fi+1; it++) {
     JACK jackPot(Confsize,binsize,datasize);
     double *xData = new double[datasize]();
     iod.callData(xData,1,inPath,staticsInfoIn,physInfo,0,it);
     for (int j= 0; j <binnumber; j++) {
       double* yData = new double[datasize]();
       iod.callData(yData,2,inPath,staticsInfoIn,physInfo,j,it);
       for (int id =0; id <datasize; id++) {
	 //       cout << id<<" "<<xData[id]<<"   "<<yData[id] <<endl;
	 //        cout <<xData[1]<<"   "<<yData[1] <<endl;
       }
       jackPot.setBinData(yData,j);
       //jackPot.setData(yData,j);
       //iod.outData(data ,outPath ,staticsInfo,physInfo, j,it,300);                                                                                                                                    
       delete[] yData; 
     }
     double* err= new double[datasize];
     double* ave= new double[datasize];
     err= jackPot.calcErr();
     ave= jackPot.calcAve();
     for(int id = 0;id<datasize;id++){cout<<xData[id]<<" "<<ave[id]<<" "<<err[id]<<endl;}
     
     iod.outErr(xData,ave,err,outPath,staticsInfoOut,physInfo,700,it,datasize);  
     delete []xData;
   }
 }  
 cout<<"@End of all"<<endl;
 return 0;
}
