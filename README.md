# Cutting-plane
Implementation of Kelley's convex cutting-plane and supporting hyperplane algorithms for the following examples in MATLAB:

Example 1:

$$
\begin{aligned}
\min \quad & -x_1 - 2x_2 \\
\text{s.t.} \quad & x_1^6 - 2x_1 - x_2 \leq 0 \\
& -x_1 + x_2 - 2 \leq 0 \\
\\
& S \subset P_k : 
\begin{cases}
x_1 \leq 3 \\
-x_1 \leq 2 \\
x_2 \leq 5 \\
-x_2 \leq 2
\end{cases} \\
\\
& y = (0,1)
\end{aligned}
$$

Example 2:

$$
\begin{aligned}
\min \quad & x_1 - x_2 \\
\text{s.t.} \quad & x_1^2 - x_2 \leq 0 \\
& 0.5x_1 + x_2 - 1 \leq 0 \\
\\
& S \subset P_k : 
\begin{cases}
x_1 \leq 3 \\
-x_1 \leq 2 \\
x_2 \leq 5 \\
-x_2 \leq 2
\end{cases} \\
\\
& y = (0,1)
\end{aligned}
$$

Example 3:

$$
\begin{aligned}
\min \quad & x_1 - 2x_2 \\
\text{s.t.} \quad & 2^{(-x_1)} - x_2 - 1 \leq 0 \\
& 2x_1 + x_2 - 10 \leq 0 \\
\\
& S \subseteq P_k : 
\begin{cases}
x_1 \leq 10 \\
-x_1 \leq 15 \\
x_2 \leq 30 \\
-x_2 \leq 15
\end{cases} \\
\\
& y = (1,1)
\end{aligned}
$$
