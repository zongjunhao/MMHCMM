# MMHCMM

1. 现有方案：节点选择GA+编码（未固定码率）+负载分配HCMM                     main.m

对比方案：
1. 遍历所有工作节点选择方案+遍历所有负载分配方案 （小模型下）                main_cmp_1.m
2. 均分工作节点数目+均分工作节点的任务量=总任务量10000/节点数目 未编码       main_cmp_2.m
3. 均分工作节点数目+负载分配HCMM 编码                                     main_cmp_3.m
4. 用简单贪心选工作节点+负载分配HCMM 编码                                  main_cmp_4.m


$$
e^{\mu_n \lambda_{m,n}}=e^{\alpha_n \mu_n + \frac{\mu_n s_m}{R_m}+\frac{\mu_n s^\prime_m}{r_n}}(1+\mu_n \lambda_{m,n})
$$

$$
\gamma_m = \sum_{n \in \Omega_m} \frac{1}{\lambda_{m,n}} \left( 1-e^{-\mu_n \lambda_{m,n}\left(1-\frac{\alpha_n}{\lambda_{m,n}} - \frac{s_m}{\lambda_{m,n} R_m}-\frac{s^\prime_m}{\lambda_{m,n} r_n}\right)} \right)
$$