defmodule GenReport do
  alias GenReport.Parser

  @available_names [
    "cleiton",
    "daniele",
    "danilo",
    "diego",
    "giuliano",
    "jakeliny",
    "joseph",
    "mayk",
    "rafael",
    "vinicius"
  ]

  @available_months [
    "janeiro",
    "fevereiro",
    "março",
    "abril",
    "maio",
    "junho",
    "julho",
    "agosto",
    "setembro",
    "outubro",
    "novembro",
    "dezembro"
  ]

  @available_year [
    2016,
    2017,
    2018,
    2019,
    2020
  ]

  def build(), do: {:error, "Insira o nome de um arquivo"}

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report -> sum_values(line, report) end)
  end

  defp sum_values([name, quantity_hours, _day, month, year], %{
         "all_hours" => all_hours,
         "hours_per_month" => hours_per_month,
         "hours_per_year" => hours_per_year
       }) do
    all_hours = Map.put(all_hours, name, all_hours[name] + quantity_hours)

    hours_per_month =
      put_in(hours_per_month[name][month], hours_per_month[name][month] + quantity_hours)

    hours_per_year =
      put_in(hours_per_year[name][year], hours_per_year[name][year] + quantity_hours)

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp report_acc do
    all_hours = Enum.into(@available_names, %{}, &{&1, 0})

    available_hours_month = Enum.into(@available_months, %{}, &{&1, 0})

    available_hours_year = Enum.into(@available_year, %{}, &{&1, 0})

    hours_per_month = Enum.into(@available_names, %{}, &{&1, available_hours_month})

    hours_per_year = Enum.into(@available_names, %{}, &{&1, available_hours_year})

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  defp build_report(all_hours, hours_per_month, hours_per_year) do
    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end
end
