using MIT18065
using Plots
A = rand(3, 3)

s = svdvals(A)

U, S, V = svd(A)

λ = eigvals(A)

p1 = heatmap(-A)
p2 = heatmap(U'U)
p3 = heatmap(V'V)

p4 = plot(s)
pλ = plot!(p4, real.(λ), imag.(λ), m = :rect)

plot(p1, p2, p3, pλ)
