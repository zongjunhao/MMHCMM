% 均分工作节点数目+均分工作节点的任务量=总任务量10000/节点数目 未编码

clear
clc
close all
tic

distribute = importdata('./utils/plan_equal_distribute.txt', ',');

disp(distribute)