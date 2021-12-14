defmodule Cash.PurchaseFactory do
  defmacro __using__(_opts) do
    quote do
      def purchase_factory do
        %Cash.Acquire.Purchase{
          user_cpf: "some cpf",
          price: Enum.random(1..1000),
          purchase_code: Enum.random(1..10),
          rule: build(:rule)
        }
      end
    end
  end
end
