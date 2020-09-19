

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
8. Main_Simulation에서 **남은 시간이 0** 이거나 **위치가 땅밑으로 갈때** while문을 중단한다.

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

![Aero](https://user-images.githubusercontent.com/62292619/93179222-556fa780-f770-11ea-84f4-20a4b0caa9cb.jpg)
![Fi_total](https://user-images.githubusercontent.com/62292619/93179228-56a0d480-f770-11ea-9848-1509ff29aad6.jpg)
![position](https://user-images.githubusercontent.com/62292619/93179229-56a0d480-f770-11ea-8acc-ca2998e20aa3.jpg)
![Thrust_I-coor](https://user-images.githubusercontent.com/62292619/93179231-57396b00-f770-11ea-8bd8-124b36c19391.jpg)
![Thrust_L-coor](https://user-images.githubusercontent.com/62292619/93179234-57396b00-f770-11ea-90b7-030863a9b736.jpg)
![velocity](https://user-images.githubusercontent.com/62292619/93179235-57d20180-f770-11ea-99e4-d2b138cb4550.jpg)

















# 참고문헌

 > Michael Szmuk, Behcet Aclkmese, Andrew W. Berning Jr., “Successive 
Convexification for Fuel-Optimal Powered Landing With Aerodynamic Drag and 
Non-Convex Constraints,”American Institute of Aeronautics and Astronautics

