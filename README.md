# 3Dof_model_modified
<br/><br/>
> code에서 Main_simulation, GCU, Simparameter 파일을 수정하였고 <br/>
> Compute_cvx_Euler , Compute_cvx_Euler_velocity_zero, Verify_infeasible함수가 추가되었음.

<br/><br/>


## 개요

GCU 에서 매 Step 마다 비행 시간을 계산하여 최적의 추력을 얻는 알고리즘을 추가하였음.


**Algorithm**


1. NED 좌표계에서의 초기 위치와 초기 속도를 얻는다.<br/><br/>
2. 최적의 비행 시간을 구하기 위해서  NED 기준 D축의 위치와 속도를 나눈 절대값을 초기값으로 둔다. <br/>  t_f = | altitude position/altitude velocity |<br/><br/>
4. 초기값 t_f 으로 Compute_cvx_Euler 함수와 Bisection method를 이용하여 최적의 비행시간을 구한다.<br/><br/>
5. 최적의 시간을 최종 시간으로 저장한후 Compute_cvx_Euler를 이용하여 얻은 추력을 Export 한다.<br/><br/>
6. 최종 위치에 근접 했을 때  속력을 줄이는 Compute_cvx_Euler_zero 로 변경하여 추력을 Export한다.
> Main_Simulation에서 **남은 시간이 0** 이거나 **비행체가 지면 아래에 위치 할 때** while문을 중단한다.

<br/><br/>


---
![Cvx](https://user-images.githubusercontent.com/62292619/95008746-9c5a0a00-0657-11eb-85f3-28e580db1140.png)
위 식을 CVX module을 이용하여 계산을 한 것이 아래의 Compute_cvx_Euler function이다.


## pseudo code
<br/>

**function** : Compute_cvx_Euler <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **input** :  Position,Velocity,Nstep<br/>
&nbsp;&nbsp;&nbsp; **output** : next step thrust value <br/>

**initialization** : Objective = []<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Constraint  = []
<br/><br/>
**begin function** <br/>
&nbsp;&nbsp;&nbsp;&nbsp; 1  &nbsp; Objective&nbsp;&nbsp; +=&nbsp;&nbsp; Fuel mass <br/>
&nbsp;&nbsp;&nbsp;&nbsp; 2  &nbsp; Constraint &nbsp;&nbsp;+= &nbsp;&nbsp;translation dynamics <br/>
&nbsp;&nbsp;&nbsp;&nbsp; 3  &nbsp; Constarint &nbsp;&nbsp;+= &nbsp;&nbsp;( lower bound on thrust magnitude < thrust < upper bound on thrust magnitude )  <br/>
&nbsp;&nbsp;&nbsp;&nbsp; 4  &nbsp; Constarint &nbsp;&nbsp;+= &nbsp;&nbsp; initial position,initial velocity, final position, final velocity <br/>
&nbsp;&nbsp;&nbsp;&nbsp; 5  &nbsp; Thrust &nbsp;&nbsp;= &nbsp;&nbsp;CVX(objective,constraint) <br/>
&nbsp;&nbsp;&nbsp;&nbsp; 6  &nbsp; **Return** Thrust. <br/>
**end function**<br/>

<br/>

  > 위 코드를 실행하기 위해서는 http://cvxr.com/cvx/ 에서 CVX module 설치가 필요함.<br/>
 > Compute_cvx_Euler_zero 는 본 함수에서 제한조건 final position만 제거함으로써 감속을 중요시함.

<br/>

---
 
 **function** : Verify_Infeasible <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; **input** :  Position,Velocity,Nstep<br/>
&nbsp;&nbsp;&nbsp; **output** : Result <br/><br/>
**begin function** <br/><br/>
&nbsp;&nbsp;&nbsp;&nbsp;Thrust = Compute_cvx_Euler(position,velocity,Nstep)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;**if**&nbsp; Compute_cvx_Euler is infeasible<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Result = 0<br/>
&nbsp;&nbsp;&nbsp;&nbsp;**elseif**&nbsp;Compute_cvx_Euler is feasible<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Reulst = Thrust<br/><br/>
**end function**<br/>


---

**Bisection method(at GCU)**<br/><br/>
&nbsp;&nbsp;&nbsp;&nbsp;**if**&nbsp;Altitude < 2m<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Thrust = Compute_cvx_Euler_Velocity_zero(position,velocity,Nstep) <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Final time = Final time - dt<br/>
&nbsp;&nbsp;&nbsp;&nbsp;**else**<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Upper bound (nstep) = z-axis position / z-axis velocity<br/>
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


## 결과

>모든 Parameter 는 참고문헌 [1]를 참고하였음. 


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

**Optimal final time:  14.3 sec**
<br/>
<br/>
<br/>

 ### image 
 
<img src="https://user-images.githubusercontent.com/62292619/93671068-fba60f00-fada-11ea-96ab-b9f1c94b8d98.jpg" width="80%">
<br/><br/><br/>
<img src="https://user-images.githubusercontent.com/62292619/93671073-fcd73c00-fada-11ea-890e-77fd21515d67.jpg" width="80%">
<br/><br/><br/>
<img src="https://user-images.githubusercontent.com/62292619/93707801-75d2a400-fb6c-11ea-82be-cbccf4e5abb3.jpg" width="80%">
<img src="https://user-images.githubusercontent.com/62292619/93707803-779c6780-fb6c-11ea-9af7-c47272683c59.jpg" width="80%">
<img src="https://user-images.githubusercontent.com/62292619/93671067-fa74e200-fada-11ea-97f7-7262322ad4c3.jpg" width="80%">
<br/>
<br/>
<br/>

<br/>
<br/>

###  Video

>화살표의 방향은 **추력의 방향**이고 화살표의 크기는 **추력의 크기**를 의미함.(NEU 좌표계)

![ezgif com-video-to-gif (1)](https://user-images.githubusercontent.com/62292619/93728114-76654c00-fbf9-11ea-9f92-e426827abf5c.gif)


<br/><br/>



# 참고문헌

 > Michael Szmuk, Behcet Aclkmese, Andrew W. Berning Jr., “Successive 
Convexification for Fuel-Optimal Powered Landing With Aerodynamic Drag and 
Non-Convex Constraints,”American Institute of Aeronautics and Astronautics


					

