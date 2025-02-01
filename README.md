![Part 1 - C++](./workflows/Part%201%20-%20C++/badge.svg) ![Part 2 - C++](./workflows/Part%202%20-%20C++/badge.svg) ![Part 1 - C#](./workflows/Part%201%20-%20C%23/badge.svg) ![Part 2 - C#](./workflows/Part%202%20-%20C%23/badge.svg) ![Part 1 - F#](./workflows/Part%201%20-%20F%23/badge.svg) ![Part 2 - F#](./workflows/Part%202%20-%20F%23/badge.svg) ![Part 1 - Go](./workflows/Part%201%20-%20Go/badge.svg) ![Part 2 - Go](./workflows/Part%202%20-%20Go/badge.svg) ![Part 1 - Rust](./workflows/Part%201%20-%20Rust/badge.svg) ![Part 2 - Rust](./workflows/Part%202%20-%20Rust/badge.svg) ![Part 1 - Swift](./workflows/Part%201%20-%20Swift/badge.svg) ![Part 2 - Swift](./workflows/Part%202%20-%20Swift/badge.svg) ![Part 1 - Java](./workflows/Part%201%20-%20Java/badge.svg) ![Part 2 - Java](./workflows/Part%202%20-%20Java/badge.svg) ![Part 1 - Python](./workflows/Part%201%20-%20Python/badge.svg) ![Part 2 - Python](./workflows/Part%202%20-%20Python/badge.svg) ![Part 1 - Cython](./workflows/Part%201%20-%20Cython/badge.svg) ![Part 2 - Cython](./workflows/Part%202%20-%20Cython/badge.svg) ![Part 1 - C](./workflows/Part%201%20-%20C/badge.svg) ![Part 2 - C](./workflows/Part%202%20-%20C/badge.svg) ![Part 1 - TypeScript](./workflows/Part%201%20-%20TypeScript/badge.svg) ![Part 2 - TypeScript](./workflows/Part%202%20-%20TypeScript/badge.svg) ![Benchmark](./workflows/Benchmark/badge.svg) 

# What is this?

Exchange is a playground to experiment with and compare programming languages by solving a simple problem in your language of choice and then seeing how fast you can make it run.

The problem is broken into two parts, for [Part 1](./tree/master/Part%201) the goal is to solve the basic problem using idiomatic, expressive, readable code without too much though given to performance. For [Part 2](./tree/master/Part%202) all bets are off and the goal is to make it run as fast as possible.

# Benchmarks

The solutions are benchmarked by taking the build artifacts for each language and running them 5 times over the supplied input files. The median runtime is recorded. All solutions are run on the same container instance sequentially, the results will vary depending on what resources the particular machine has at run time and will typcially be noticably slower than the results you will see on modern desktop hardware.

Some solutions are excluded from the benchmarks entirely because they take too long to run even once. Others are exluded from the benchmark with the larger file because they take too long for that particular input.

## Part 1 Performance


||100K orders|% over fastest|trades|
-|:-:|:-:|:-:|
|Java|0:00:00.481894|0|3368|
|C#|0:00:00.492559|2|3368|
|TypeScript|0:00:00.566048|17|3368|
|F#|0:00:03.728738|674|3368|
|Swift|0:00:05.237504|987|3368|
|C|0:00:08.759264|1718|3368|
|Rust|0:00:10.681385|2117|3368|
|C++|0:00:18.129094|3662|3368|
|Go|0:00:26.349129|5368|3368|
|Cython|0:01:03.805234|13141|3368|
|Python|0:01:17.199432|15920|3368|


## Part 2 Performance

The slower implementations are excluded from the larger benchmark just so it runs in a reasonable time.

||100K orders|% over fastest|trades|
-|:-:|:-:|:-:|
|C|0:00:00.021770|0|3368|
|Rust|0:00:00.033667|55|3368|
|C++|0:00:00.034617|59|3368|
|Go|0:00:00.038325|76|3368|
|Swift|0:00:00.049175|126|3368|
|Cython|0:00:00.074777|243|3368|
|C#|0:00:00.151266|595|3368|
|Java|0:00:00.219987|911|3368|
|Python|0:00:00.256417|1078|3368|
|TypeScript|0:00:00.346002|1489|3368|
|F#|0:00:00.376944|1631|3368|


||10M orders|% over fastest|trades|
-|:-:|:-:|:-:|
|C|0:00:01.966644|0|360131|
|C++|0:00:03.045945|55|360131|
|Rust|0:00:03.287752|67|360131|
|Swift|0:00:03.921306|99|360131|
|Go|0:00:04.375357|122|360131|


