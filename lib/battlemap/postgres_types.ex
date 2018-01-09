Postgrex.Types.define(Battlemap.PostgresTypes,
                      [Geo.PostGIS.Extension] ++ Ecto.Adapters.Postgres.extensions(),
                      json: Poison)
