defmodule Prefix do
  def prefix(p) do
    fn(last) -> "#{p} #{last}" end
  end
end
