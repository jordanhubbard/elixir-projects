defmodule Customer do
  defstruct name: "", company: ""
end

defmodule BugReport do
  defstruct owner: %Customer{}, details: "", severity: 1
end

defmodule User do
  report = %BugReport{owner: %Customer{name: "Dave", company: "Pragmatic"},
                      details: "broken"}

  IO.inspect report

  report = %BugReport{ report | owner: %Customer{ report.owner | company: "PragProg" }}

  IO.inspect report

  IO.inspect update_in(report.owner.name, &("Mr. " <> &1))
end
