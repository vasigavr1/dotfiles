#!/usr/bin/env bash

echo "Out of buffer: "
cat /sys/class/infiniband/mlx5_0/ports/1/hw_counters/out_of_buffer
echo "--------------------"

echo "req_cqe_error: "
cat /sys/class/infiniband/mlx5_0/ports/1/hw_counters/req_cqe_error
echo "--------------------"

echo "req_cqe_flush_error: " 
cat /sys/class/infiniband/mlx5_0/ports/1/hw_counters/req_cqe_flush_error
echo "--------------------"

echo "req_remote_access_errors: "
cat /sys/class/infiniband/mlx5_0/ports/1/hw_counters/req_remote_access_errors
echo "--------------------"
