![Part 1 - C++](./workflows/Part%201%20-%20C++/badge.svg) ![Part 2 - C++](./workflows/Part%202%20-%20C++/badge.svg) ![Part 1 - C#](./workflows/Part%201%20-%20C%23/badge.svg) ![Part 2 - C#](./workflows/Part%202%20-%20C%23/badge.svg) ![Part 1 - F#](./workflows/Part%201%20-%20F%23/badge.svg) ![Part 2 - F#](./workflows/Part%202%20-%20F%23/badge.svg) ![Part 1 - Go](./workflows/Part%201%20-%20Go/badge.svg) ![Part 2 - Go](./workflows/Part%202%20-%20Go/badge.svg) ![Part 1 - Rust](./workflows/Part%201%20-%20Rust/badge.svg) ![Part 2 - Rust](./workflows/Part%202%20-%20Rust/badge.svg) ![Part 1 - Swift](./workflows/Part%201%20-%20Swift/badge.svg) ![Part 2 - Swift](./workflows/Part%202%20-%20Swift/badge.svg) ![Part 1 - Java](./workflows/Part%201%20-%20Java/badge.svg) ![Part 2 - Java](./workflows/Part%202%20-%20Java/badge.svg) ![Part 1 - Python](./workflows/Part%201%20-%20Python/badge.svg) ![Part 2 - Python](./workflows/Part%202%20-%20Python/badge.svg) ![Part 1 - Cython](./workflows/Part%201%20-%20Cython/badge.svg) ![Part 2 - Cython](./workflows/Part%202%20-%20Cython/badge.svg) ![Part 1 - C](./workflows/Part%201%20-%20C/badge.svg) ![Part 2 - C](./workflows/Part%202%20-%20C/badge.svg) ![Part 1 - TypeScript](./workflows/Part%201%20-%20TypeScript/badge.svg) ![Part 2 - TypeScript](./workflows/Part%202%20-%20TypeScript/badge.svg) ![Benchmark](./workflows/Benchmark/badge.svg) 

# What is this?

Exchange is a playground to experiment with and compare programming languages by solving a simple problem in your language of choice and then seeing how fast you can make it run.

The problem is broken into two parts, for [Part 1](./tree/master/Part%201) the goal is to solve the basic problem using idiomatic, expressive, readable code without too much though given to performance. For [Part 2](./tree/master/Part%202) all bets are off and the goal is to make it run as fast as possible.

# Benchmarks

The solutions are benchmarked by taking the build artifacts for each language and running them 5 times over the supplied input files. The median runtime is recorded. All solutions are run on the same container instance sequentially, the results will vary depending on what resources the particular machine has at run time and will typcially be noticably slower than the results you will see on modern desktop hardware.

Some solutions are excluded from the benchmarks entirely because they take too long to run even once. Others are exluded from the benchmark with the larger file because they take too long for that particular input.

## Part 1 Performance


||100K orders|trades|
-|:-:|:-:|
|Java|0:00:00.473180|3368|
|C#|0:00:00.520484|3368|
|TypeScript|0:00:00.593299|3368|
|F#|0:00:03.904699|3368|
|Swift|0:00:04.812031|3368|
|C|0:00:09.354685|3368|
|Rust|0:00:11.366810|3368|
|C++|0:00:20.061589|3368|
|Go|0:00:27.946255|3368|
|Cython|0:01:14.211674|3368|
|Python|0:01:23.159517|3368|


## Part 2 Performance

The slower implementations are excluded from the larger benchmark just so it runs in a reasonable time.

||100K orders|trades|
-|:-:|:-:|
|C|0:00:00.023358|3368|
|Rust|0:00:00.034527|3368|
|C++|0:00:00.037863|3368|
|Go|0:00:00.041796|3368|
|Swift|0:00:00.052423|3368|
|Cython|0:00:00.078927|3368|
|C#|0:00:00.156069|3368|
|Java|0:00:00.221662|3368|
|Python|0:00:00.269723|3368|
|TypeScript|0:00:00.367010|3368|
|F#|0:00:00.376693|3368|


||10M orders|trades|
-|:-:|:-:|
|C|0:00:02.065670|360131|
|C++|0:00:03.285438|360131|
|Rust|0:00:03.433562|360131|
|Swift|0:00:04.411550|360131|
|Go|0:00:04.481692|360131|
|Java|0:00:04.679305|360131|
|Cython|0:00:06.719958|360131|
|C#|0:00:09.210680|360131|
|TypeScript|0:00:17.665262|360131|
|F#|0:00:18.931549|360131|


