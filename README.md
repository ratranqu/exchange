![Part 1 - C++](https://github.com/GaryHughes/Exchange/workflows/Part%201%20-%20C++/badge.svg) ![Part 2 - C++](https://github.com/GaryHughes/Exchange/workflows/Part%202%20-%20C++/badge.svg) ![Part 1 - C#](https://github.com/GaryHughes/Exchange/workflows/Part%201%20-%20C%23/badge.svg) ![Part 2 - C#](https://github.com/GaryHughes/Exchange/workflows/Part%202%20-%20C%23/badge.svg) ![Part 1 - F#](https://github.com/GaryHughes/Exchange/workflows/Part%201%20-%20F%23/badge.svg) ![Part 2 - F#](https://github.com/GaryHughes/Exchange/workflows/Part%202%20-%20F%23/badge.svg) ![Part 1 - Go](https://github.com/GaryHughes/Exchange/workflows/Part%201%20-%20Go/badge.svg) ![Part 2 - Go](https://github.com/GaryHughes/Exchange/workflows/Part%202%20-%20Go/badge.svg) ![Part 1 - Rust](https://github.com/GaryHughes/Exchange/workflows/Part%201%20-%20Rust/badge.svg) ![Part 2 - Rust](https://github.com/GaryHughes/Exchange/workflows/Part%202%20-%20Rust/badge.svg) ![Part 1 - Swift](https://github.com/GaryHughes/Exchange/workflows/Part%201%20-%20Swift/badge.svg) ![Part 2 - Swift](https://github.com/GaryHughes/Exchange/workflows/Part%202%20-%20Swift/badge.svg) ![Part 1 - Java](https://github.com/GaryHughes/Exchange/workflows/Part%201%20-%20Java/badge.svg) ![Part 2 - Java](https://github.com/GaryHughes/Exchange/workflows/Part%202%20-%20Java/badge.svg) ![Part 1 - Python](https://github.com/GaryHughes/Exchange/workflows/Part%201%20-%20Python/badge.svg) ![Part 2 - Python](https://github.com/GaryHughes/Exchange/workflows/Part%202%20-%20Python/badge.svg) ![Part 1 - Cython](https://github.com/GaryHughes/Exchange/workflows/Part%201%20-%20Cython/badge.svg) ![Part 2 - Cython](https://github.com/GaryHughes/Exchange/workflows/Part%202%20-%20Cython/badge.svg) ![Part 1 - C](https://github.com/GaryHughes/Exchange/workflows/Part%201%20-%20C/badge.svg) ![Part 2 - C](https://github.com/GaryHughes/Exchange/workflows/Part%202%20-%20C/badge.svg) ![Part 1 - TypeScript](https://github.com/GaryHughes/Exchange/workflows/Part%201%20-%20TypeScript/badge.svg) ![Part 2 - TypeScript](https://github.com/GaryHughes/Exchange/workflows/Part%202%20-%20TypeScript/badge.svg) ![Benchmark](https://github.com/GaryHughes/Exchange/workflows/Benchmark/badge.svg) 

# What is this?

Exchange is a playground to experiment with and compare programming languages by solving a simple problem in your language of choice and then seeing how fast you can make it run.

The problem is broken into two parts, for [Part 1](https://github.com/GaryHughes/Exchange/tree/master/Part%201) the goal is to solve the basic problem using idiomatic, expressive, readable code without too much though given to performance. For [Part 2](https://github.com/GaryHughes/Exchange/tree/master/Part%202) all bets are off and the goal is to make it run as fast as possible.

# Benchmarks

The solutions are benchmarked by taking the build artifacts for each language and running them 5 times over the supplied input files. The median runtime is recorded. All solutions are run on the same container instance sequentially, the results will vary depending on what resources the particular machine has at run time and will typcially be noticably slower than the results you will see on modern desktop hardware.

Some solutions are excluded from the benchmarks entirely because they take too long to run even once. Others are exluded from the benchmark with the larger file because they take too long for that particular input.

## Part 1 Performance


||100K orders|trades|
-|:-:|:-:|
|C#|0:00:00.516434|3368|
|TypeScript|0:00:00.592988|3368|
|Java|0:00:00.614956|3368|
|Rust|0:00:00.756864|3368|
|F#|0:00:04.078050|3368|
|Swift|0:00:06.006415|3368|
|C|0:00:09.267627|3368|
|C++|0:00:19.858235|3368|
|Go|0:00:27.736944|3368|
|Cython|0:01:11.502053|3368|
|Python|0:01:19.536998|3368|


## Part 2 Performance

The slower implementations are excluded from the larger benchmark just so it runs in a reasonable time.

||100K orders|trades|
-|:-:|:-:|
|C|0:00:00.022919|3368|
|Rust|0:00:00.031435|3368|
|C++|0:00:00.036275|3368|
|Go|0:00:00.045123|3368|
|Cython|0:00:00.077921|3368|
|C#|0:00:00.175896|3368|
|Java|0:00:00.220482|3368|
|Python|0:00:00.261833|3368|
|TypeScript|0:00:00.361181|3368|
|F#|0:00:00.387868|3368|
|Swift|0:00:00.885277|3368|


||10M orders|trades|
-|:-:|:-:|
|C|0:00:02.092437|360131|
|C++|0:00:03.241159|360131|
|Rust|0:00:03.327392|360131|
|Java|0:00:04.551864|360131|
|Go|0:00:04.838908|360131|
|Cython|0:00:06.665596|360131|
|C#|0:00:09.342571|360131|
|TypeScript|0:00:18.115505|360131|
|F#|0:00:18.969605|360131|
|Swift|0:01:28.646317|360131|


