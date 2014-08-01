--#class "example"
--#description "Runs a VI and opens its panel"
vi = VI.open("Count Down.vi")
vi:run(true) -- pass the VI its reference. No need to close the VI object.
vi:open_fp()
