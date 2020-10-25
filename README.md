
# 3Dof_model_modified

> Original code에서 Main_simulation, GCU, Simparameter 파일을 수정하였고 <br/>
> Compute_cvx_Euler , Compute_cvx_Euler_velocity_zero, Verify_infeasible함수가 추가되었음.
> 



# 1. 개요

GCU 에서 매 Step 마다 비행 시간을 계산하여 최적의 추력을 얻는 알고리즘을 추가하였음.


**Algorithm**


1. NED 좌표계에서의 초기 위치와 초기 속도를 얻는다.<br/>
2. 최적의 비행 시간을 구하기 위해서  NED 기준 D축의 위치와 속도를 나눈 절대값을 final time으로 둔다. <br/> 
4. final time으로  Compute_cvx_Euler 함수와 Bisection method를 이용하여 최적의 비행시간을 구한다.<br/>
5. 최적의 시간을 최종 시간으로 저장한후 Compute_cvx_Euler를 이용하여 얻은 추력을 Export 한다.<br/>
6. 최종 위치에 근접 했을 때  속력을 줄이기 위해서 Compute_cvx_Euler_zero를 이용하여 얻은 추력을 Export한다.
> Main_Simulation에서 **남은 시간이 0** 이거나 **비행체가 지면 아래에 위치 할 때** while문을 중단한다.



---
**Problem. 1**   
<br/>
<img src="https://user-images.githubusercontent.com/62292619/97086955-84c3df00-1661-11eb-8223-200be72ac2bf.jpg">
위 식을 Convexification을 하여  계산을 한 것이 아래의 Compute_cvx_Euler function이다.


# 2. Pseudo code

**function** : Compute_cvx_Euler <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **input** :  Position,Velocity,Nstep<br/>
&nbsp;&nbsp;&nbsp; **output** : next step thrust value <br/>

**initialization** : Objective = []<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Constraint  = []
<br/><br/>
**begin function** <br/>
&nbsp;&nbsp;&nbsp;&nbsp;   &nbsp; Objective&nbsp;&nbsp; +=&nbsp;&nbsp; Fuel mass <br/>
&nbsp;&nbsp;&nbsp;&nbsp;   &nbsp; Constraint &nbsp;&nbsp;+= &nbsp;&nbsp;translation dynamics <br/>
&nbsp;&nbsp;&nbsp;&nbsp;   &nbsp; Constarint &nbsp;&nbsp;+= &nbsp;&nbsp;( lower bound on thrust magnitude < thrust < upper bound on thrust magnitude )  <br/>
&nbsp;&nbsp;&nbsp;&nbsp;   &nbsp; Constarint &nbsp;&nbsp;+= &nbsp;&nbsp; initial position,initial velocity, final position, final velocity <br/>
&nbsp;&nbsp;&nbsp;&nbsp;   &nbsp; **if** CVX(objective,constraint) is **Solved**<br/>
&nbsp;&nbsp;&nbsp;&nbsp;   &nbsp;  &nbsp;&nbsp; &nbsp;&nbsp;Thrust &nbsp;&nbsp;= &nbsp;&nbsp;CVX(objective,constraint) <br/>
&nbsp;&nbsp;&nbsp;&nbsp;   &nbsp; **else** <br/>
&nbsp;&nbsp;&nbsp;&nbsp;   &nbsp;  &nbsp;&nbsp; &nbsp;&nbsp;Thrust &nbsp;&nbsp;= &nbsp;&nbsp;0 <br/>
&nbsp;&nbsp;&nbsp;&nbsp;   &nbsp; **Return** Thrust. <br/>
**end function**<br/>

<br/>

  > 위 코드를 실행하기 위해서는 http://cvxr.com/cvx/ 에서 CVX module 설치가 필요함.<br/>
 > Compute_cvx_Euler_zero 는 본 함수에서 제한조건에서 최종위치를 제거.



---

**Bisection method(at GCU)**<br/><br/>
&nbsp;&nbsp;&nbsp;&nbsp;**if**&nbsp;Altitude < 2m<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Thrust = Compute_cvx_Euler_Velocity_zero(position,velocity,Nstep) <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Final time = Final time - dt<br/>
&nbsp;&nbsp;&nbsp;&nbsp;**else**<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Upper bound (nstep) = (z-axis position / z-axis velocity) / dt<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Lower bound (nstep) = 0<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Epsilon = 1 &nbsp;&nbsp;(stopping criterion)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**if** Compute cvx_Euler(position,velocity,Upper bound) is infeasible<br/><br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**while** True **do**<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lower bound = Upper bound<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Upper bound = Upper bound +Upper bound<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**if** Compute cvx_Euler(position,velocity,Upper bound)  is feasible<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**break**<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**end if**<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**end while**<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**end if**<br/><br/>
&nbsp;&nbsp;&nbsp;&nbsp;**while** Upper bound - Lower bound > Epsilon **do**<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Temp_N = 0.5 * (Upper bound + Lower bound)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**if** Compute_cvx_Euler(position,velocity,Temp_N) is  infeasible<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Lower bound = Temp_N<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**elseif** Compute_cvx_Euler(position,velocity,Temp_N) is  feasible<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Upper bound = Temp_N<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**end if**<br/>
&nbsp;&nbsp;&nbsp;&nbsp;**end while**<br/>
&nbsp;&nbsp;&nbsp;&nbsp;**end if**<br/>







---


# 3. 결과

>Simulation1의 Parameter 는 참고문헌 [1]를 참고하였음. 

**Simulation 1**
--

**Table. 1 Parameters**
|<center>Parameter|Value|<center>Units|-
|:------|---|:---:|---
|Initial position| [0&nbsp;&nbsp;500&nbsp;&nbsp;-500] |[m]|NED
|Initial velocity|[50&nbsp;&nbsp;0&nbsp;&nbsp;50]|[m/s]|NED
|Initial mass|15000| [kg]   |
|Vehicle dry mass|10000|[kg]|
|Fuel mass|5000|[kg]  |
|Final position| [0&nbsp;&nbsp;0&nbsp;&nbsp;0]|[m]|NED
|Final velocity| [0&nbsp;&nbsp;0&nbsp;&nbsp;0]|[m/s]|NED
|Maximum Thrust|250,000 |[N]|
|Minimum Thrust|100,000|[N]|
|dt| 0.1|[s]|

<br/>

Optimal final time:  14.3 sec<br/>
Computation time:  52 min

<br/>

 ### Simulation result
 
 | <img src="https://user-images.githubusercontent.com/62292619/97099363-685c8c80-16cb-11eb-950d-6c7327491415.jpg"> | 
|:--:| 
| **Fig. 1.1 Position** |

 | <img src="https://user-images.githubusercontent.com/62292619/97099362-67c3f600-16cb-11eb-9077-617ae98d038e.jpg"> | 
|:--:| 
| **Fig. 1.2 Velocity** |

 | <img src="https://user-images.githubusercontent.com/62292619/97099360-672b5f80-16cb-11eb-9f00-ce9b24084837.jpg"> | 
|:--:| 
| **Fig. 1.3 Thrust** |



| <img src="https://user-images.githubusercontent.com/62292619/97099361-67c3f600-16cb-11eb-83e9-5159c28f0b4d.jpg"> | 
|:--:| 
|  **Fig. 1.4 Thrust norm**|


<br/>

**Simulation 2**
--


**Table. 2 Parameters**
|<center>Parameter|Value|<center>Units|-
|:------|---|:---:|---
|Initial position| [500&nbsp;&nbsp;100&nbsp;&nbsp;-700] |[m]|NED
|Initial velocity|[50&nbsp;&nbsp;-50&nbsp;&nbsp;50]|[m/s]|NED
|Initial mass|15000| [kg]   |
|Vehicle dry mass|10000|[kg]|
|Fuel mass|5000|[kg]  |
|Final position| [0&nbsp;&nbsp;0&nbsp;&nbsp;0]|[m]|NED
|Final velocity| [0&nbsp;&nbsp;0&nbsp;&nbsp;0]|[m/s]|NED
|Maximum Thrust|250,000 |[N]|
|Minimum Thrust|100,000|[N]|
|dt| 0.1|[s]|



>Simulation 1에서 초기위치,초기속도를 변경

Optimal final time:  17.2 sec<br/>
Computation time:  74 min<br/>

<br/><br/>
### Simulation result

 | <img src="https://user-images.githubusercontent.com/62292619/97100725-cd1ee380-16d9-11eb-89e1-281f40cb19dc.jpg"> | 
|:--:| 
| **Fig. 2.1 Position** |

 | <img src="https://user-images.githubusercontent.com/62292619/97099362-67c3f600-16cb-11eb-9077-617ae98d038e.jpg"> | 
|:--:| 
| **fig. 2.2 Velocity** |

 | <img src="https://user-images.githubusercontent.com/62292619/97100726-cd1ee380-16d9-11eb-83e0-a343ae7a4ed6.jpg"> | 
|:--:| 
| **Fig. 2.3 Thrust** |



| <img src="https://user-images.githubusercontent.com/62292619/97100723-cb552000-16d9-11eb-8d45-022a55a89d95.jpg"> | 
|:--:| 
|  **Fig. 2.4 Thrust norm**|

---

주어진 Convex problem 을 계산하기 위해, NED 좌표계에서 Table1와 Table2를 활용하여 컴퓨터 시뮬레이션을 수행하였다. Fig 1.4와 Fig 2.4는 제한조건에서의 추력제한을 만족하는 것을 보여주며,  Fig 1.1과 Fig 2.1는 최종위치까지 도달하는 것을 확인할 수 있다.


## 4. 참고문헌

 > Michael Szmuk, Behcet Aclkmese, Andrew W. Berning Jr., “Successive 
Convexification for Fuel-Optimal Powered Landing With Aerodynamic Drag and 
Non-Convex Constraints,”American Institute of Aeronautics and Astronautics


	
