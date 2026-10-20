$ontext
Special-Event Park-and-Ride Planning Problem
CEE 6410/5410
David Rosenberg
October 10, 2026

This problem was contributed by Dr. Ran Sun and expanded by Dr. David Rosenberg

Learning objectives.
Students will be able to:
•   Define dimensions, decision variables and an objective function;
•   Formulate demand, capacity, and service-quality constraints;
•   Solve a small linear program;
•   Identify constraints;

Problem Statement
State Department of Transportation guidance for special events emphasizes advance planning for transportation demand, traffic, parking, transit operations, and seating.

Passengers must also be assigned in full bus-loads of 50 passengers per bus.

Additionally, the event planners must rent and bring in grandstands for the attendees. They have 2 potential venders. Each vender has an up-front reservation cost, number of seats per grandstand, and cost to load, ship, and setup a grandstand.

Vendor  Reservation cost ($)    Seats per grandstand    Cost to load, ship, and setup
($ per grandstand)
Purple Rain $1,000  100 200
Blue Sky    $1,500  200 300

David E Rosenberg
david.rosenberg@usu.edu
September 28, 2015
$offtext

* 1. DEFINE the SETS
SETS pl Parking Lots /north, south, west/
    vendor Vendors of grandstands /PurpleRain, BlueSky/;
* 2. DEFINE input data
PARAMETERS
   MaxPassengers(pl) maximimum number of people parking lot can handle (Number)
         /north 600,
          south 500,
          west  600/
   Cost(pl) cost per passenger from parking lot ($ per person)
          /north 4,
          south 5,
          west  7/
   TravelTime(pl) Travel time from parking lot (minutes)
         /north 20,
          south 12,
          west  8/
   MaxAverageTime Maximum average travel time for all pasengers (minutes) /13/
   Attendees number of attendees /1200/
   ReservationCost(vendor) Cost to reserve grandstands from vendor ($)
        /PurpleRain 1000,
         BlueSky    1500/
   Seats(vendor) Seats per grandstand (number)
        /PurpleRain 100,
         BlueSky    200/
    UnitCost(vendor) Cost per grandstand to load ship and setup ($ per grandstand)
        /PurpleRain 200,
         BlueSky    300/;



* 3. DEFINE the variables
*VARIABLES 

*BINARY VARIABLES ;
* Non-negativity constraints
*INTEGER VARIABLES
POSITIVE VARIABLES X;

* 4. COMBINE variables and data in equations
*EQUATIONS


* 5. DEFINE the MODEL from the EQUATIONS
MODEL PLANEVENT /ALL/;

* 6. Solve the Model as an LP (relaxed IP)
S

DISPLAY X.L, I.L, TCOST.L;

* Dump all input data and results to a GAMS gdx file
Execute_Unload "Ex6-3-integer.gdx";
* Dump the gdx file to an Excel workbook
Execute "gdx2xls Ex6-3-integer.gdx"
