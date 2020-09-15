

# 3Dof_model

GCU 에서 매 시간마다 최종 시간을 계산하는 알고리즘을 추가하였음.


**알고리즘**
1. 최종시간을 정하기 위해서 우선 NED 기준 D축의 위치와 속도를 나눈 절대값을 초기값으로 둔다. t_f = position/velocity
2. t_f 으로 미리 짜놓은 cvx 함수를 실행한다.
3. 만약 Infeasible하다면 시간을 늘리고 feasible하면 시간을 줄인다.

# 결과
**parameter**

NED기준(Landing Coordinate System)  

Initial position = ex1  

Initial velocity = (50,0,50)  

Initial mass = 15000  

Final position = (0,0,0)  

Final velocity = (0,0,0)  

Maximum Thrust = 2.5e + 5  

Minimum Thrust = 1e+5  

dt = 0.1 

## Ex1) Image(r=[0 , 500, -500])

원래 문제 : 15초 optimal value
Simulation result : 14.4

![Aero](https://user-images.githubusercontent.com/62292619/93179222-556fa780-f770-11ea-84f4-20a4b0caa9cb.jpg)
![Fi_total](https://user-images.githubusercontent.com/62292619/93179228-56a0d480-f770-11ea-9848-1509ff29aad6.jpg)
![position](https://user-images.githubusercontent.com/62292619/93179229-56a0d480-f770-11ea-8acc-ca2998e20aa3.jpg)
![Thrust_I-coor](https://user-images.githubusercontent.com/62292619/93179231-57396b00-f770-11ea-8bd8-124b36c19391.jpg)
![Thrust_L-coor](https://user-images.githubusercontent.com/62292619/93179234-57396b00-f770-11ea-90b7-030863a9b736.jpg)
![velocity](https://user-images.githubusercontent.com/62292619/93179235-57d20180-f770-11ea-99e4-d2b138cb4550.jpg)


## Ex2) Image( r = [ 0 , 500 , -1000])  

Simulation result : 17.6

![3Dof_pos](https://user-images.githubusercontent.com/62292619/93167911-9f4e9280-f75c-11ea-9114-af406c1cbfb5.jpg)
![3dof_vel](https://user-images.githubusercontent.com/62292619/93168027-ea68a580-f75c-11ea-936f-9db60dc6458d.jpg)
![Aerodynamics](https://user-images.githubusercontent.com/62292619/93168032-eccaff80-f75c-11ea-9460-29dc619a19ab.jpg)
![Fi_total](https://user-images.githubusercontent.com/62292619/93168038-edfc2c80-f75c-11ea-9df1-c1357ba17a3d.jpg)
![Thrust_I-coor](https://user-images.githubusercontent.com/62292619/93168042-f05e8680-f75c-11ea-895b-bba9890d6464.jpg)
![Thrust_L-coor](https://user-images.githubusercontent.com/62292619/93168048-f2c0e080-f75c-11ea-835d-5e9eb792c579.jpg)


