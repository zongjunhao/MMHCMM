% 初始化工作节点，在此处修改工作节点性能参数
% @param: master_num: 工作节点数量
% @return: L: [master_num] 主节点任务量（行数）
% @return: S: [master_num] 每行计算前比特数
% @return: s: [master_num] 每行计算后比特数
% @return: R: [master_num] 主节点下发任务速率
function [L, S, s, R] = init_master(master_num)

    if master_num == 2
        L = [20, 50];
        S = [16, 16];
        s = [4, 4];
        R = [50, 100];
    elseif master_num == 4
        L = [10000, 20000, 40000, 80000];
        S = [16, 16, 16, 16];
        s = [4, 4, 4, 4];
        R = [50, 500, 100, 100];
    end

end
