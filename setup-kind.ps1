# Run PowerShell as Administrator before executing this script

Write-Host "===== Kubernetes (kind) Setup Started =====" -ForegroundColor Green

# Step 1: Install Chocolatey (if not installed)
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..." -ForegroundColor Yellow

    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = `
        [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    # Refresh environment
    $env:Path += ";$env:ALLUSERSPROFILE\chocolatey\bin"
} else {
    Write-Host "Chocolatey already installed" -ForegroundColor Cyan
}

# Verify Chocolatey
choco -v

# Step 2: Install kind
if (!(Get-Command kind -ErrorAction SilentlyContinue)) {
    Write-Host "Installing kind..." -ForegroundColor Yellow
    choco install kind -y
} else {
    Write-Host "kind already installed" -ForegroundColor Cyan
}

# Verify kind
kind version

# Step 3: Install kubectl
if (!(Get-Command kubectl -ErrorAction SilentlyContinue)) {
    Write-Host "Installing kubectl..." -ForegroundColor Yellow
    choco install kubernetes-cli -y
} else {
    Write-Host "kubectl already installed" -ForegroundColor Cyan
}

# Verify kubectl
kubectl version --client

# Step 4: Create kind cluster config file
$clusterConfig = @"
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    image: kindest/node:v1.35.1
  - role: worker
    image: kindest/node:v1.35.1
  - role: worker
    image: kindest/node:v1.35.1
  - role: worker
    image: kindest/node:v1.35.1
    extraPortMappings:
    - containerPort: 80 
      hostPort: 80
      protocol: tcp
    - containerPort: 443
      hostPort: 443
      protocol: tcp
"@

$clusterFilePath = "$PWD\kind-cluster.yaml"
$clusterConfig | Out-File -FilePath $clusterFilePath -Encoding utf8

Write-Host "Cluster config file created at $clusterFilePath" -ForegroundColor Green

# Step 5: Create cluster
Write-Host "Creating Kubernetes cluster..." -ForegroundColor Yellow
kind create cluster --config $clusterFilePath --name kind-cluster

# Step 6: Verify cluster
Write-Host "Verifying cluster..." -ForegroundColor Yellow

kubectl get nodes
kubectl cluster-info

Write-Host "===== Setup Completed Successfully 🚀 =====" -ForegroundColor Green
