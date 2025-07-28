# On-Chain Transaction Trace & Compliance Agent

**A JuliaOS-Powered dApp for Multi-Chain Transaction Tracing and Compliance Analysis**

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![JuliaOS](https://img.shields.io/badge/powered%20by-JuliaOS-green.svg)
![Status](https://img.shields.io/badge/status-active-brightgreen.svg)

## 🎯 Overview

The On-Chain Transaction Trace & Compliance Agent is an advanced decentralized application (dApp) that leverages the power of JuliaOS AI agents to provide comprehensive transaction tracing and compliance analysis across multiple blockchain networks. This dApp addresses the critical need for transparency and regulatory compliance in the rapidly evolving Web3 ecosystem by offering automated, intelligent analysis of suspicious transaction patterns.

Built specifically for the JuliaOS bounty competition, this dApp demonstrates the versatility and power of JuliaOS's AI agent framework, swarm orchestration capabilities, and multi-chain deployment features. The application serves as an intelligent assistant for financial institutions, regulatory bodies, and blockchain forensic analysts, enabling them to reconstruct and visualize complex transaction paths while identifying potential compliance risks.

## 🚀 Key Features

### Core Functionality

**Multi-Chain Transaction Tracing**: The dApp can trace transactions across multiple blockchain networks including Ethereum, Binance Smart Chain, Polygon, and other EVM-compatible chains. This cross-chain capability is essential for modern blockchain forensics as malicious actors often use bridge protocols to obfuscate transaction trails.

**Automated Path Reconstruction**: Using sophisticated JuliaOS AI agents, the system automatically identifies and reconstructs complex transaction paths, even those involving multiple hops, different blockchain bridges, and various obfuscation techniques. The path reconstruction agent employs advanced graph traversal algorithms combined with machine learning heuristics to follow funds through complex networks.

**Obfuscation Detection**: The dApp includes specialized agents trained to detect common obfuscation techniques such as mixer usage, privacy-enhancing protocols, high-frequency transfers, and cross-chain bridge hopping. These detection capabilities are crucial for identifying attempts to hide the origin or destination of funds.

**Risk Scoring and Compliance Analysis**: Each traced transaction receives a comprehensive risk score based on predefined compliance rules, detected anomalies, and regulatory guidelines. The system applies Anti-Money Laundering (AML) and Combating the Financing of Terrorism (CFT) regulations to provide actionable compliance insights.

**Interactive Visualization**: The user interface provides an intuitive, interactive graph visualization of transaction flows, showing addresses, transaction amounts, timestamps, and associated risk indicators. Users can zoom, pan, and filter the visualization to focus on specific aspects of the transaction path.

**Comprehensive Reporting**: The dApp generates detailed compliance reports suitable for regulatory submissions, internal investigations, and audit purposes. Reports include executive summaries, detailed findings, risk assessments, and recommended actions.

### JuliaOS Integration

This dApp showcases the full potential of the JuliaOS framework through several key integrations:

**JuliaOS Agent Execution**: The core intelligence of the dApp resides in its JuliaOS AI agents, each designed to perform specific tasks within the transaction tracing pipeline. The system utilizes `agent.useLLM()` and related APIs to deploy intelligent agents for data collection, pattern recognition, risk assessment, and multi-chain analysis.

**Swarm Integration**: For complex tracing scenarios, the dApp employs JuliaOS swarm orchestration to coordinate multiple specialized agents working in concert. For example, a swarm might consist of a "Mixer Detection Agent," a "Cross-Chain Bridge Agent," and a "Wallet Clustering Agent" collaborating to unravel sophisticated obfuscation schemes.

**Onchain Functionality**: The dApp leverages JuliaOS's onchain interfaces to execute real-time queries, retrieve transaction data, and interact with smart contracts across multiple blockchain networks. This integration ensures that the analysis is based on the most current and accurate blockchain data available.

## 🏗️ Architecture

The dApp follows a modular, scalable architecture designed to handle high-volume transaction analysis while maintaining performance and reliability.

### System Components

**Frontend Layer**: A modern React-based web application that provides an intuitive user interface for initiating traces, visualizing results, and generating reports. The frontend is built with responsive design principles to ensure accessibility across desktop and mobile devices.

**Backend Services**: A robust Flask-based API layer that orchestrates JuliaOS agent execution, manages data processing, and provides secure endpoints for frontend communication. The backend includes comprehensive error handling, logging, and monitoring capabilities.

**JuliaOS Agent Framework**: The core intelligence layer consisting of specialized AI agents for different aspects of transaction analysis. Each agent is designed to be modular, scalable, and easily configurable for different use cases.

**Blockchain Integration**: Direct integration with multiple blockchain networks through JuliaOS onchain interfaces and supplementary Web3 libraries for comprehensive data access.

**Data Storage**: Efficient storage solutions for historical transaction data, risk profiles, compliance rules, and analysis results, enabling rapid retrieval and pattern analysis.

### Agent Architecture

The dApp employs a sophisticated multi-agent architecture where each agent specializes in a specific aspect of transaction analysis:

**Blockchain Data Collection Agent**: Responsible for fetching raw transaction data, block information, and account details from various blockchain networks. This agent handles rate limiting, error recovery, and data normalization across different blockchain APIs.

**Transaction Path Reconstruction Agent**: Employs advanced graph algorithms and machine learning techniques to reconstruct the flow of funds from origin to destination. This agent can handle complex scenarios involving multiple intermediary addresses and cross-chain transfers.

**Obfuscation Detection Agent**: Utilizes pattern recognition and anomaly detection to identify suspicious transaction patterns indicative of obfuscation attempts. The agent is trained on known obfuscation techniques and continuously updates its detection capabilities.

**Risk Assessment Agent**: Applies comprehensive risk scoring algorithms based on regulatory guidelines, blacklists, transaction patterns, and detected anomalies. This agent provides the foundation for compliance analysis and reporting.

**Swarm Orchestration**: For highly complex cases, a master orchestrator coordinates multiple specialized agents, enabling parallel processing and comprehensive analysis of sophisticated transaction schemes.

## 🛠️ Technology Stack

### Frontend Technologies

**React.js**: The frontend is built using React.js, chosen for its component-based architecture, extensive ecosystem, and excellent performance characteristics. React's virtual DOM and efficient rendering make it ideal for handling complex, interactive visualizations.

**Tailwind CSS**: For rapid UI development and consistent styling, the dApp uses Tailwind CSS, which provides utility-first CSS classes and responsive design capabilities out of the box.

**Shadcn/UI Components**: The interface leverages high-quality, accessible UI components from the Shadcn/UI library, ensuring a professional appearance and excellent user experience.

**Lucide Icons**: Vector icons from Lucide provide clear, scalable iconography throughout the interface.

**Recharts**: For data visualization and charting capabilities, enabling clear presentation of risk scores, transaction volumes, and other analytical data.

### Backend Technologies

**Python**: The backend is implemented in Python, chosen for its strong ecosystem in AI/ML applications and excellent integration capabilities with JuliaOS Python bindings.

**Flask**: A lightweight, flexible web framework that provides the foundation for the API layer while allowing for easy integration with JuliaOS components.

**Flask-CORS**: Enables cross-origin resource sharing, allowing the frontend to communicate securely with the backend services.

**SQLite/PostgreSQL**: Database solutions for storing transaction data, analysis results, and configuration information.

### Blockchain Integration

**JuliaOS Onchain Interfaces**: Primary integration point for blockchain data access and smart contract interaction.

**Web3.py**: Supplementary library for direct interaction with Ethereum-compatible chains when additional functionality is required.

**Ethers.js**: JavaScript library for blockchain interaction from the frontend when direct client-side operations are needed.

### Smart Contract Development

**Solidity**: Smart contracts are written in Solidity for Ethereum-compatible chains, providing onchain data storage and verification capabilities.

**Hardhat**: Development environment for smart contract compilation, testing, and deployment.

## 📋 Prerequisites

Before setting up the dApp, ensure you have the following prerequisites installed and configured:

### System Requirements

- **Operating System**: Linux (Ubuntu 20.04+), macOS (10.15+), or Windows 10+ with WSL2
- **Memory**: Minimum 8GB RAM (16GB recommended for optimal performance)
- **Storage**: At least 10GB free disk space
- **Network**: Stable internet connection for blockchain data access

### Software Dependencies

- **Node.js**: Version 18.0 or higher
- **Python**: Version 3.9 or higher
- **Git**: For version control and repository management
- **JuliaOS**: Latest version installed and configured

### API Keys and Access

- **Blockchain RPC Endpoints**: Access to reliable RPC endpoints for target blockchain networks
- **JuliaOS API Keys**: Valid JuliaOS API credentials for agent execution
- **Optional**: Etherscan API keys for enhanced data access

## 🚀 Installation and Setup

### Step 1: Clone the Repository

```bash
git clone https://github.com/your-username/trace-dapp.git
cd trace-dapp
```

### Step 2: Backend Setup

Navigate to the backend directory and set up the Python environment:

```bash
cd trace-dapp-backend
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

Configure environment variables by creating a `.env` file:

```bash
cp .env.example .env
# Edit .env with your configuration
```

### Step 3: Frontend Setup

Navigate to the frontend directory and install dependencies:

```bash
cd ../trace-dapp-frontend
npm install
# or
pnpm install
```

### Step 4: Smart Contract Setup

Navigate to the smart contracts directory and set up the development environment:

```bash
cd ../smart_contracts/ethereum
npm install
npx hardhat compile
```

### Step 5: JuliaOS Configuration

Ensure JuliaOS is properly configured with your API credentials:

```bash
# Configure JuliaOS credentials
juliaos config set-api-key YOUR_API_KEY
juliaos config set-endpoint YOUR_ENDPOINT
```

## 🏃‍♂️ Running the Application

### Development Mode

To run the application in development mode with hot reloading:

**Terminal 1 - Backend**:
```bash
cd trace-dapp-backend
source venv/bin/activate
python src/main.py
```

**Terminal 2 - Frontend**:
```bash
cd trace-dapp-frontend
npm run dev
# or
pnpm run dev
```

The application will be available at:
- Frontend: http://localhost:5173
- Backend API: http://localhost:5000

### Production Mode

For production deployment, build the frontend and serve it through the Flask backend:

```bash
# Build frontend
cd trace-dapp-frontend
npm run build

# Copy build files to backend static directory
cp -r dist/* ../trace-dapp-backend/src/static/

# Run production server
cd ../trace-dapp-backend
source venv/bin/activate
python src/main.py
```

## 📖 Usage Guide

### Basic Transaction Tracing

1. **Access the Application**: Open your web browser and navigate to the application URL.

2. **Enter Transaction Details**: In the main interface, enter a transaction hash or wallet address in the search field.

3. **Initiate Trace**: Click the "Trace" button to begin the analysis. The system will deploy JuliaOS agents to analyze the transaction.

4. **Review Results**: Once the analysis is complete, review the results in the three main tabs:
   - **Transaction Path**: Visual representation of the transaction flow
   - **Risk Analysis**: AI-powered analysis of suspicious patterns
   - **Compliance Report**: Regulatory compliance assessment

### Advanced Features

**Multi-Chain Analysis**: The system automatically detects and follows transactions across different blockchain networks, providing a comprehensive view of cross-chain activity.

**Risk Filtering**: Use the risk level filters to focus on high-risk transactions or addresses within the trace results.

**Export Functionality**: Generate and download detailed compliance reports in PDF or CSV format for regulatory submissions or internal documentation.

**Historical Analysis**: Access previously analyzed transactions through the search history feature.

## 🔧 API Documentation

### Trace Endpoint

**POST** `/api/trace`

Initiates a comprehensive transaction trace using JuliaOS agents.

**Request Body**:
```json
{
  "transaction_hash": "0x1234567890abcdef...",
  "options": {
    "max_depth": 10,
    "include_chains": ["ethereum", "bsc", "polygon"],
    "risk_threshold": 50
  }
}
```

**Response**:
```json
{
  "transaction_hash": "0x1234567890abcdef...",
  "risk_score": 75,
  "total_hops": 8,
  "chains": ["Ethereum", "Binance Smart Chain"],
  "suspicious_activities": ["Mixer Usage", "High-Frequency Transfers"],
  "path": [...],
  "analysis_timestamp": 1634567890
}
```

### Compliance Report Endpoint

**POST** `/api/compliance-report`

Generates a detailed compliance report based on trace results.

**Request Body**:
```json
{
  "trace_results": {...},
  "report_type": "full",
  "include_recommendations": true
}
```

### Health Check Endpoint

**GET** `/api/health`

Returns the current status of the backend services and JuliaOS agent availability.

## 🧪 Testing

### Unit Tests

Run the backend unit tests:

```bash
cd trace-dapp-backend
source venv/bin/activate
python -m pytest tests/
```

Run the frontend unit tests:

```bash
cd trace-dapp-frontend
npm test
```

### Integration Tests

Test the complete transaction tracing pipeline:

```bash
cd trace-dapp-backend
source venv/bin/activate
python tests/integration/test_trace_pipeline.py
```

### Smart Contract Tests

Test the smart contract functionality:

```bash
cd smart_contracts/ethereum
npx hardhat test
```

## 🚀 Deployment

### Local Deployment

For local deployment with production settings:

```bash
# Build and deploy locally
./scripts/deploy-local.sh
```

### Cloud Deployment

The dApp is designed to be easily deployable on various cloud platforms:

**Docker Deployment**:
```bash
docker build -t trace-dapp .
docker run -p 5000:5000 trace-dapp
```

**Kubernetes Deployment**:
```bash
kubectl apply -f k8s/
```

### Environment Configuration

Ensure the following environment variables are configured for production:

- `JULIAOS_API_KEY`: Your JuliaOS API key
- `JULIAOS_ENDPOINT`: JuliaOS API endpoint
- `DATABASE_URL`: Database connection string
- `SECRET_KEY`: Flask secret key for session management
- `CORS_ORIGINS`: Allowed CORS origins for security

## 🔒 Security Considerations

### Data Privacy

The dApp is designed with privacy-first principles:

- **No Personal Data Storage**: The system does not store personal information or private keys
- **Encrypted Communications**: All API communications use HTTPS encryption
- **Minimal Data Retention**: Transaction analysis data is retained only as long as necessary

### Access Control

- **API Rate Limiting**: Prevents abuse and ensures fair resource allocation
- **Input Validation**: Comprehensive validation of all user inputs to prevent injection attacks
- **CORS Configuration**: Properly configured cross-origin resource sharing policies

### Blockchain Security

- **Read-Only Operations**: The dApp only reads blockchain data and does not perform any write operations
- **Multiple RPC Sources**: Uses multiple RPC endpoints for redundancy and verification
- **Smart Contract Auditing**: All smart contracts undergo thorough security audits

## 🤝 Contributing

We welcome contributions from the community! Please follow these guidelines:

### Development Workflow

1. **Fork the Repository**: Create a fork of the main repository
2. **Create Feature Branch**: Create a new branch for your feature or bug fix
3. **Make Changes**: Implement your changes with appropriate tests
4. **Submit Pull Request**: Submit a pull request with a clear description of your changes

### Code Standards

- **Python**: Follow PEP 8 style guidelines
- **JavaScript/React**: Use ESLint and Prettier for code formatting
- **Documentation**: Update documentation for any new features or changes
- **Testing**: Include appropriate tests for new functionality

### Issue Reporting

When reporting issues, please include:

- **Environment Details**: Operating system, software versions
- **Reproduction Steps**: Clear steps to reproduce the issue
- **Expected Behavior**: What you expected to happen
- **Actual Behavior**: What actually happened
- **Logs**: Relevant log files or error messages

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **JuliaOS Team**: For providing the powerful AI agent framework that makes this dApp possible
- **Open Source Community**: For the various libraries and tools that contribute to this project
- **Blockchain Community**: For the ongoing development of transparent and decentralized technologies

## 📞 Support

For technical support or questions about the dApp:

- **GitHub Issues**: [Create an issue](https://github.com/your-username/trace-dapp/issues)
- **Documentation**: [Read the docs](https://docs.trace-dapp.com)
- **Community Discord**: [Join our Discord](https://discord.gg/trace-dapp)

## 🔗 Links

- **Live Demo**: [https://demo.trace-dapp.com](https://demo.trace-dapp.com)
- **JuliaOS Documentation**: [https://docs.juliaos.com](https://docs.juliaos.com)
- **Project Repository**: [https://github.com/your-username/trace-dapp](https://github.com/your-username/trace-dapp)

---

**Built with ❤️ for the JuliaOS Bounty Competition**

*This dApp demonstrates the power of AI-driven blockchain analysis and the potential of JuliaOS for building intelligent, decentralized applications.*

