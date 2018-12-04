defmodule Canvas do

  @defaults [ fg: "black", bg: "white", font: "Merriweather" ]

  def draw_text(text, options \\ []) do
    options = Keyword.merge(@defaults, options)
    IO.puts "Drawing text #{inspect(text)}"
    IO.puts "Foreground:  #{options[:fg]}"
    IO.puts "Background:  #{options[:bg]}"
    IO.puts "Font:        #{options[:font]}"
    IO.puts "Pattern:     #{Keyword.get(options, :pattern, "solid")}"
    IO.puts "Style:       #{inspect Keyword.get_values(options, :style)}"
  end

  def options(text, options \\ []) do
    options = Keyword.merge(@defaults, options)
    Keyword.merge([text: text], options)
  end

end
