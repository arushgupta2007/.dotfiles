{ pkgs, ... }: 
{
  services.ollama = {
    enable = true;
    # Optional: load models on startup
    # loadModels = [ "gemma2:9b" "qwen2.5-coder:7b" ];
  };
}

