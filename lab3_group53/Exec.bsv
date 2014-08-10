/*

Copyright (C) 2012

Arvind <arvind@csail.mit.edu>
Derek Chiou <derek@ece.utexas.edu>
Muralidaran Vijayaraghavan <vmurali@csail.mit.edu>

Copyright (C) 2014

Amey Karkare <karkare@cse.iitk.ac.in>
  
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

/* 
 
Change log:
 Jan 2014: Adapted to use for Computer Organisation course at IIT 
           Kanpur by Amey Karkare <karkare@cse.iitk.ac.in>
 
*/

import Types::*;
import ProcTypes::*;
import Vector::*;

(* noinline *)
function Data alu(Data a, Data b, AluFunc func);
  Data res = case(func)
     Add   : (a + b);
     Sub   : ?;
     And   : ?;
     Or    : ?;
     Xor   : ?;
     Nor   : ?;
     Slt   : ?;
     Sltu  : ?;
     LShift: ?;
     RShift: ?;
     Sra   : ?;
  endcase;
  return res;
endfunction

(* noinline *)
function Bool aluBr(Data a, Data b, BrFunc brFunc);
  Bool brTaken = case(brFunc)
    Eq  : ?;
    Neq : ?;
    Le  : ?;
    Lt  : ?;
    Ge  : ?;
    Gt  : ?;
    AT  : ?;
    NT  : ?;
  endcase;
  return brTaken;
endfunction

(* noinline *)
function Addr brAddrCalc(Addr pc, Data val, IType iType, Data imm, Bool taken);
  Addr pcPlus4 = pc + 4; 
  Addr targetAddr = case (iType)
    J  : ?;
    Jr : ?;
    Br : ?;
    Alu, Ld, St, Mfc0, Mtc0, Unsupported: pcPlus4;
  endcase;
  return targetAddr;
endfunction


(* noinline *)
function ExecInst exec(DecodedInst dInst, Data rVal1, Data rVal2, Addr pc, Addr ppc, Data copVal);
  ExecInst eInst = ?;
  Data aluVal2 = isValid(dInst.imm) ? validValue(dInst.imm) : rVal2;
  
  let aluRes = alu(rVal1, aluVal2, dInst.aluFunc);
  
  eInst.iType = dInst.iType;
  
  eInst.data = dInst.iType == Mfc0?
                 copVal :
               dInst.iType == Mtc0?
                 rVal1 :
               dInst.iType==St?
                 rVal2 :
               (dInst.iType==J || dInst.iType==Jr) ?
                 (pc+4) :
                 aluRes;
  
  let brTaken = aluBr(rVal1, rVal2, dInst.brFunc);
  let brAddr = brAddrCalc(pc, rVal1, dInst.iType, validValue(dInst.imm), brTaken);
  eInst.mispredict = brAddr != ppc;

  eInst.brTaken = brTaken;
  eInst.addr = (dInst.iType == Ld || dInst.iType == St) ? aluRes : brAddr;
  
  eInst.dst = dInst.dst;

  return eInst;
endfunction
