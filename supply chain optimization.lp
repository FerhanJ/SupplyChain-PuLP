\* Supply Chain *\
Minimize
Total_cost_of_distribution: 50 DISTR_CUST_flow_('D1',_'C1',_'P1')
 + 50 DISTR_CUST_flow_('D1',_'C1',_'P2') + 200000 DISTR_Open_D1
 + 200 DISTR_stk_('D1',_'P1') + 200 DISTR_stk_('D1',_'P2')
 + 70 MFG_CUST_flow_('M1',_'C1',_'P1') + 70 MFG_CUST_flow_('M1',_'C1',_'P2')
 + 60 MFG_CUST_flow_('M2',_'C1',_'P1') + 60 MFG_CUST_flow_('M2',_'C1',_'P2')
 + 40 MFG_DISTR_flow_('M1',_'D1',_'P1') + 40 MFG_DISTR_flow_('M1',_'D1',_'P2')
 + 30 MFG_DISTR_flow_('M2',_'D1',_'P1') + 30 MFG_DISTR_flow_('M2',_'D1',_'P2')
 + 300000 MFG_Open_M1 + 350000 MFG_Open_M2 + 600 MFG_stk_('M1',_'P1')
 + 400 MFG_stk_('M1',_'P2') + 500 MFG_stk_('M2',_'P1')
 + 600 MFG_stk_('M2',_'P2')
Subject To
DISTR_D1_production_within_capacity: - 15000 DISTR_Open_D1
 + DISTR_stk_('D1',_'P1') + DISTR_stk_('D1',_'P2') <= 0
DISTR_D2_production_within_capacity: - 100 DISTR_Open_D2
 + DISTR_stk_('D2',_'P1') + DISTR_stk_('D2',_'P2') <= 0
Flow_of_P1_from_MFG_M1_to_CUST_constraint: MFG_CUST_flow_('M1',_'C1',_'P1')
 + MFG_DISTR_flow_('M1',_'D1',_'P1') + MFG_DISTR_flow_('M1',_'D2',_'P1')
 - MFG_stk_('M1',_'P1') = 0
Flow_of_P1_from_MFG_M2_to_CUST_constraint: MFG_CUST_flow_('M2',_'C1',_'P1')
 + MFG_DISTR_flow_('M2',_'D1',_'P1') + MFG_DISTR_flow_('M2',_'D2',_'P1')
 - MFG_stk_('M2',_'P1') = 0
Flow_of_P1_to_the_customer_must_meet_or_exceed_demand:
 DISTR_CUST_flow_('D1',_'C1',_'P1') + DISTR_CUST_flow_('D2',_'C1',_'P1')
 + MFG_CUST_flow_('M1',_'C1',_'P1') + MFG_CUST_flow_('M2',_'C1',_'P1')
 >= 15000
Flow_of_P2_from_MFG_M1_to_CUST_constraint: MFG_CUST_flow_('M1',_'C1',_'P2')
 + MFG_DISTR_flow_('M1',_'D1',_'P2') + MFG_DISTR_flow_('M1',_'D2',_'P2')
 - MFG_stk_('M1',_'P2') = 0
Flow_of_P2_from_MFG_M2_to_CUST_constraint: MFG_CUST_flow_('M2',_'C1',_'P2')
 + MFG_DISTR_flow_('M2',_'D1',_'P2') + MFG_DISTR_flow_('M2',_'D2',_'P2')
 - MFG_stk_('M2',_'P2') = 0
Flow_of_P2_to_the_customer_must_meet_or_exceed_demand:
 DISTR_CUST_flow_('D1',_'C1',_'P2') + DISTR_CUST_flow_('D2',_'C1',_'P2')
 + MFG_CUST_flow_('M1',_'C1',_'P2') + MFG_CUST_flow_('M2',_'C1',_'P2')
 >= 10000
MFG_M1_production_within_capacity: - 20000 MFG_Open_M1 + MFG_stk_('M1',_'P1')
 + MFG_stk_('M1',_'P2') <= 0
MFG_M2_production_within_capacity: - 20000 MFG_Open_M2 + MFG_stk_('M2',_'P1')
 + MFG_stk_('M2',_'P2') <= 0
Stock_of_P1_in_DISTR_D1_only_comes_from_MFGs: DISTR_stk_('D1',_'P1')
 - MFG_DISTR_flow_('M1',_'D1',_'P1') - MFG_DISTR_flow_('M2',_'D1',_'P1') = 0
Stock_of_P1_in_DISTR_D2_only_comes_from_MFGs: DISTR_stk_('D2',_'P1')
 - MFG_DISTR_flow_('M1',_'D2',_'P1') - MFG_DISTR_flow_('M2',_'D2',_'P1') = 0
Stock_of_P2_in_DISTR_D1_only_comes_from_MFGs: DISTR_stk_('D1',_'P2')
 - MFG_DISTR_flow_('M1',_'D1',_'P2') - MFG_DISTR_flow_('M2',_'D1',_'P2') = 0
Stock_of_P2_in_DISTR_D2_only_comes_from_MFGs: DISTR_stk_('D2',_'P2')
 - MFG_DISTR_flow_('M1',_'D2',_'P2') - MFG_DISTR_flow_('M2',_'D2',_'P2') = 0
_C1: DISTR_CUST_flow_('D1',_'C1',_'P1') - DISTR_stk_('D1',_'P1') = 0
_C2: DISTR_CUST_flow_('D1',_'C1',_'P2') - DISTR_stk_('D1',_'P2') = 0
_C3: DISTR_CUST_flow_('D2',_'C1',_'P1') - DISTR_stk_('D2',_'P1') = 0
_C4: DISTR_CUST_flow_('D2',_'C1',_'P2') - DISTR_stk_('D2',_'P2') = 0
Bounds
0 <= DISTR_CUST_flow_('D1',_'C1',_'P1')
0 <= DISTR_CUST_flow_('D1',_'C1',_'P2')
0 <= DISTR_CUST_flow_('D2',_'C1',_'P1')
0 <= DISTR_CUST_flow_('D2',_'C1',_'P2')
0 <= DISTR_stk_('D1',_'P1')
0 <= DISTR_stk_('D1',_'P2')
0 <= DISTR_stk_('D2',_'P1')
0 <= DISTR_stk_('D2',_'P2')
0 <= MFG_CUST_flow_('M1',_'C1',_'P1')
0 <= MFG_CUST_flow_('M1',_'C1',_'P2')
0 <= MFG_CUST_flow_('M2',_'C1',_'P1')
0 <= MFG_CUST_flow_('M2',_'C1',_'P2')
0 <= MFG_DISTR_flow_('M1',_'D1',_'P1')
0 <= MFG_DISTR_flow_('M1',_'D1',_'P2')
0 <= MFG_DISTR_flow_('M1',_'D2',_'P1')
0 <= MFG_DISTR_flow_('M1',_'D2',_'P2')
0 <= MFG_DISTR_flow_('M2',_'D1',_'P1')
0 <= MFG_DISTR_flow_('M2',_'D1',_'P2')
0 <= MFG_DISTR_flow_('M2',_'D2',_'P1')
0 <= MFG_DISTR_flow_('M2',_'D2',_'P2')
0 <= MFG_stk_('M1',_'P1')
0 <= MFG_stk_('M1',_'P2')
0 <= MFG_stk_('M2',_'P1')
0 <= MFG_stk_('M2',_'P2')
Generals
DISTR_CUST_flow_('D1',_'C1',_'P1')
DISTR_CUST_flow_('D1',_'C1',_'P2')
DISTR_CUST_flow_('D2',_'C1',_'P1')
DISTR_CUST_flow_('D2',_'C1',_'P2')
DISTR_stk_('D1',_'P1')
DISTR_stk_('D1',_'P2')
DISTR_stk_('D2',_'P1')
DISTR_stk_('D2',_'P2')
MFG_CUST_flow_('M1',_'C1',_'P1')
MFG_CUST_flow_('M1',_'C1',_'P2')
MFG_CUST_flow_('M2',_'C1',_'P1')
MFG_CUST_flow_('M2',_'C1',_'P2')
MFG_DISTR_flow_('M1',_'D1',_'P1')
MFG_DISTR_flow_('M1',_'D1',_'P2')
MFG_DISTR_flow_('M1',_'D2',_'P1')
MFG_DISTR_flow_('M1',_'D2',_'P2')
MFG_DISTR_flow_('M2',_'D1',_'P1')
MFG_DISTR_flow_('M2',_'D1',_'P2')
MFG_DISTR_flow_('M2',_'D2',_'P1')
MFG_DISTR_flow_('M2',_'D2',_'P2')
MFG_stk_('M1',_'P1')
MFG_stk_('M1',_'P2')
MFG_stk_('M2',_'P1')
MFG_stk_('M2',_'P2')
Binaries
DISTR_Open_D1
DISTR_Open_D2
MFG_Open_M1
MFG_Open_M2
End
