defmodule Cash.UserFactory do
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %Cash.Accounts.User{
          cpf: "123.456.789-00",
          email: Faker.Internet.email(),
          name: Faker.Person.PtBr.name(),
          password: "123456"
        }
      end
    end
  end
end
