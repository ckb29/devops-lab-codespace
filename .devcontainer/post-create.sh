#!/usr/bin/env bash
set -e

mkdir -p ~/devops_lab
cd ~/devops_lab

# KIND Startup Script
cat > start-kind.sh <<'EOF'
#!/usr/bin/env bash
set -e
kind create cluster --name devops-lab --wait 90s
kubectl cluster-info --context kind-devops-lab || true
EOF
chmod +x start-kind.sh

# Docker Services Startup Script
cat > start-services.sh <<'EOF'
#!/usr/bin/env bash
set -e

docker run -d --name nginx -p 8080:80 nginx:latest
docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=testdb -p 3306:3306 mysql:8.0
docker run -d --name redis -p 6379:6379 redis:latest

docker volume create jenkins-data || true
docker run -d --name jenkins -p 8081:8080 -v jenkins-data:/var/jenkins_home jenkins/jenkins:lts

docker run -d --name prometheus -p 9090:9090 prom/prometheus

docker volume create grafana-storage || true
docker run -d --name grafana -p 3000:3000 -v grafana-storage:/var/lib/grafana grafana/grafana

echo "Services running: nginx(8080), mysql(3306), redis(6379), jenkins(8081), prometheus(9090), grafana(3000)"
EOF
chmod +x start-services.sh

echo "Setup complete. Use: ~/devops_lab/start-kind.sh & start-services.sh"
