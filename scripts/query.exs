require IEx

query= "https://query.wikidata.org/sparql?format=json&query=SELECT%20?item%20?itemLabel%20?location%20?startTime%20?endTime%20WHERE%20%7B%20%0A%20%20?item%20(wdt:P31/wdt:P279*)%20wd:Q178561%20.%0A%20%20?item%20wdt:P625%20?location%20.%0A%20%20?item%20wdt:P580%20?startTime%20.%0A%20%20?item%20wdt:P582%20?endTime%20.%0A%20%20SERVICE%20wikibase:label%20%7B%20bd:serviceParam%20wikibase:language%20%22en%22%20%7D%20.%0A%7D"

response = HTTPotion.get(query)
parsed_response = Poison.decode!(response.body)

fields = parsed_response["head"]["vars"]

Enum.each(parsed_response["results"]["bindings"], fn battle ->
  name = battle["itemLabel"]["value"]

  start_date = case DateTime.from_iso8601(battle["startTime"]["value"]) do
    {:ok, date_time, _} -> DateTime.to_date(date_time)
    {:error, _} -> 'Unknown'
  end

  end_date = case DateTime.from_iso8601(battle["endTime"]["value"]) do
    {:ok, date_time, _} -> DateTime.to_date(date_time)
    {:error, _} -> 'Unknown'
  end

  location_in_wkt =  String.upcase(battle["location"]["value"])
  location = Geo.WKT.decode("SRID=4326;" <> location_in_wkt)

  attributes = %{end_date: end_date, location: location, name: name, start_date: start_date}
  case Battlemap.Main.create_battle(attributes) do
    {:ok, battle} -> IO.puts("Created #{battle.name}")
    {:error, _} -> IO.puts("Error")
  end
end)
