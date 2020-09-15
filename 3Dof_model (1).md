

# 3Dof_model

GCU 에서 매 시간마다 최종 시간을 계산하는 알고리즘을 추가하였음.


**알고리즘**
1. 최종시간을 정하기 위해서 우선 NED 기준 D축의 위치와 속도를 나눈 절대값을 초기값으로 둔다. t_f = position/velocity
2. t_f 으로 미리 짜놓은 cvx 함수를 실행한다.
3. 만약 Infeasible하다면 시간을 늘리고 feasible하면 시간을 줄인다.

# 결과
## Ex1) Image(r=[0 , 500, -500])



## Ex2) Image( r = [ 0 , 500 , -1000])  
![3Dof_pos](https://user-images.githubusercontent.com/62292619/93167911-9f4e9280-f75c-11ea-9114-af406c1cbfb5.jpg)
![3dof_vel](https://user-images.githubusercontent.com/62292619/93168027-ea68a580-f75c-11ea-936f-9db60dc6458d.jpg)
![Aerodynamics](https://user-images.githubusercontent.com/62292619/93168032-eccaff80-f75c-11ea-9460-29dc619a19ab.jpg)
![Fi_total](https://user-images.githubusercontent.com/62292619/93168038-edfc2c80-f75c-11ea-9df1-c1357ba17a3d.jpg)
![Thrust_I-coor](https://user-images.githubusercontent.com/62292619/93168042-f05e8680-f75c-11ea-895b-bba9890d6464.jpg)
![Thrust_L-coor](https://user-images.githubusercontent.com/62292619/93168048-f2c0e080-f75c-11ea-835d-5e9eb792c579.jpg)


