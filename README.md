# 3Dof_model_modified
<br/><br/>
> code에서 Main_simulation, GCU, Simparameter 파일을 수정하였고 <br/>
> Compute_cvx_Euler , Compute_cvx_Euler_velocity_zero, Find_timestep, Verify_infeasible함수가 추가되었음.

<br/><br/>


## 개요


GCU 에서 매 Step 마다 비행 시간을 계산하여 최적의 추력을 얻는 알고리즘을 추가하였음.


**Algorithm**


1.  NED 좌표계에서의 초기 위치와 초기 속도를 얻는다.<br/><br/>
2. 최적의 비행 시간을 정하기 위해서  NED 기준 D축의 초기위치 ([0 500 -500])와 초기속도([50 0 50])를 나눈 절대값을 초기값으로 둔다. <br/>  t_f = | position/velocity |<br/><br/>
4. 초기값 t_f 으로 Compute_cvx_Euler 함수와 Bisection을 이용하여 최적의 비행시간을 구한다.<br/><br/>
5. 최적의 시간을 최종 시간으로 저장한후 Compute_cvx_Euler를 이용하여 얻은 추력을 Export 한다.<br/><br/>
6. 최종 위치에 근접 했을 때  속력을 줄이는 cvx함수로 변경한다.
> Main_Simulation에서 **남은 시간이 0** 이거나 **비행체가 지면 아래에 위치 할 때** while문을 중단한다.


<br/><br/>

 ---
 
**function** : Compute_cvx_Euler
 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**input** :  Position,Velocity,Nstep

&nbsp;&nbsp;&nbsp;**output** : next step thrust value 

**initialization**

Objective = []

Constraint  = []


&nbsp;&nbsp;1.  &nbsp;Objective&nbsp;&nbsp; +=&nbsp;&nbsp; Fuel mass
&nbsp;&nbsp;2.  &nbsp;Constarint &nbsp;&nbsp;+= &nbsp;&nbsp; initial position,initial velocity, final position, final velocity
&nbsp;&nbsp;3.  &nbsp;Constarint &nbsp;&nbsp;+= &nbsp;&nbsp;( lower bound on thrust magnitude < thrust < upper bound on thrust magnitude ) 
&nbsp;&nbsp;4.  &nbsp;Constraint &nbsp;&nbsp;+= &nbsp;&nbsp;translation dynamics
&nbsp;&nbsp;5.  &nbsp;Thrust &nbsp;&nbsp;= &nbsp;&nbsp;CVX(objective,constraint)
&nbsp;&nbsp;6.  &nbsp;**Return** Thrust.

  > 위 코드를 실행하기 위해서는 http://cvxr.com/cvx/ 에서 CVX module 설치가 필요함.
 ---

 
 <br/><br/>
 

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

