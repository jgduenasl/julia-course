# set heading for julia scripts
#

using ArgParse, YAML, CSV, Arrow, DataFrames

# TODO: relative paths may be stored using projects or DrWatson
# https://juliadynamics.github.io/DrWatson.jl/stable/project/#Activating-a-Project-1

root = dirname(@__FILE__)
path = "github/julia-course/import/input/SB11_20211.txt"
inputpath = joinpath(root, "import", "input", "SB11_20211.txt")
outputpath = joinpath(root, "import", "output", "sb11-20211.parquet")
statspath = joinpath(root, "import", "output", "stats.yml")

parser = ArgParseSettings()
@add_arg_table parser begin
    "--input"
        help = "file path of data to be imported"
        arg_type = String
        default = inputpath
        required = true
    "--output"
        help = "file path of imported data"
        arg_type = String
        default = outpath
        required = true
    "--stats"
        help = "basic stats of the imported file"
        arg_type = String
        default = statspath
end
args = ArgParse.parse_args(ARGS, parser)

data = read(args.input, delim="¬", DataFrame)
# TODO: use clean_names like R's janitor function to standardize colnames
# see https://github.com/xiaodaigh/DataConvenience.jl or 
# https://github.com/TheRoniOne/Cleaner.jl

stats = Dict(:nrows => nrow(data),
             :ncols => ncol(data))

write_parquet(args.output, data)
YAML.write_file(args.stats, stats)
#done
