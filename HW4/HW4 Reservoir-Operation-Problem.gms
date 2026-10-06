$ontext
CEE 6410 - Engineering Systems Analysis
Homework 4 - Reservoir Operation Problem

THE PROBLEM:

A reservoir is designed to provide hydropower and water for irrigation. 

Hydropower and Irrigation Problem Data
Month   Inflow Units   Hydropower Benefits ($/unit)   Irrigation Benefits ($/unit)
1       2              1.6                            1.0
2       2              1.7                            1.2
3       3              1.8                            1.9
4       4              1.9                            2.0
5       3              2.0                            2.2
6       2              2.0                            2.2

Determine the optimal release amounts between storage, spill, hydropower turbine, diversion to irrigation, and river at point A.

THE SOLUTION:
Uses General Algebraic Modeling System to Solve this Linear Program

Samuel T. Torgersen-Gonzalez
s.torgersen-gonzalez@usu.edu
October 5, 2026
$offtext

* 1. DEFINE the SETS
SETS
   time months /1*6/;

* 2. DEFINE input data
PARAMETERS
   inflow(time) estimated inflow per month (units)
         /1     2
          2     2
          3     3
          4     4
          5     3
          6     2/

   hydro_ben(time) hydropower benefits per month ($ per unit)
         /1     1.6
          2     1.7
          3     1.8
          4     1.9
          5     2.0
          6     2.0/
          
   irr_ben(time) irrigation benefits per month ($ per unit)
         /1     1.0
          2     1.2
          3     1.9
          4     2.0
          5     2.2
          6     2.2/;

SCALARS
   stor_i       initial reservoir storage       /5/
   stor_max     maximum reservoir capacity      /9/
   turb_max     maximum turbine capacity        /4/
   min_flow     minimum river flow at point A   /1/;


* 3. DEFINE the variables
VARIABLES
   storage(time)    reservoir storage at the end of month (units)
   hydro(time)      water released through turbines (units)
   spill(time)      water spilled to river (units)
   irr(time)        water diverted to irrigation (units)
   flowA(time)      instream flow at point A (units)
   benefit          total economic benefit ($);

* Non-negativity constraints
POSITIVE VARIABLES storage, hydro, spill, irr, flowA;

* 4. COMBINE variables and data in equations
EQUATIONS
   max_benefit              Objective function to maximize total benefits ($)
   mass_balance(time)       Reservoir storage mass balance equation (units)
   turbine_capacity(time)   Hydropower turbine capacity limit (units)
   storage_capacity(time)   Reservoir maximum storage volume limit (units)
   river_flow(time)         Flow continuity downstream of the dam before irrigation (units)
   flow_at_A(time)          In-stream flow requirement at point A (units)
   ending_storage           Ending storage must be greater than or equal to initial storage (units);

max_benefit..               benefit =E= SUM(time, hydro_ben(time)*hydro(time) + irr_ben(time)*irr(time));
mass_balance(time)..        storage(time) =E= (stor_i$(ORD(time)=1) + storage(time-1)$(ORD(time)>1)) + inflow(time) - hydro(time) - spill(time);
turbine_capacity(time)..    hydro(time) =L= turb_max;
storage_capacity(time)..    storage(time) =L= stor_max;
river_flow(time)..          flowA(time) + irr(time) =E= hydro(time) + spill(time);
flow_at_A(time)..           flowA(time) =G= min_flow;
ending_storage..            storage('6') =G= stor_i;

* 5. DEFINE the MODEL from the EQUATIONS
*Can write explicitly
*MODEL SHIPPING /COST, SUPPLY_CONSTRAIN, DEAL_CONSTRAIN/;
*Alternative way to write (include all previously defined equations)
MODEL RESERVOIR /ALL/;

* 6. SOLVE the MODEL
* Solve the PRODUCTING model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
SOLVE RESERVOIR USING LP MAXIMIZING BENEFIT;


* 7. CLick File menu => RUN (F9) or Solve icon and examine solution report in .LST file
