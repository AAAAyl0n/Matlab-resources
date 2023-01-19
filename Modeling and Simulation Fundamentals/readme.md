# [1]Modeling and Simulation Fundamentals
![Pasted image 20230119180349](https://user-images.githubusercontent.com/86991220/213454369-27a6f93c-8246-488c-8746-fd3c78d2d72f.png)
TestCode：RK4.m

answer for question 2:The error plot for RK4 may increase when the time-step size is very small because of the accumulation of round-off errors. As the time-step size decreases, the number of time-steps required to integrate the system increases, leading to a greater number of arithmetic operations and an increased chance of round-off errors. These errors accumulate over time, leading to an overall increase in the error of the solution. Additionally, using small time-steps may cause the solution to be computationally expensive. This can cause the error from the numerical integration method to be dominated by the error from the floating-point arithmetic used to perform the calculations.
