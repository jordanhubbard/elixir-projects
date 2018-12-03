defmodule KVCacheTest do
  use ExUnit.Case
  doctest KVCache

  test "set a value successfully" do
    assert KVCache.set(:testKey, "hi there") == "hi there"
  end

  test "get a value successfully" do
    KVCache.set(:testKey, "hi there")
    assert KVCache.get(:testKey) == "hi there"
  end

  test "unknown value returns nil" do
    assert KVCache.get(:nonsenseValue) == nil
  end
  
end
