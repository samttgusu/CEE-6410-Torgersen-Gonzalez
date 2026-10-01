$ontext
CEE 6410 - Engineering Systems Analysis
Example 2.1 from Bishop Et Al Text (https://digitalcommons.usu.edu/ecstatic_all/76/)
Modifies Example to add a labor constraint

THE PROBLEM:

An manufacturer can produce two types of vehicles: coups and minivans.  Data are as fol-lows:

Seasonal Resource
Inputs or Profit        Vehicles        Resource
Availability
        Coups        Minivans
Metal        1000 lbs/vehicle        2000 lbs/vehicle      4000000 lbs/year
Circut Boards        4 circut boards/vehicle        3 circut boards/vehicle               12000 circut boards/year
Labor         5 days/vehicle        2.5 days/vehicle              17,500 days/year
Profit/vehicle        $6000        $7000

                Determine the optimal production for the two vehicles.

THE SOLUTION:
Uses General Algebraic Modeling System to Solve this Linear Program

Created:
David E Rosenberg
david.rosenberg@usu.edu
September 15, 2015

Modified:
Samuel T. Torgersen-Gonzalez
s.torgersen-gonzalez@usu.edu
September 21, 2026
$offtext

* 1. DEFINE the SETS
SETS vhcl vehicles produced /Coups, Minivans/
     res resources /Metal, CircutBoards, Labor/;

* 2. DEFINE input data
PARAMETERS
   c(vhcl) Objective function coefficients ($ per vehicle)
         /Coups 6000,
        Minivans 7000 /

   b(res) Right hand constraint values (per resource)
          /Metal 4000000,
           CircutBoards  12000,
           Labor  17500/;

TABLE A(vhcl,res) Left hand side constraint coefficients
                 Metal    CircutBoards   Labor
 Coups           1000     4              5
 Minivans        2000     3              2.5;


* 3. DEFINE the variables
VARIABLES X(vhcl) vehicles produced (Number)
          VPROFIT  total profit ($);

* Non-negativity constraints
POSITIVE VARIABLES X;

* 4. COMBINE variables and data in equations
EQUATIONS
   PROFIT Total profit ($) and objective function value
   RES_CONSTRAIN(res) Resource Constraints;

PROFIT..                 VPROFIT =E= SUM(vhcl, c(vhcl)*X(vhcl));
RES_CONSTRAIN(res) ..    SUM(vhcl, A(vhcl,res)*X(vhcl)) =L= b(res);


* 5. DEFINE the MODEL from the EQUATIONS
MODEL PRODUCTING /PROFIT, RES_CONSTRAIN/;
*Altnerative way to write (include all previously defined equations)
*MODEL PRODUCTING /ALL/;


* 6. SOLVE the MODEL
* Solve the PRODUCTING model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
SOLVE PRODUCTING USING LP MAXIMIZING VPROFIT;


* 6. CLick File menu => RUN (F9) or Solve icon and examine solution report in .LST file
