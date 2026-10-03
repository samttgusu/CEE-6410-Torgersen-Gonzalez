$ontext
CEE 6410 - Engineering Systems Analysis

Formulate and solve the PRIMAL and DUALs of THE PROBLEM:

An aqueduct has excess capacity in the months of June, July, & August.
  Hay or grain can be planted over a max of 10000 acres. Data are as follows:

                        Hay        Grain
June                    2          1            14000 acft
July                    1          2            18000 acft
August                  1          0             6000 acft
Land                    1          1            10000 acre
Return, $/acre          $100       $120

    Determine the optimal planting for the two crops.

THE SOLUTION:
Uses General Algebraic Modeling System to Solve this Linear Program

Samuel Torgersen-Gonzalez
s.torgersen-gonzalez@usu.edu
1 October 2026
$offtext

* 1. DEFINE the SETS
SETS plnt crops growing /Hay, Grain/
     mnth months /June, July, August, Land/;

* 2. DEFINE input data
PARAMETERS
   c(plnt) Objective function coefficients ($ per acre)
         /Hay   100,
          Grain 120/
   b(mnth) Right hand constraint values (acft per month)
          /June   14000,
           July   18000,
           August  6000
           Land   10000/;

TABLE A(plnt,mnth) Left hand side constraint coefficients
            June  July  August  Land     
 Hay        2     1     1       1  
 Grain      1     2     0       1     ;     

* 3. DEFINE the variables
VARIABLES X(plnt)  crop planted (acft)
          VPROFIT  total profit ($)
          Y(mnth)  value of months used (units specific to variable)
          VREDCOST total reduced cost ($);

* Non-negativity constraints
POSITIVE VARIABLES X,Y;

* 4. COMBINE variables and data in equations
EQUATIONS
   PROFIT_PRIMAL Total benefit ($) and objective function value
   RES_CONS_PRIMAL(mnth) Month constraints
   REDCOST_DUAL Reduced benefit ($) associated with using months
   RES_CONS_DUAL(plnt) Profit levels ;

*Primal Equations
PROFIT_PRIMAL..                 VPROFIT =E= SUM(plnt,c(plnt)*X(plnt));
RES_CONS_PRIMAL(mnth) ..    SUM(plnt,A(plnt,mnth)*X(plnt)) =L= b(mnth);

*Dual Equations
REDCOST_DUAL..                 VREDCOST =E= SUM(mnth,b(mnth)*Y(mnth));
RES_CONS_DUAL(plnt)..          sum(mnth,A(plnt,mnth)*Y(mnth)) =G= c(plnt);

X.LO(plnt) = 5;

* 5. DEFINE the MODELS
*PRIMAL model
MODEL PLANT_PRIMAL /PROFIT_PRIMAL, RES_CONS_PRIMAL/;
*Set the options file to print out range of basis information
PLANT_PRIMAL.optfile = 1;

*DUAL model
MODEL PLANT_DUAL /REDCOST_DUAL, RES_CONS_DUAL/;

* 6. SOLVE the MODELS
* Solve the PLANTING PRIMAL model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
SOLVE PLANT_PRIMAL USING LP MAXIMIZING VPROFIT;

* Solve the PLANTING DUAL model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
SOLVE PLANT_DUAL USING LP MINIMIZING VREDCOST;
*Order does not matter!

* 6. CLick File menu => RUN (F9) or Solve icon and examine solution report in .LST file

* 7 . Dump all data and results to GAMS proprietary file storage .gdx and to Excel
Execute_Unload "Ex2-1Dual.gdx";
* Dump the gdx file to an Excel workbook
Execute "gdx2xls Ex2-1Dual.gdx"
* To open the GDX file in the GAMS IDE, select File => Open.
* In the Open window, set Filetype to .gdx and select the file.
