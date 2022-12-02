using DataFrames, DataFramesMeta, CSV

df = CSV.File("2/data.csv") |> DataFrame

df = @combine(groupby(df, :dir), :value = sum(:value))


d = Dict(eachrow(df))

horizontal = d["forward"]
vertical = d["down"] - d["up"]
horizontal * vertical