defmodule KVCache.Cache.Application do
  use Application
  
  def start(_type, _args) do
    KVCache.Cache.start_link()
  end
  
end
