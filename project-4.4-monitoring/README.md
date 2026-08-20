# Project 4.4 — Monitoring Kubernetes with Prometheus & Grafana

Deploy Prometheus (metrics collection) + Grafana (dashboards) onto a Kubernetes
cluster using the `kube-prometheus-stack` Helm chart.

## 1. Create a local cluster (Task 1)
```bash
kind create cluster --name monitoring --config kind-config.yaml
kubectl get nodes
```

## 2. Deploy the monitoring stack (Tasks 2-4)
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

kubectl create namespace monitoring
helm install kps prometheus-community/kube-prometheus-stack \
  -n monitoring -f values.yaml

kubectl get pods -n monitoring -w        # wait for everything Running
```
This single chart installs Prometheus, Grafana, node-exporter and
kube-state-metrics. Prometheus is already scraping the cluster (Task 3), and
Grafana already has Prometheus set as its data source (Task 5) — that wiring is
built into the chart.

## 3. Open Grafana (Task 6)
```bash
kubectl port-forward -n monitoring svc/kps-grafana 3000:80
# browse http://localhost:3000  (login: admin / admin123)
```

## 4. View / import dashboards (Tasks 6-7)
The chart ships Kubernetes dashboards out of the box (look under Dashboards →
"Kubernetes / Compute Resources ..."). To import a popular community one:
- Grafana → Dashboards → Import → enter ID **1860** (Node Exporter Full) or
  **315** (Kubernetes cluster monitoring) → select the Prometheus data source.

Dashboards show CPU usage, memory consumption, pod status, and node resource use.

## Deliverable screenshots
1. Prometheus pods running (`kubectl get pods -n monitoring`)
2. Grafana deployment running
3. Prometheus configured as the Grafana data source (Grafana → Connections → Data sources)
4. A Kubernetes monitoring dashboard with live metrics

## Elevate
- Import pre-built dashboards (done above).
- Add Prometheus alert rules for high CPU / memory.
- Explore app-level metrics and node/pod performance trends.

## Clean up
```bash
helm uninstall kps -n monitoring
kind delete cluster --name monitoring
```
