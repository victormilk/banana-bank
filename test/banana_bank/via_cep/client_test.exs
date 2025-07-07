defmodule BananaBank.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias BananaBank.ViaCep.Client

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/1" do
    test "successfully returns cep info", %{bypass: bypass} do
      cep = "01001000"

      body = ~s({
        "bairro": "Sé",
        "cep": "01001-000",
        "complemento": "lado ímpar",
        "ddd": "11",
        "estado": "São Paulo",
        "gia": "1004",
        "ibge": "3550308",
        "localidade": "São Paulo",
        "logradouro": "Praça da Sé",
        "regiao": "Sudeste",
        "siafi": "7107",
        "uf": "SP",
        "unidade": ""
    })

      expected_response =
        {:ok,
         %{
           "bairro" => "Sé",
           "cep" => "01001-000",
           "complemento" => "lado ímpar",
           "ddd" => "11",
           "estado" => "São Paulo",
           "gia" => "1004",
           "ibge" => "3550308",
           "localidade" => "São Paulo",
           "logradouro" => "Praça da Sé",
           "regiao" => "Sudeste",
           "siafi" => "7107",
           "uf" => "SP",
           "unidade" => ""
         }}

      Bypass.expect_once(bypass, "GET", "/01001000/json", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(:ok, body)
      end)

      response =
        bypass.port
        |> endpoint_url()
        |> Client.call(cep)

      assert response == expected_response
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}"
end
