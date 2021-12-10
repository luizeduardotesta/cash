defmodule Cash.RuleFactory do
  defmacro __using__(_opts) do
    quote do
      def rule_factory do
        %Cash.Dominion.Rule{
          description: "some description",
          bonus: Enum.random(1..25)
        }
      end
    end
  end
end
