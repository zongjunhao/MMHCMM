import random

if __name__ == "__main__":
    master_num = 4
    worker_num = 400

    base_num = worker_num // master_num
    left_num = worker_num - master_num * base_num

    # 每个主节点分配多少个子节点
    master_array = [base_num] * master_num
    for i in range(left_num):
        master_array[i] += 1

    # 子节点分配方案
    result_array = []
    for index, node_num in enumerate(master_array):
        result_array.extend([index + 1] * node_num)
    random.shuffle(result_array)

    print(result_array)

    print(",".join(map(str, result_array)))

    # 手动保存为文本文件
    with open("./utils/plan_equal_distribute.txt", "w") as f:
        f.write(",".join(map(str, result_array)))
