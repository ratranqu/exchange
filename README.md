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
|C#||0.0|3368|
|Java||0.10535994148991745|3368|
|TypeScript||0.13285588092818268|3368|
|F#||6.627191990957533|3368|
|Swift||8.110532764696384|3368|
|C||16.712799080555847|3368|
|Rust||20.630890664032446|3368|
|C++||37.35304945811685|3368|
|Go||52.20022036264853|3368|
|Cython||137.13880947179453|3368|
|Python||165.3326906089418|3368|


## Part 2 Performance

The slower implementations are excluded from the larger benchmark just so it runs in a reasonable time.

||100K orders|% over fastest|trades|
-|:-:|:-:|:-:|
|C||0.0|3368|
|Rust||0.4624505928853755|3368|
|C++||0.5556122232139062|3368|
|Go||0.7724085171490501|3368|
|Swift||1.1541926983722215|3368|
|Cython||2.337668409197161|3368|
|C#||5.832717072548769|3368|
|Java||8.63768115942029|3368|
|Python||11.030643036253135|3368|
|TypeScript||14.513408984657232|3368|
|F#||15.142589995324919|3368|


||10M orders|% over fastest|trades|
-|:-:|:-:|:-:|
|C||0.0|360131|
|C++||0.5708942965309195|360131|
|Rust||0.7018177355799612|360131|
|Swift||1.010261239098128|360131|
|Go||1.1886127736217695|360131|


