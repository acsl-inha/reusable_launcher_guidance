

# 3Dof_model


GCU 에서 매 Step 마다 최종 시간을 계산하여 최적의 추력을 얻는 알고리즘을 추가하였음.


**알고리즘**


1.  NED 좌표계에서의 초기 위치와 초기 속도를 구한다.
2. 최종시간을 정하기 위해서  NED 기준 D축의 위치와 속도를 나눈 절대값을 초기값으로 둔다. t_f = position/velocity
3. t_f 으로 미리 짜놓은 cvx 함수를 실행한다.
4. 만약 결과값이 Infeasible하다면 
5. Bisection을 이용하여 최적의 최종시간을 구한다.
6. 최적의 시간을 최종 시간으로 저장한다.
7. 최적의 시간에 대해 추력을 Export한다.

# 결과
**parameter**

모든 Parameter 는 참고문헌 [1]를 참고하였음.

NED기준(Landing Coordinate System)  

Initial position = (0,500,-500)      [m]

Initial velocity = (50,0,50)   [m/s]

Initial mass = Vehicle dry mass + Fuel mass = 15000  [kg]   

Vehicle dry mass = 10000 [kg]
Fuel mass = 5000 [kg]  

Final position = (0,0,0)  [m]

Final velocity = (0,0,0)  [m/s]

Maximum Thrust = 2.5e + 5  [N]

Minimum Thrust = 1e+5  [N]

dt = 0.1 [Sec]


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








# 참고문헌

 1.  Michael Szmuk, Behcet Aclkmese, Andrew W. Berning Jr., “Successive 
Convexification for Fuel-Optimal Powered Landing With Aerodynamic Drag and 
Non-Convex Constraints,”American Institute of Aeronautics and Astronautics

