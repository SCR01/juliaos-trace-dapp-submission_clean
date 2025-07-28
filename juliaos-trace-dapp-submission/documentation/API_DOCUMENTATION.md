# API Documentation

## Overview

The On-Chain Transaction Trace & Compliance Agent dApp provides a comprehensive REST API for transaction tracing, risk assessment, and compliance analysis. All endpoints are designed to work seamlessly with JuliaOS agents and provide real-time blockchain analysis capabilities.

## Base URL

```
Production: https://api.trace-dapp.com
Development: http://localhost:5000
```

## Authentication

Currently, the API operates without authentication for the bounty demonstration. In production, API keys would be required:

```http
Authorization: Bearer YOUR_API_KEY
```

## Rate Limiting

- **Rate Limit**: 100 requests per minute per IP
- **Burst Limit**: 10 requests per second
- **Headers**: Rate limit information is included in response headers

## Error Handling

All API responses follow a consistent error format:

```json
{
  "error": "Error description",
  "code": "ERROR_CODE",
  "timestamp": 1634567890,
  "request_id": "req_123456789"
}
```

### HTTP Status Codes

- `200` - Success
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `429` - Rate Limit Exceeded
- `500` - Internal Server Error

## Endpoints

### 1. Transaction Tracing

#### POST /api/trace

Initiates a comprehensive transaction trace using JuliaOS agents.

**Request Body:**
```json
{
  "transaction_hash": "0x1234567890abcdef...",
  "options": {
    "max_depth": 10,
    "include_chains": ["ethereum", "bsc", "polygon"],
    "risk_threshold": 50,
    "enable_swarm": true,
    "analysis_type": "full"
  }
}
```

**Parameters:**
- `transaction_hash` (string, required): The transaction hash to trace
- `options` (object, optional): Configuration options for the trace
  - `max_depth` (integer): Maximum depth for path reconstruction (default: 10)
  - `include_chains` (array): Blockchain networks to include in analysis
  - `risk_threshold` (integer): Minimum risk score to flag (0-100)
  - `enable_swarm` (boolean): Enable JuliaOS swarm orchestration
  - `analysis_type` (string): Type of analysis ("basic", "full", "compliance")

**Response:**
```json
{
  "transaction_hash": "0x1234567890abcdef...",
  "risk_score": 75,
  "total_hops": 8,
  "chains": ["Ethereum", "Binance Smart Chain", "Polygon"],
  "suspicious_activities": ["Mixer Usage", "High-Frequency Transfers"],
  "path": [
    {
      "address": "0x1234...5678",
      "amount": "100 ETH",
      "chain": "Ethereum",
      "risk": "low",
      "timestamp": 1634567890,
      "transaction_hash": "0xabcd...efgh",
      "block_number": 15000000
    }
  ],
  "blockchain_data": {
    "transaction_hash": "0x1234567890abcdef...",
    "chain": "Ethereum",
    "block_number": 15000000,
    "timestamp": 1634567890,
    "gas_used": 21000,
    "status": "success"
  },
  "analysis_timestamp": 1634567890,
  "agent_execution_time": 2.5,
  "swarm_coordination": {
    "agents_used": ["data_collector", "path_reconstructor", "risk_assessor"],
    "parallel_executions": 3,
    "total_execution_time": 2.5
  }
}
```

**Example Request:**
```bash
curl -X POST http://localhost:5000/api/trace \
  -H "Content-Type: application/json" \
  -d '{
    "transaction_hash": "0x1234567890abcdef1234567890abcdef12345678",
    "options": {
      "max_depth": 15,
      "include_chains": ["ethereum", "bsc"],
      "enable_swarm": true
    }
  }'
```

### 2. Compliance Reporting

#### POST /api/compliance-report

Generates a detailed compliance report based on trace results.

**Request Body:**
```json
{
  "trace_results": {
    "transaction_hash": "0x1234567890abcdef...",
    "risk_score": 75,
    "suspicious_activities": ["Mixer Usage"],
    "chains": ["Ethereum", "BSC"]
  },
  "report_options": {
    "format": "detailed",
    "include_recommendations": true,
    "regulatory_framework": "AML_CFT",
    "jurisdiction": "US"
  }
}
```

**Parameters:**
- `trace_results` (object, required): Results from a previous trace operation
- `report_options` (object, optional): Report configuration options
  - `format` (string): Report format ("summary", "detailed", "executive")
  - `include_recommendations` (boolean): Include recommended actions
  - `regulatory_framework` (string): Applicable regulatory framework
  - `jurisdiction` (string): Regulatory jurisdiction

**Response:**
```json
{
  "compliance_status": "REQUIRES INVESTIGATION",
  "status_color": "red",
  "risk_score": 75,
  "regulatory_flags": ["Mixer Usage", "High-Frequency Transfers"],
  "recommendations": [
    "File Suspicious Activity Report (SAR)",
    "Enhanced due diligence on involved parties",
    "Monitor related addresses for future activity"
  ],
  "regulatory_analysis": {
    "aml_compliance": "NON_COMPLIANT",
    "cft_compliance": "REQUIRES_REVIEW",
    "sanctions_check": "CLEAR",
    "pep_screening": "NO_MATCHES"
  },
  "generated_at": 1634567890,
  "report_id": "rpt_123456789",
  "validity_period": 2592000
}
```

### 3. Address Risk Assessment

#### POST /api/assess-address

Performs risk assessment on a specific blockchain address.

**Request Body:**
```json
{
  "address": "0x1234567890abcdef1234567890abcdef12345678",
  "chain": "ethereum",
  "assessment_type": "comprehensive"
}
```

**Response:**
```json
{
  "address": "0x1234567890abcdef1234567890abcdef12345678",
  "chain": "ethereum",
  "risk_score": 65,
  "risk_category": "MEDIUM",
  "risk_factors": [
    {
      "factor": "High transaction volume",
      "weight": 0.3,
      "score": 70
    },
    {
      "factor": "Mixer interaction detected",
      "weight": 0.4,
      "score": 85
    }
  ],
  "transaction_patterns": {
    "total_transactions": 1250,
    "average_amount": "15.5 ETH",
    "frequency_score": 75,
    "time_pattern_anomalies": 2
  },
  "reputation_data": {
    "blacklist_status": "CLEAR",
    "whitelist_status": "NOT_LISTED",
    "known_entity": false,
    "entity_type": null
  },
  "assessment_timestamp": 1634567890
}
```

### 4. Multi-Chain Analysis

#### POST /api/multi-chain-trace

Performs comprehensive analysis across multiple blockchain networks.

**Request Body:**
```json
{
  "starting_transaction": "0x1234567890abcdef...",
  "starting_chain": "ethereum",
  "target_chains": ["bsc", "polygon", "arbitrum"],
  "analysis_depth": 20
}
```

**Response:**
```json
{
  "analysis_id": "mca_123456789",
  "starting_point": {
    "transaction": "0x1234567890abcdef...",
    "chain": "ethereum"
  },
  "cross_chain_flows": [
    {
      "source_chain": "ethereum",
      "target_chain": "bsc",
      "bridge_used": "Binance Bridge",
      "amount_transferred": "50 ETH",
      "bridge_transaction": "0xabcd...efgh"
    }
  ],
  "chain_analysis": {
    "ethereum": {
      "transactions_analyzed": 15,
      "risk_score": 70,
      "suspicious_patterns": ["High frequency"]
    },
    "bsc": {
      "transactions_analyzed": 8,
      "risk_score": 85,
      "suspicious_patterns": ["Mixer usage"]
    }
  },
  "overall_risk_score": 78,
  "cross_chain_risk_factors": [
    "Multiple bridge usage",
    "Rapid chain hopping",
    "Amount fragmentation"
  ],
  "analysis_timestamp": 1634567890
}
```

### 5. Real-time Monitoring

#### POST /api/monitor/address

Sets up real-time monitoring for a specific address.

**Request Body:**
```json
{
  "address": "0x1234567890abcdef1234567890abcdef12345678",
  "chains": ["ethereum", "bsc"],
  "alert_thresholds": {
    "risk_score": 70,
    "transaction_amount": "100 ETH",
    "frequency": 10
  },
  "webhook_url": "https://your-app.com/webhook"
}
```

**Response:**
```json
{
  "monitor_id": "mon_123456789",
  "status": "ACTIVE",
  "address": "0x1234567890abcdef1234567890abcdef12345678",
  "chains": ["ethereum", "bsc"],
  "created_at": 1634567890,
  "expires_at": 1637159890
}
```

#### GET /api/monitor/{monitor_id}

Retrieves monitoring status and recent alerts.

**Response:**
```json
{
  "monitor_id": "mon_123456789",
  "status": "ACTIVE",
  "address": "0x1234567890abcdef1234567890abcdef12345678",
  "alerts_triggered": 3,
  "last_alert": 1634567890,
  "recent_activities": [
    {
      "timestamp": 1634567890,
      "transaction": "0xabcd...efgh",
      "risk_score": 75,
      "alert_reason": "High risk transaction detected"
    }
  ]
}
```

### 6. Historical Analysis

#### GET /api/history/traces

Retrieves historical trace analysis data.

**Query Parameters:**
- `start_date` (string): Start date (ISO 8601 format)
- `end_date` (string): End date (ISO 8601 format)
- `risk_threshold` (integer): Minimum risk score filter
- `chains` (array): Filter by blockchain networks
- `limit` (integer): Maximum number of results (default: 100)
- `offset` (integer): Pagination offset (default: 0)

**Response:**
```json
{
  "total_traces": 1250,
  "traces": [
    {
      "trace_id": "trc_123456789",
      "transaction_hash": "0x1234567890abcdef...",
      "risk_score": 85,
      "chains_involved": ["ethereum", "bsc"],
      "analysis_date": 1634567890,
      "status": "FLAGGED"
    }
  ],
  "pagination": {
    "limit": 100,
    "offset": 0,
    "total": 1250,
    "has_more": true
  }
}
```

### 7. Agent Status and Health

#### GET /api/health

Returns the current status of backend services and JuliaOS agents.

**Response:**
```json
{
  "status": "healthy",
  "service": "JuliaOS Transaction Trace Agent",
  "timestamp": 1634567890,
  "components": {
    "database": "healthy",
    "juliaos_agents": "healthy",
    "blockchain_connections": "healthy"
  },
  "agent_status": {
    "data_collector": {
      "status": "active",
      "last_execution": 1634567890,
      "success_rate": 0.98
    },
    "path_reconstructor": {
      "status": "active",
      "last_execution": 1634567885,
      "success_rate": 0.95
    },
    "risk_assessor": {
      "status": "active",
      "last_execution": 1634567880,
      "success_rate": 0.97
    }
  },
  "performance_metrics": {
    "average_response_time": 2.3,
    "requests_per_minute": 45,
    "error_rate": 0.02
  }
}
```

#### GET /api/agents/status

Detailed status information for all JuliaOS agents.

**Response:**
```json
{
  "agents": [
    {
      "agent_id": "blockchain_data_collector",
      "status": "ACTIVE",
      "last_execution": 1634567890,
      "execution_count": 1250,
      "success_rate": 0.98,
      "average_execution_time": 1.2,
      "current_load": 0.15,
      "capabilities": ["data_collection", "blockchain_query", "multi_chain"]
    },
    {
      "agent_id": "path_reconstructor",
      "status": "ACTIVE",
      "last_execution": 1634567885,
      "execution_count": 890,
      "success_rate": 0.95,
      "average_execution_time": 3.5,
      "current_load": 0.25,
      "capabilities": ["graph_analysis", "path_finding", "pattern_recognition"]
    }
  ],
  "swarm_status": {
    "active_swarms": 2,
    "total_agents_in_swarms": 8,
    "coordination_efficiency": 0.92
  }
}
```

### 8. Configuration and Settings

#### GET /api/config

Retrieves current system configuration.

**Response:**
```json
{
  "supported_chains": [
    {
      "chain_id": "ethereum",
      "name": "Ethereum",
      "rpc_endpoint": "https://eth-mainnet.alchemyapi.io/v2/...",
      "block_explorer": "https://etherscan.io",
      "status": "active"
    }
  ],
  "analysis_settings": {
    "default_max_depth": 10,
    "default_risk_threshold": 50,
    "swarm_enabled": true,
    "cache_ttl": 3600
  },
  "compliance_frameworks": [
    "AML_CFT",
    "FATF",
    "BSA",
    "EU_AMLD"
  ]
}
```

#### POST /api/config/update

Updates system configuration (admin only).

**Request Body:**
```json
{
  "analysis_settings": {
    "default_max_depth": 15,
    "default_risk_threshold": 60
  }
}
```

## WebSocket API

For real-time updates and streaming analysis results:

### Connection

```javascript
const ws = new WebSocket('ws://localhost:5000/ws');
```

### Message Format

```json
{
  "type": "trace_update",
  "data": {
    "trace_id": "trc_123456789",
    "status": "in_progress",
    "progress": 0.65,
    "current_step": "risk_assessment",
    "partial_results": {...}
  }
}
```

### Subscription Types

- `trace_updates` - Real-time trace progress
- `risk_alerts` - High-risk transaction alerts
- `agent_status` - Agent health and performance updates

## SDK and Client Libraries

### Python SDK

```python
from trace_dapp_sdk import TraceDAppClient

client = TraceDAppClient(api_key="your_api_key")

# Perform transaction trace
result = client.trace_transaction("0x1234567890abcdef...")

# Generate compliance report
report = client.generate_compliance_report(result)
```

### JavaScript SDK

```javascript
import { TraceDAppClient } from 'trace-dapp-sdk';

const client = new TraceDAppClient({ apiKey: 'your_api_key' });

// Perform transaction trace
const result = await client.traceTransaction('0x1234567890abcdef...');

// Generate compliance report
const report = await client.generateComplianceReport(result);
```

## Examples and Use Cases

### Basic Transaction Trace

```bash
curl -X POST http://localhost:5000/api/trace \
  -H "Content-Type: application/json" \
  -d '{
    "transaction_hash": "0x1234567890abcdef1234567890abcdef12345678"
  }'
```

### Advanced Multi-Chain Analysis

```bash
curl -X POST http://localhost:5000/api/multi-chain-trace \
  -H "Content-Type: application/json" \
  -d '{
    "starting_transaction": "0x1234567890abcdef1234567890abcdef12345678",
    "starting_chain": "ethereum",
    "target_chains": ["bsc", "polygon"],
    "analysis_depth": 20
  }'
```

### Real-time Monitoring Setup

```bash
curl -X POST http://localhost:5000/api/monitor/address \
  -H "Content-Type: application/json" \
  -d '{
    "address": "0x1234567890abcdef1234567890abcdef12345678",
    "chains": ["ethereum", "bsc"],
    "alert_thresholds": {
      "risk_score": 70
    },
    "webhook_url": "https://your-app.com/webhook"
  }'
```

This comprehensive API documentation provides all the necessary information for integrating with the On-Chain Transaction Trace & Compliance Agent dApp, enabling developers to build powerful blockchain analysis applications using JuliaOS agent capabilities.

