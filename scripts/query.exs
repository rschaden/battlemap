require IEx

query= "https://query.wikidata.org/sparql?format=json&query=SELECT%20?item%20?itemLabel%20?location%20?startTime%20?endTime%20WHERE%20%7B%20%0A%20%20?item%20(wdt:P31/wdt:P279*)%20wd:Q178561%20.%0A%20%20?item%20%20wdt:P361%20wd:Q33143%20.%0A%20%20?item%20wdt:P625%20?location%20.%0A%20%20?item%20wdt:P580%20?startTime%20.%0A%20%20?item%20wdt:P582%20?endTime%20.%0A%20%20SERVICE%20wikibase:label%20%7B%20bd:serviceParam%20wikibase:language%20%22en%22%20%7D%20.%0A%7D%0ALIMIT%2010"

response = HTTPotion.get(query)
parsed_response = Poison.decode!(response.body)

fields = parsed_response["head"]["vars"]

Enum.each(parsed_response["results"]["bindings"], fn battle -> Enum.each(fields, fn field -> IO.puts battle[field]["value"] end) end)
