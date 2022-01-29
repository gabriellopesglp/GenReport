defmodule GenReport.Parser do
  def parse_file(filename) do
    filename
    |> File.stream!()
    |> Stream.map(fn line -> parse_line(line) end)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(0, &String.downcase/1)
    |> List.update_at(1, &String.to_integer/1)
    |> List.update_at(2, &String.to_integer/1)
    |> List.update_at(3, &String.to_integer/1)
    |> List.update_at(3, &convert_data/1)
    |> List.update_at(4, &String.to_integer/1)
  end

  defp convert_data(1), do: "janeiro"
  defp convert_data(2), do: "fevereiro"
  defp convert_data(3), do: "março"
  defp convert_data(4), do: "abril"
  defp convert_data(5), do: "maio"
  defp convert_data(6), do: "junho"
  defp convert_data(7), do: "julho"
  defp convert_data(8), do: "agosto"
  defp convert_data(9), do: "setembro"
  defp convert_data(10), do: "outubro"
  defp convert_data(11), do: "novembro"
  defp convert_data(12), do: "dezembro"
end
