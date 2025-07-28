# Deployment Guide

## Overview

This guide provides comprehensive instructions for deploying the On-Chain Transaction Trace & Compliance Agent dApp in various environments, from local development to production deployment.

## Prerequisites

### System Requirements
- **Operating System**: Linux (Ubuntu 20.04+), macOS (10.15+), or Windows 10+ with WSL2
- **Memory**: Minimum 8GB RAM (16GB recommended for production)
- **Storage**: At least 10GB free disk space
- **Network**: Stable internet connection for blockchain data access

### Software Dependencies
- **Node.js**: Version 18.0 or higher
- **Python**: Version 3.9 or higher
- **Git**: For version control and repository management
- **JuliaOS**: Latest version installed and configured

## Local Development Setup

### Step 1: Environment Preparation

```bash
# Clone the repository
git clone <repository-url>
cd juliaos-trace-dapp-submission

# Verify Node.js and Python versions
node --version  # Should be 18.0+
python3 --version  # Should be 3.9+
```

### Step 2: Backend Setup

```bash
# Navigate to backend directory
cd backend

# Create and activate virtual environment
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install Python dependencies
pip install -r requirements.txt

# Set up environment variables
cp .env.example .env
# Edit .env with your configuration
```

### Step 3: Frontend Setup

```bash
# Navigate to frontend directory
cd ../frontend

# Install Node.js dependencies
npm install
# or
pnpm install

# Build for production
npm run build
```

### Step 4: Smart Contract Setup

```bash
# Navigate to smart contracts directory
cd ../smart-contracts/ethereum

# Install dependencies
npm install

# Compile contracts
npx hardhat compile

# Deploy to local network (optional)
npx hardhat run scripts/deploy.js --network localhost
```

### Step 5: JuliaOS Configuration

```bash
# Configure JuliaOS credentials
juliaos config set-api-key YOUR_API_KEY
juliaos config set-endpoint YOUR_ENDPOINT

# Verify configuration
juliaos config list
```

## Production Deployment

### Option 1: Traditional Server Deployment

#### Server Preparation

```bash
# Update system packages
sudo apt update && sudo apt upgrade -y

# Install required packages
sudo apt install -y python3 python3-pip nodejs npm git nginx

# Install PM2 for process management
sudo npm install -g pm2

# Create application user
sudo useradd -m -s /bin/bash traceapp
sudo usermod -aG sudo traceapp
```

#### Application Deployment

```bash
# Switch to application user
sudo su - traceapp

# Clone repository
git clone <repository-url> /home/traceapp/trace-dapp
cd /home/traceapp/trace-dapp

# Backend setup
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Frontend build
cd ../frontend
npm install
npm run build

# Copy frontend build to backend static directory
cp -r dist/* ../backend/src/static/

# Configure environment
cd ../backend
cp .env.example .env
# Edit .env with production settings
```

#### Process Management with PM2

```bash
# Create PM2 ecosystem file
cat > ecosystem.config.js << EOF
module.exports = {
  apps: [{
    name: 'trace-dapp',
    script: 'src/main.py',
    cwd: '/home/traceapp/trace-dapp/backend',
    interpreter: '/home/traceapp/trace-dapp/backend/venv/bin/python',
    env: {
      FLASK_ENV: 'production',
      PORT: 5000
    },
    instances: 2,
    exec_mode: 'cluster',
    watch: false,
    max_memory_restart: '1G',
    error_file: '/var/log/trace-dapp/error.log',
    out_file: '/var/log/trace-dapp/out.log',
    log_file: '/var/log/trace-dapp/combined.log'
  }]
};
EOF

# Create log directory
sudo mkdir -p /var/log/trace-dapp
sudo chown traceapp:traceapp /var/log/trace-dapp

# Start application
pm2 start ecosystem.config.js
pm2 save
pm2 startup
```

#### Nginx Configuration

```bash
# Create Nginx configuration
sudo tee /etc/nginx/sites-available/trace-dapp << EOF
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }

    location /static {
        alias /home/traceapp/trace-dapp/backend/src/static;
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
EOF

# Enable site
sudo ln -s /etc/nginx/sites-available/trace-dapp /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

### Option 2: Docker Deployment

#### Dockerfile for Backend

```dockerfile
# backend/Dockerfile
FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose port
EXPOSE 5000

# Run application
CMD ["python", "src/main.py"]
```

#### Docker Compose Configuration

```yaml
# docker-compose.yml
version: '3.8'

services:
  backend:
    build: ./backend
    ports:
      - "5000:5000"
    environment:
      - FLASK_ENV=production
      - DATABASE_URL=postgresql://user:password@db:5432/tracedb
    depends_on:
      - db
    volumes:
      - ./logs:/app/logs

  db:
    image: postgres:13
    environment:
      - POSTGRES_DB=tracedb
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
    volumes:
      - postgres_data:/var/lib/postgresql/data

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./ssl:/etc/nginx/ssl
    depends_on:
      - backend

volumes:
  postgres_data:
```

#### Docker Deployment Commands

```bash
# Build and start services
docker-compose up -d

# View logs
docker-compose logs -f

# Scale backend service
docker-compose up -d --scale backend=3

# Update application
docker-compose pull
docker-compose up -d
```

### Option 3: Cloud Platform Deployment

#### AWS Deployment with Elastic Beanstalk

```bash
# Install EB CLI
pip install awsebcli

# Initialize Elastic Beanstalk application
eb init trace-dapp --platform python-3.11

# Create environment
eb create production

# Deploy application
eb deploy

# Open application
eb open
```

#### Google Cloud Platform Deployment

```yaml
# app.yaml for Google App Engine
runtime: python311

env_variables:
  FLASK_ENV: production
  JULIAOS_API_KEY: your-api-key

automatic_scaling:
  min_instances: 1
  max_instances: 10
  target_cpu_utilization: 0.6

handlers:
- url: /static
  static_dir: src/static
  
- url: /.*
  script: auto
```

```bash
# Deploy to Google App Engine
gcloud app deploy app.yaml
```

#### Heroku Deployment

```bash
# Create Heroku app
heroku create trace-dapp-production

# Set environment variables
heroku config:set FLASK_ENV=production
heroku config:set JULIAOS_API_KEY=your-api-key

# Deploy application
git push heroku main

# Open application
heroku open
```

## Environment Configuration

### Environment Variables

Create a `.env` file in the backend directory with the following variables:

```bash
# Flask Configuration
FLASK_ENV=production
SECRET_KEY=your-secret-key-here
DEBUG=False

# JuliaOS Configuration
JULIAOS_API_KEY=your-juliaos-api-key
JULIAOS_ENDPOINT=https://api.juliaos.com
JULIAOS_TIMEOUT=30

# Database Configuration
DATABASE_URL=postgresql://user:password@localhost:5432/tracedb
# For SQLite (development)
# DATABASE_URL=sqlite:///app.db

# Blockchain Configuration
ETHEREUM_RPC_URL=https://mainnet.infura.io/v3/your-project-id
BSC_RPC_URL=https://bsc-dataseed.binance.org/
POLYGON_RPC_URL=https://polygon-rpc.com/

# API Configuration
CORS_ORIGINS=https://your-domain.com,https://www.your-domain.com
RATE_LIMIT_PER_MINUTE=100
MAX_TRACE_DEPTH=20

# Logging Configuration
LOG_LEVEL=INFO
LOG_FILE=/var/log/trace-dapp/app.log

# Security Configuration
ALLOWED_HOSTS=your-domain.com,www.your-domain.com
SECURE_SSL_REDIRECT=True
SESSION_COOKIE_SECURE=True
```

### Production Security Settings

```python
# backend/src/config.py
import os

class ProductionConfig:
    SECRET_KEY = os.environ.get('SECRET_KEY')
    DEBUG = False
    TESTING = False
    
    # Database
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    
    # Security
    WTF_CSRF_ENABLED = True
    SSL_REDIRECT = True
    
    # CORS
    CORS_ORIGINS = os.environ.get('CORS_ORIGINS', '').split(',')
    
    # Rate Limiting
    RATELIMIT_STORAGE_URL = 'redis://localhost:6379'
```

## SSL/TLS Configuration

### Let's Encrypt with Certbot

```bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx

# Obtain SSL certificate
sudo certbot --nginx -d your-domain.com -d www.your-domain.com

# Test automatic renewal
sudo certbot renew --dry-run

# Set up automatic renewal
sudo crontab -e
# Add: 0 12 * * * /usr/bin/certbot renew --quiet
```

### Manual SSL Configuration

```nginx
# /etc/nginx/sites-available/trace-dapp-ssl
server {
    listen 443 ssl http2;
    server_name your-domain.com;

    ssl_certificate /path/to/your/certificate.crt;
    ssl_certificate_key /path/to/your/private.key;
    
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512;
    ssl_prefer_server_ciphers off;
    
    location / {
        proxy_pass http://localhost:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

server {
    listen 80;
    server_name your-domain.com;
    return 301 https://$server_name$request_uri;
}
```

## Monitoring and Logging

### Application Monitoring

```bash
# Install monitoring tools
pip install prometheus-flask-exporter
pip install sentry-sdk[flask]

# Configure Sentry (in main.py)
import sentry_sdk
from sentry_sdk.integrations.flask import FlaskIntegration

sentry_sdk.init(
    dsn="your-sentry-dsn",
    integrations=[FlaskIntegration()],
    traces_sample_rate=1.0
)
```

### Log Management

```python
# backend/src/logging_config.py
import logging
import logging.handlers
import os

def setup_logging():
    log_level = os.environ.get('LOG_LEVEL', 'INFO')
    log_file = os.environ.get('LOG_FILE', '/var/log/trace-dapp/app.log')
    
    # Create log directory if it doesn't exist
    os.makedirs(os.path.dirname(log_file), exist_ok=True)
    
    # Configure logging
    logging.basicConfig(
        level=getattr(logging, log_level),
        format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
        handlers=[
            logging.handlers.RotatingFileHandler(
                log_file, maxBytes=10485760, backupCount=5
            ),
            logging.StreamHandler()
        ]
    )
```

## Database Setup

### PostgreSQL Setup

```bash
# Install PostgreSQL
sudo apt install postgresql postgresql-contrib

# Create database and user
sudo -u postgres psql
CREATE DATABASE tracedb;
CREATE USER traceuser WITH PASSWORD 'your-password';
GRANT ALL PRIVILEGES ON DATABASE tracedb TO traceuser;
\q

# Update connection string in .env
DATABASE_URL=postgresql://traceuser:your-password@localhost:5432/tracedb
```

### Database Migration

```python
# backend/src/migrate.py
from flask_migrate import Migrate, upgrade
from main import app, db

migrate = Migrate(app, db)

def deploy():
    """Run deployment tasks."""
    # Create database tables
    upgrade()
    
    # Add any additional setup tasks here

if __name__ == '__main__':
    deploy()
```

## Performance Optimization

### Caching Configuration

```python
# Install Redis
sudo apt install redis-server

# Configure Flask-Caching
from flask_caching import Cache

cache = Cache(app, config={
    'CACHE_TYPE': 'redis',
    'CACHE_REDIS_URL': 'redis://localhost:6379/0',
    'CACHE_DEFAULT_TIMEOUT': 300
})
```

### Load Balancing

```nginx
# /etc/nginx/nginx.conf
upstream trace_dapp {
    server 127.0.0.1:5000;
    server 127.0.0.1:5001;
    server 127.0.0.1:5002;
}

server {
    listen 80;
    server_name your-domain.com;
    
    location / {
        proxy_pass http://trace_dapp;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

## Backup and Recovery

### Database Backup

```bash
# Create backup script
cat > /home/traceapp/backup.sh << EOF
#!/bin/bash
BACKUP_DIR="/home/traceapp/backups"
DATE=$(date +%Y%m%d_%H%M%S)
mkdir -p $BACKUP_DIR

# Database backup
pg_dump -h localhost -U traceuser tracedb > $BACKUP_DIR/db_backup_$DATE.sql

# Application backup
tar -czf $BACKUP_DIR/app_backup_$DATE.tar.gz /home/traceapp/trace-dapp

# Clean old backups (keep last 7 days)
find $BACKUP_DIR -name "*.sql" -mtime +7 -delete
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -delete
EOF

chmod +x /home/traceapp/backup.sh

# Schedule daily backups
crontab -e
# Add: 0 2 * * * /home/traceapp/backup.sh
```

## Troubleshooting

### Common Issues

1. **Port Already in Use**
   ```bash
   # Find process using port 5000
   sudo lsof -i :5000
   # Kill process
   sudo kill -9 <PID>
   ```

2. **Permission Denied**
   ```bash
   # Fix file permissions
   sudo chown -R traceapp:traceapp /home/traceapp/trace-dapp
   chmod +x /home/traceapp/trace-dapp/backend/src/main.py
   ```

3. **Database Connection Error**
   ```bash
   # Check PostgreSQL status
   sudo systemctl status postgresql
   # Restart if needed
   sudo systemctl restart postgresql
   ```

4. **JuliaOS API Issues**
   ```bash
   # Verify API key
   juliaos config list
   # Test connection
   curl -H "Authorization: Bearer $JULIAOS_API_KEY" https://api.juliaos.com/health
   ```

### Log Analysis

```bash
# View application logs
tail -f /var/log/trace-dapp/app.log

# View Nginx logs
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log

# View PM2 logs
pm2 logs trace-dapp
```

## Maintenance

### Regular Maintenance Tasks

```bash
# Update dependencies
cd /home/traceapp/trace-dapp/backend
source venv/bin/activate
pip list --outdated
pip install -U package-name

# Update Node.js dependencies
cd ../frontend
npm audit
npm update

# Clean up logs
sudo logrotate -f /etc/logrotate.conf

# Monitor disk space
df -h
du -sh /home/traceapp/trace-dapp
```

### Health Checks

```bash
# Create health check script
cat > /home/traceapp/health_check.sh << EOF
#!/bin/bash
# Check application health
curl -f http://localhost:5000/api/health || exit 1

# Check database connection
pg_isready -h localhost -U traceuser || exit 1

# Check disk space
DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ $DISK_USAGE -gt 80 ]; then
    echo "Disk usage is above 80%"
    exit 1
fi

echo "All health checks passed"
EOF

chmod +x /home/traceapp/health_check.sh
```

This comprehensive deployment guide covers all aspects of deploying the On-Chain Transaction Trace & Compliance Agent dApp from development to production environments.

