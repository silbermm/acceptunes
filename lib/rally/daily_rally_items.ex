defmodule Acceptunes.DailyRallyItems do

  @rally_api Application.get_env(:acceptunes, :rally_api)
  @timezone Application.get_env(:acceptunes, :current_timezone) 

  def today do
    datetime = Timex.now(@timezone) 
                |> Timex.beginning_of_day
                |> Timex.format!("{ISO:Extended:Z}")
  end

  def format(response) do
    case response do
      {:ok, response} -> 
        object_ids = Enum.map(response.body["Results"], fn(obj) ->
          obj["ObjectID"]
        end)
        %Acceptunes.RallyResult{
          status_code: response.status_code,
          total_results: response.body["TotalResultCount"],
          object_ids: object_ids
        }
      {:error, err} -> %Acceptunes.RallyResult{}
    end
  end

  def get(projectId) do
    @rally_api.query(:get, projectId, today) |> format
  end

end