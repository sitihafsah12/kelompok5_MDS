## Create data model
library(datamodelr)
file_path <- "C:/Users/LENOVO/Downloads/yaml-erd.yaml"
dm <- dm_read_yaml(file_path)
dm

## Create a graph object to plot the model
library(dm)
library(DiagrammeR)

graph <- dm_create_graph(dm,rankdir = "BT", col_attr = c("column", "type"),
                         view_type = "keys-only" )

dm_render_graph(graph)


