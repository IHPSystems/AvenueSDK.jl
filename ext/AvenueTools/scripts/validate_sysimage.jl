using Pkg

Pkg.instantiate()

script = joinpath("scripts", "precompile_session.jl")

timing_script = """
@time include(\"$(escape_string(script))\")
"""

@info "Timing $script ..."
elapsed = @elapsed run(`julia --project --eval $timing_script`)
@info "Julia session took $elapsed seconds"

sys_images = filter(contains("julia-$VERSION"), readdir("build"))
if isempty(sys_images)
    error("No sysimage found for julia version $VERSION")
end
sys_image = joinpath("build", first(sys_images))

@info "Timing $script using sysimage $sys_image..."
elapsed = @elapsed run(`julia --sysimage $sys_image --project --eval $timing_script`)
@info "Julia session took $elapsed seconds"
