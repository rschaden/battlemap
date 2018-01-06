# Battlemap

This will eventually provide a visualization of battles on an OpenStreetMap.
The topic was chosen because it combines my interests in history, geography
and spatial databases. It was inspired by a similar project by Nodegoat:
[Battles](https://gizmodo.com/this-shocking-map-of-battles-throughout-history-isnt-ev-1761574415)

### Planned technologies
* Programming language: [Elixir](https://elixir-lang.org/)
* Web framework: [Phoenix](http://phoenixframework.org)
* Database: [PostgreSQL](https://www.postgresql.org) with the [Postgis extension](https://postgis.net)
* Infrastructure: [AWS](https://aws.amazon.com/)

### Data sources
* [Wikidata](https://www.wikidata.org/wiki/Wikidata:Main_Page)
* [DBPedia](http://wiki.dbpedia.org)

### Planned features
* Visualization of data on a map (duh!)
* Querying of Wikipedia data
* Various filters on the map:
  * Time range
  * Conflict (i.e. show only battles of WWII)
  * Belligerents
  * Number of Participants
  * Number of Casualties
