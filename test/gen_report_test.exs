defmodule GenReportTest do
  use ExUnit.Case

  alias GenReport
  alias GenReport.Support.ReportFixture

  @file_name "gen_report.csv"

  describe "build/1" do
    test "When passing file name return a report" do
      response = GenReport.build(@file_name)

      assert response == ReportFixture.build()
    end

    test "When no filename was given, returns an error" do
      response = GenReport.build()

      assert response == {:error, "Insira o nome de um arquivo"}
    end
  end

  describe "build_from_many/1" do
    test "when a file list is provided, builds the report" do
      filenames = ["part_1.csv", "part_2.csv", "part_3.csv"]

      response = GenReport.build_from_many(filenames)

      assert response == {:ok, ReportFixture.build()}
    end

    test "when a file list is not provided, returns an error" do
      response = GenReport.build_from_many("capivara.txt")

      expected_response = {:error, "Insira uma lista de arquivos"}

      assert response == expected_response
    end
  end
end
