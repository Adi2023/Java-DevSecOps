#!/bin/bash

# Fetch Kubernetes version
kubernetes_version=$(kubectl version --short | grep 'Server Version:' | awk '{print $3}')

# Run kube-bench against Kubernetes nodes and check for compliance with checks 4.2.1 and 4.2.2
total_fail=$(kube-bench run --targets node --version "$kubernetes_version" --check 4.2.1,4.2.2 --json | jq .[].total_fail)

# Check if there are any failed checks
if [[ "$total_fail" -ne 0 ]]; then
    echo "CIS Benchmark Failed Kubelet while testing for 4.2.1 and 4.2.2 on Kubernetes version $kubernetes_version."
    exit 1
else
    echo "CIS Benchmark Passed Kubelet for 4.2.1 and 4.2.2 on Kubernetes version $kubernetes_version."
fi
