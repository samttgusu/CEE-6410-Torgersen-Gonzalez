$ontext
Homework 5
CEE 6410/5410
October 15, 2026
Pure Scalar Version - No sets, indices, or array mappings.

Problem 1, Chapter 7, Bishop et al.
A farmer plans to develop water for irrigation. He is considering two possible sources of
water: a gravity diversion from a possible reservoir with two alternative capacities and/or a
pump from a lower river diversion (refer to Figure 7.3). Between the reservoir and pump
site the river base flow increases by 2 acft/day due to groundwater drainage into the river.
Ignore losses from the reservoir. The river flow into the reservoir and the farmer's demand
during each of two six-month seasons of the year are given in Table 7.5. Revenue is estimated at $300 per year per acre irrigated.


Samuel T. Torgersen-Gonzalez
s.torgersen-gonzalez@usu.edu
October 15, 2026
$offtext

* 1. DEFINE ALL SCALAR VARIABLES
VARIABLES
   v_profit           Total annual net profit ($);

POSITIVE VARIABLES
   v_acres            Acres irrigated (continuous)
   v_storage1         Storage in reservoir at end of Season 1 (acft)
   v_storage2         Storage in reservoir at end of Season 2 (acft)
   v_release1         Gravity release to farm in Season 1 (acft)
   v_release2         Gravity release to farm in Season 2 (acft)
   v_spill1           Spill from reservoir downstream in Season 1 (acft)
   v_spill2           Spill from reservoir downstream in Season 2 (acft)
   v_pumped1          Water pumped from river to farm in Season 1 (acft)
   v_pumped2          Water pumped from river to farm in Season 2 (acft);

BINARY VARIABLES
   v_build_high       1 if high dam (700 acft) is built else 0
   v_build_low        1 if low dam (300 acft) is built else 0
   v_build_pump       1 if pump station is built else 0;

* 2. DECLARE EQUATIONS
EQUATIONS
   EQ_OBJ             "Objective function to maximize net profit"
   EQ_DAM_MUTEX       "Ensure only one dam size can be selected"
   EQ_WATER_BAL_1     "Reservoir mass balance for Season 1"
   EQ_WATER_BAL_2     "Reservoir mass balance for Season 2"
   EQ_CAP_STORAGE_1   "Reservoir storage capacity limit for Season 1"
   EQ_CAP_STORAGE_2   "Reservoir storage capacity limit for Season 2"
   EQ_CAP_PUMP_1      "Pump capacity limit for Season 1 (2.2 acft/day * 182.5 days)"
   EQ_CAP_PUMP_2      "Pump capacity limit for Season 2 (2.2 acft/day * 182.5 days)"
   EQ_PUMP_AVAIL_1    "Water available to pump in Season 1 (Spill + 2.0 acft/day * 182.5 days)"
   EQ_PUMP_AVAIL_2    "Water available to pump in Season 2 (Spill + 2.0 acft/day * 182.5 days)"
   EQ_DEMAND_BAL_1    "Meet irrigation demand for Season 1 (1.0 acft/acre)"
   EQ_DEMAND_BAL_2    "Meet irrigation demand for Season 2 (3.0 acft/acre)";

* 3. EQUATION DEFINITIONS
* Objective: 300*Acres - Capital Costs - 20*Pumping
EQ_OBJ.. 
   v_profit =E= (300 * v_acres) 
                - (10000 * v_build_high + 6000 * v_build_low) 
                - (8000 * v_build_pump) 
                - (20 * v_pumped1)
                - (20 * v_pumped2);

* Dam Selection (High, Low, or None)
EQ_DAM_MUTEX.. 
   v_build_high + v_build_low =L= 1;

* Reservoir Balances (Inflow S1 = 600, S2 = 200)
EQ_WATER_BAL_1.. 
   v_storage1 =E= v_storage2 + 600 - v_release1 - v_spill1;

EQ_WATER_BAL_2.. 
   v_storage2 =E= v_storage1 + 200 - v_release2 - v_spill2;

* Storage Capacity Limits
EQ_CAP_STORAGE_1.. 
   v_storage1 =L= 700 * v_build_high + 300 * v_build_low;

EQ_CAP_STORAGE_2.. 
   v_storage2 =L= 700 * v_build_high + 300 * v_build_low;

* Pump Mechanical Limits: 2.2 acft/day * 182.5 days = 401.5 acft
EQ_CAP_PUMP_1.. 
   v_pumped1 =L= 401.5 * v_build_pump;

EQ_CAP_PUMP_2.. 
   v_pumped2 =L= 401.5 * v_build_pump;

* Pump Water Supply Limits: Spill + (2.0 acft/day * 182.5 days = 365 acft)
EQ_PUMP_AVAIL_1.. 
   v_pumped1 =L= v_spill1 + 365.0;

EQ_PUMP_AVAIL_2.. 
   v_pumped2 =L= v_spill2 + 365.0;

* Demand Balance Constraints (Pure scalar multiplication)
EQ_DEMAND_BAL_1.. 
   v_release1 + v_pumped1 =E= 1.0 * v_acres;

EQ_DEMAND_BAL_2.. 
   v_release2 + v_pumped2 =E= 3.0 * v_acres;

* 4. DEFINE AND SOLVE THE MODEL
MODEL RESERVOIR /ALL/;

SOLVE RESERVOIR MAXIMIZING v_profit USING MIP;

* 5. LOG THE FINAL RESULTS
DISPLAY v_profit.L, v_acres.L, v_build_high.L, v_build_low.L, v_build_pump.L, v_storage1.L, v_storage2.L, v_release1.L, v_release2.L, v_pumped1.L, v_pumped2.L, v_spill1.L, v_spill2.L;

* Dump all input data and results to a GAMS gdx file
Execute_Unload "HW5.gdx";
* Dump the gdx file to an Excel workbook
Execute "gdx2xls HW5.gdx"