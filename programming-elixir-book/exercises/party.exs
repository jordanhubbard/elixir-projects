defmodule PartyGoer do                                
  defstruct name: "", paid: false, over_18: true

  def may_attend_party(person = %PartyGoer{}) do
    person.paid && person.over_18
  end

  def print_badge(person = %PartyGoer{}) do
    if person.name != "" do
      IO.puts("Badge for #{person.name} printing")
    end
  end

end
