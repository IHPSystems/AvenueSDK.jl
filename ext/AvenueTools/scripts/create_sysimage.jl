using Dates
using PackageCompiler
using Pkg

Pkg.instantiate()
p = Pkg.project()
platform = Sys.MACHINE
timestamp = Dates.format(now(UTC), "yyyymmdd")
dlext = "so"
sysimage_path = joinpath("build", "$(p.name).v$(p.version).julia-$VERSION.$platform.$timestamp.$dlext")
cpu_target = PackageCompiler.default_app_cpu_target()
@info "Creating sysimage for CPU target \"$cpu_target\" @ $sysimage_path"
create_sysimage(;
    cpu_target,
    precompile_execution_file = joinpath("scripts", "precompile_session.jl"),
    sysimage_path)
