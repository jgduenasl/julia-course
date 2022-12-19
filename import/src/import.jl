# set heading for julia scripts
#

using CSV, DataFrames

path = "github/julia-course/import/input/SB11_20211.txt"
data = CSV.read(path, delim="¬", DataFrame)


