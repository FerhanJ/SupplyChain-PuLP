import pulp
import itertools as it
# Prefixes: D - lp decision variable, K - list of dictionary keys
''' Initialise problem data'''
PROD = ['F1', 'F2']  # products provided
MFG = ['A', 'B']  # manufacturing centers
DISTR = ['C']  # distribution centers
CUST = ['C1']  # customers
# Product demand
# {prod: customer demand of prod in singles}
demand = {'F1': 15000,
          'F2': 10000}
# Storage capacities
# {x: capacity of node x in singles}
MFG_Capacity = {'A': 20000,
                'B': 20000}
DISTR_Capacity = {'C': 15000}
# Fixed costs
# {x: cost of node x if open}
MFG_FixedCost = {'A': 300000,
                 'B': 350000}
DISTR_FixedCost = {'C': 200000}
# Variable costs
# {(x, prod): $ cost per single to store prod in x}
MFG_VarCost = {('A', 'F1'): 600,
               ('B', 'F1'): 500,
               ('A', 'F2'): 400,
               ('B', 'F2'): 600}
DISTR_VarCost = {('C', 'F1'): 200,
                 ('C', 'F2'): 200}
# Distribution costs in dollars
# {(mfg, distr, prod): $ cost to transport prod from mfg to distr}
CST_MFG_DISTR = {('A', 'C', 'F1'): 40,
             ('A', 'C', 'F2'): 40,
             ('B', 'C', 'F1'): 30,
             ('B', 'C', 'F2'): 30}
# {(mfg, cust, prod): $ cost to transport prod from mfg to cust}
CST_MFG_CUST = {('A', 'C1', 'F1'): 70,
            ('A', 'C1', 'F2'): 70,
            ('B', 'C1', 'F2'): 60,
            ('B', 'C1', 'F1'): 60}
# {(distr, cust, prod): $ cost to transport prod from distr to cust}
CST_DISTR_CUST = {('C', 'C1', 'F1'): 50,
              ('C', 'C1', 'F2'): 50}

''' Initialise optimization problem and variables '''
prob = pulp.LpProblem("Supply Chain", sense=1)
# Boolean: 1 if MFG is open, 0 if closed
D_MFG_Open = pulp.LpVariable.dict('MFG_Open', MFG, lowBound=0, upBound=1, cat='Integer')
D_DISTR_Open = pulp.LpVariable.dict('DISTR_Open', DISTR, lowBound=0, upBound=1, cat='Integer')
# stock variables
D_MFG_Stk = pulp.LpVariable.dicts("MFG_stk", ((mfg, prod) for mfg, prod in it.product(MFG, PROD)), lowBound=0,
                                  upBound=None, cat='Integer')
D_DISTR_Stk = pulp.LpVariable.dicts("DISTR_stk", ((i, j) for i, j in it.product(DISTR, PROD)), lowBound=0, upBound=None,
                                    cat='Integer')
# flow variables
D_MFG_DISTR_flow = pulp.LpVariable.dicts("MFG_DISTR_flow", ((i, j, k) for i, j, k in it.product(MFG, DISTR, PROD)),
                                         lowBound=0, upBound=None, cat='Integer')
D_DISTR_CUST_flow = pulp.LpVariable.dicts("DISTR_CUST_flow", ((i, j, k) for i, j, k in it.product(DISTR, CUST, PROD)),
                                          lowBound=0, upBound=None, cat='Integer')
D_MFG_CUST_flow = pulp.LpVariable.dicts("MFG_CUST_flow", ((i, j, k) for i, j, k in it.product(MFG, CUST, PROD)),
                                        lowBound=0, upBound=None, cat='Integer')
# Objective function
fixed_cost = pulp.lpSum([MFG_FixedCost[mfg] * D_MFG_Open[mfg] for mfg in MFG]) \
             + pulp.lpSum([DISTR_FixedCost[distr] * D_DISTR_Open[distr] for distr in DISTR])

var_cost = pulp.lpSum([MFG_VarCost[mfg, prod] * D_MFG_Stk[mfg, prod] for mfg, prod in it.product(MFG, PROD)]) + \
           pulp.lpSum([DISTR_VarCost[distr, prod] * D_DISTR_Stk[distr, prod] for distr, prod in it.product(DISTR, PROD)])

transport_cost = pulp.lpSum(CST_MFG_DISTR[mfg, distr, prod] * D_MFG_DISTR_flow[mfg, distr, prod]
                            for mfg, distr, prod in CST_MFG_DISTR) \
                 + pulp.lpSum(CST_MFG_CUST[mfg, cust, prod] * D_MFG_CUST_flow[mfg, cust, prod]
                              for mfg, cust, prod in CST_MFG_CUST) \
                 + pulp.lpSum(CST_DISTR_CUST[distr, cust, prod] * D_DISTR_CUST_flow[distr, cust, prod]
                              for distr, cust, prod in CST_DISTR_CUST)
prob += fixed_cost + var_cost + transport_cost, "Total cost of distribution"
# Constraints
# Make sure MFG stock is within capacity
for mfg in MFG:
    prob += pulp.lpSum([D_MFG_Stk[mfg, j] for j in PROD]) <= MFG_Capacity[mfg] * D_MFG_Open[mfg], \
            "MFG {0} production within capacity".format(mfg)
# Make sure DISTR stock is within capacity
for distr in DISTR:
    prob += pulp.lpSum([D_DISTR_Stk[distr, j] for j in PROD]) <= DISTR_Capacity[distr] * D_DISTR_Open[distr], \
            "DISTR {0} production within capacity".format(distr)
# Make sure stock in DISTR can only come from MFGs
for (distr, prod) in it.product(DISTR, PROD):
    prob += D_DISTR_Stk[distr, prod] == pulp.lpSum([D_MFG_DISTR_flow[mfg, distr, prod] for mfg in MFG]), \
            "Stock of {0} in DISTR {1} only comes from MFGs".format(prod, distr)
# Flow from MFG to CUST = MFG stock - flow from MFG to DISTR
for (mfg, prod) in it.product(MFG, PROD):
    prob += D_MFG_CUST_flow[mfg, 'C1', prod] == D_MFG_Stk[mfg, prod] - pulp.lpSum([D_MFG_DISTR_flow[mfg, distr, prod]
                                                                                   for distr in DISTR]), \
            "Flow of {0} from MFG {1} to CUST constraint".format(prod, mfg)
# PROD production must meet demand
for prod in PROD:
    prob += D_MFG_CUST_flow['A', 'C1', prod] + D_MFG_CUST_flow['B', 'C1', prod] \
            + D_DISTR_CUST_flow['C', 'C1', prod] >= demand[prod], \
            "{0} production must meet demand".format(prod)
# flow from DISTR contraints
for prod in PROD:
    prob += D_DISTR_CUST_flow['C', 'C1', prod] == D_DISTR_Stk['C', prod]
# Write out problem
prob.writeLP("supply chain optimization.lp")

'''Output results'''
prob.solve()
for v in D_MFG_Open:
    print(v, "=", D_MFG_Open[v].varValue)
for v in D_DISTR_Open:
    print(v, "=", D_DISTR_Open[v].varValue)
for v in D_MFG_Stk:
    print("MFG {0} produced {1} singles of {2}".format(v[0], D_MFG_Stk[v].varValue, v[1]))
for v in D_MFG_DISTR_flow:
    print("MFG {0} transported {1} singles of {2} to DISTR {3}".format(v[0], D_MFG_DISTR_flow[v].varValue, v[2], v[1]))
for v in D_DISTR_Stk:
    print("DISTR {0} received {1} singles of {2}".format(v[0], D_DISTR_Stk[v].varValue, v[1]))
# display final costs
print("Transport Cost : $", pulp.value(transport_cost))
print("Fixed Cost : $", pulp.value(fixed_cost))
print("Variable Cost : $", pulp.value(var_cost))
print("Total Cost :", "$", pulp.value(prob.objective))
