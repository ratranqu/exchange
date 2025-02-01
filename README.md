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
|C#|0:00:00.519391|3368|
|Java|0:00:00.532581|3368|
|TypeScript|0:00:00.608685|3368|
|F#|0:00:04.029098|3368|
|Swift|0:00:05.082115|3368|
|C|0:00:09.348072|3368|
|Rust|0:00:11.350367|3368|
|C++|0:00:19.708054|3368|
|Go|0:00:28.076363|3368|
|Cython|0:01:15.393903|3368|
|Python|0:01:32.311464|3368|


## Part 2 Performance

The slower implementations are excluded from the larger benchmark just so it runs in a reasonable time.

||100K orders|trades|
-|:-:|:-:|
|C|0:00:00.023484|3368|
|Rust|0:00:00.035012|3368|
|C++|0:00:00.037362|3368|
|Go|0:00:00.041028|3368|
|Swift|0:00:00.052100|3368|
|Cython|0:00:00.080388|3368|
|C#|0:00:00.160998|3368|
|Java|0:00:00.221372|3368|
|Python|0:00:00.287874|3368|
|TypeScript|0:00:00.366965|3368|
|F#|0:00:00.382884|3368|


||10M orders|trades|
-|:-:|:-:|
|C|0:00:02.094944|360131|
|C++|0:00:03.284573|360131|
|Rust|0:00:03.462462|360131|
|Swift|0:00:04.182993|360131|
|Go|0:00:04.536207|360131|
|Java|0:00:04.896979|360131|
|Cython|0:00:06.678528|360131|
|C#|0:00:09.277902|360131|
|TypeScript|0:00:17.564790|360131|
|F#|0:00:19.289556|360131|


