\* Supply Chain *\
Minimize
Total_cost_of_distribution: 50 DISTR_CUST_flow_('C',_'C1',_'F1')
 + 50 DISTR_CUST_flow_('C',_'C1',_'F2') + 200000 DISTR_Open_C
 + 200 DISTR_stk_('C',_'F1') + 200 DISTR_stk_('C',_'F2')
 + 70 MFG_CUST_flow_('A',_'C1',_'F1') + 70 MFG_CUST_flow_('A',_'C1',_'F2')
 + 60 MFG_CUST_flow_('B',_'C1',_'F1') + 60 MFG_CUST_flow_('B',_'C1',_'F2')
 + 40 MFG_DISTR_flow_('A',_'C',_'F1') + 40 MFG_DISTR_flow_('A',_'C',_'F2')
 + 30 MFG_DISTR_flow_('B',_'C',_'F1') + 30 MFG_DISTR_flow_('B',_'C',_'F2')
 + 300000 MFG_Open_A + 350000 MFG_Open_B + 600 MFG_stk_('A',_'F1')
 + 400 MFG_stk_('A',_'F2') + 500 MFG_stk_('B',_'F1') + 600 MFG_stk_('B',_'F2')
Subject To
DISTR_C_production_within_capacity: - 15000 DISTR_Open_C
 + DISTR_stk_('C',_'F1') + DISTR_stk_('C',_'F2') <= 0
F1_production_must_meet_demand: DISTR_CUST_flow_('C',_'C1',_'F1')
 + MFG_CUST_flow_('A',_'C1',_'F1') + MFG_CUST_flow_('B',_'C1',_'F1') >= 15000
F2_production_must_meet_demand: DISTR_CUST_flow_('C',_'C1',_'F2')
 + MFG_CUST_flow_('A',_'C1',_'F2') + MFG_CUST_flow_('B',_'C1',_'F2') >= 10000
Flow_of_F1_from_MFG_A_to_CUST_constraint: MFG_CUST_flow_('A',_'C1',_'F1')
 + MFG_DISTR_flow_('A',_'C',_'F1') - MFG_stk_('A',_'F1') = 0
Flow_of_F1_from_MFG_B_to_CUST_constraint: MFG_CUST_flow_('B',_'C1',_'F1')
 + MFG_DISTR_flow_('B',_'C',_'F1') - MFG_stk_('B',_'F1') = 0
Flow_of_F2_from_MFG_A_to_CUST_constraint: MFG_CUST_flow_('A',_'C1',_'F2')
 + MFG_DISTR_flow_('A',_'C',_'F2') - MFG_stk_('A',_'F2') = 0
Flow_of_F2_from_MFG_B_to_CUST_constraint: MFG_CUST_flow_('B',_'C1',_'F2')
 + MFG_DISTR_flow_('B',_'C',_'F2') - MFG_stk_('B',_'F2') = 0
MFG_A_production_within_capacity: - 20000 MFG_Open_A + MFG_stk_('A',_'F1')
 + MFG_stk_('A',_'F2') <= 0
MFG_B_production_within_capacity: - 20000 MFG_Open_B + MFG_stk_('B',_'F1')
 + MFG_stk_('B',_'F2') <= 0
Stock_of_F1_in_DISTR_C_only_comes_from_MFGs: DISTR_stk_('C',_'F1')
 - MFG_DISTR_flow_('A',_'C',_'F1') - MFG_DISTR_flow_('B',_'C',_'F1') = 0
Stock_of_F2_in_DISTR_C_only_comes_from_MFGs: DISTR_stk_('C',_'F2')
 - MFG_DISTR_flow_('A',_'C',_'F2') - MFG_DISTR_flow_('B',_'C',_'F2') = 0
_C1: DISTR_CUST_flow_('C',_'C1',_'F1') - DISTR_stk_('C',_'F1') = 0
_C2: DISTR_CUST_flow_('C',_'C1',_'F2') - DISTR_stk_('C',_'F2') = 0
Bounds
0 <= DISTR_CUST_flow_('C',_'C1',_'F1')
0 <= DISTR_CUST_flow_('C',_'C1',_'F2')
0 <= DISTR_stk_('C',_'F1')
0 <= DISTR_stk_('C',_'F2')
0 <= MFG_CUST_flow_('A',_'C1',_'F1')
0 <= MFG_CUST_flow_('A',_'C1',_'F2')
0 <= MFG_CUST_flow_('B',_'C1',_'F1')
0 <= MFG_CUST_flow_('B',_'C1',_'F2')
0 <= MFG_DISTR_flow_('A',_'C',_'F1')
0 <= MFG_DISTR_flow_('A',_'C',_'F2')
0 <= MFG_DISTR_flow_('B',_'C',_'F1')
0 <= MFG_DISTR_flow_('B',_'C',_'F2')
0 <= MFG_stk_('A',_'F1')
0 <= MFG_stk_('A',_'F2')
0 <= MFG_stk_('B',_'F1')
0 <= MFG_stk_('B',_'F2')
Generals
DISTR_CUST_flow_('C',_'C1',_'F1')
DISTR_CUST_flow_('C',_'C1',_'F2')
DISTR_stk_('C',_'F1')
DISTR_stk_('C',_'F2')
MFG_CUST_flow_('A',_'C1',_'F1')
MFG_CUST_flow_('A',_'C1',_'F2')
MFG_CUST_flow_('B',_'C1',_'F1')
MFG_CUST_flow_('B',_'C1',_'F2')
MFG_DISTR_flow_('A',_'C',_'F1')
MFG_DISTR_flow_('A',_'C',_'F2')
MFG_DISTR_flow_('B',_'C',_'F1')
MFG_DISTR_flow_('B',_'C',_'F2')
MFG_stk_('A',_'F1')
MFG_stk_('A',_'F2')
MFG_stk_('B',_'F1')
MFG_stk_('B',_'F2')
Binaries
DISTR_Open_C
MFG_Open_A
MFG_Open_B
End
