

# 3Dof_model_modified


## 개요


GCU 에서 매 Step 마다 최종 시간을 계산하여 최적의 추력을 얻는 알고리즘을 추가하였음.


**Algorithm**


1.  NED 좌표계에서의 초기 위치와 초기 속도를 구한다.<br/><br/>
2. 최종시간을 정하기 위해서  NED 기준 D축의 위치와 속도를 나눈 절대값을 초기값으로 둔다. t_f = position/velocity<br/><br/>
3. t_f 으로 미리 짜놓은 cvx 함수를 실행한다.<br/><br/>
4. 만약 결과값이 Infeasible하다면 <br/><br/>
5. Bisection을 이용하여 최적의 최종시간을 구한다.<br/><br/>
6. 최적의 시간을 최종 시간으로 저장한다.<br/><br/>
7. 최적의 시간에 대해 추력을 Export한다.<br/><br/>
8. Main_Simulation에서 **남은 시간이 0** 이거나 **위치가 땅밑에 도달할 때** while문을 중단한다.

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

**Optimal final time:  14.4 sec**
<br/>
<br/>
<br/>

 ### image 
 
<img src="https://user-images.githubusercontent.com/62292619/93671068-fba60f00-fada-11ea-96ab-b9f1c94b8d98.jpg" width="80%">
<br/><br/><br/>
<img src="https://user-images.githubusercontent.com/62292619/93671073-fcd73c00-fada-11ea-890e-77fd21515d67.jpg" width="80%">
<br/><br/><br/>
<img src="https://user-images.githubusercontent.com/62292619/93671072-fc3ea580-fada-11ea-98de-a77c90c8e45b.jpg" width="80%"><img src="https://user-images.githubusercontent.com/62292619/93671071-fc3ea580-fada-11ea-9c01-c8552938896d.jpg" width="80%"><img src="https://user-images.githubusercontent.com/62292619/93671067-fa74e200-fada-11ea-97f7-7262322ad4c3.jpg" width="80%">
<br/>
<br/>
<br/>

###  Video

>화살표의 방향은 **추력의 방향**이고 화살표의 크기는 **추력의 크기**를 의미함.

![ezgif com-video-to-gif](https://user-images.githubusercontent.com/62292619/93695147-85db8b00-fb4e-11ea-83a1-f1d1f49578d7.gif)


# 참고문헌

 > Michael Szmuk, Behcet Aclkmese, Andrew W. Berning Jr., “Successive 
Convexification for Fuel-Optimal Powered Landing With Aerodynamic Drag and 
Non-Convex Constraints,”American Institute of Aeronautics and Astronautics

