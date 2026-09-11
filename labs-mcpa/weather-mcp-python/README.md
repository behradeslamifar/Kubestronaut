# 
## Setup environment
install uv
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
uv init weather-mcp-python
cd weather-mcp-python
uv venv
source .venv/bin/activate
uv add "mcp[cli]"
```



