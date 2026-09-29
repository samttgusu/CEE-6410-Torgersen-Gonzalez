$ontext
CEE 6410 - Engineering Systems Analysis
Homework 3 - Network Shipping Problem

THE PROBLEM:

An automobile company must decide how to move cars from suppliers in Kansas City
  and Dallas to dealerships in New York, Minneapolis, Seattle, and San Francisco.

Suppliers or Dealerships     Kansas City (KC)     Dallas (DAL)
New York (NY)                $12/car              $15/car       250 car
Minneapolis (MIN)            $4/car               $9/car        400 car
Seattle (SEA)                $18/car              $21/car       450 car
San Francisco (SF)           $18/car              $17/car       450 car
Vehicles/supplier            1000                 800

Determine the optimal shipping volumes to move cars between the locations.

THE SOLUTION:
Uses General Algebraic Modeling System to Solve this Linear Program

Created:
Samuel T. Torgersen-Gonzalez
s.torgersen-gonzalez@usu.edu
September 27, 2026
$offtext

* 1. DEFINE the SETS
SETS sup cars at suppliers /KC, DAL/
     deal dealerships /NY, MIN, SEA, SF/;

* 2. DEFINE input data
PARAMETERS
   c(sup) Objective function coefficients (cars per supplier)
         /KC  1000,
          DAL  800/

   b(deal) Right hand constraint values (number of sales at each dealership)
         /NY   250,
          MIN  400,
          SEA  450,
          SF   450/;

TABLE A(sup,deal) Left hand side constraint coefficients
        NY   MIN    SEA   SF
KC      12    4     18    18
DAL     15    9     21    17;


* 3. DEFINE the variables
VARIABLES X(sup,deal) cars to be shipped from supplier to dealership (Number)
          VCOST  total shipping cost ($);

* Non-negativity constraints
POSITIVE VARIABLES X;

* 4. COMBINE variables and data in equations
EQUATIONS
   COST Total cost ($) and objective function value
   SUPPLY_CONSTRAIN(sup) Supplier supply
   DEAL_CONSTRAIN(deal) Dealership orders;

COST..                    VCOST =E= SUM((sup,deal), A(sup,deal)*X(sup,deal));
SUPPLY_CONSTRAIN(sup)..   SUM(deal, X(sup,deal)) =L= c(sup);
DEAL_CONSTRAIN(deal)..    SUM(sup, X(sup,deal)) =G= b(deal);


* 5. DEFINE the MODEL from the EQUATIONS
MODEL SHIPPING /COST, SUPPLY_CONSTRAIN, DEAL_CONSTRAIN/;
*Altnerative way to write (include all previously defined equations)
*MODEL PRODUCTING /ALL/;


* 6. SOLVE the MODEL
* Solve the PRODUCTING model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
SOLVE SHIPPING USING LP MINIMIZING VCOST;


* 6. CLick File menu => RUN (F9) or Solve icon and examine solution report in .LST file
