function testfunction(A)
    s = svdvals(A)
    U, S, V = svd(A)
    λ = eigvals(A)
    p1 = heatmap(-A)
    p2 = heatmap(U'U)
    p3 = heatmap(V'V)
    p4 = plot(s, m = :circle)

    plot(p1, p2, p3, p4)
end
