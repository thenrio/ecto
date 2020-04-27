Code.require_file("../../../integration_test/support/types.exs", __DIR__)

defmodule Ecto.Query.SubqueryTest do
  use ExUnit.Case, async: true

  import Ecto.Query

  defmodule Comment do
    use Ecto.Schema

    schema "comments" do
      field :text, :string
    end
  end

  test "too many expressions" do
    assert_raise Ecto.QueryError, ~r/^incorrect/, fn ->
      q = from(c in Comment)
      from(c in Comment, where: c.id in subquery(q))
    end
  end
end
