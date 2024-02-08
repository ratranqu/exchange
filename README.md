![Part 1 - C++](./workflows/Part%201%20-%20C++/badge.svg) ![Part 2 - C++](./workflows/Part%202%20-%20C++/badge.svg) ![Part 1 - C#](./workflows/Part%201%20-%20C%23/badge.svg) ![Part 2 - C#](./workflows/Part%202%20-%20C%23/badge.svg) ![Part 1 - F#](./workflows/Part%201%20-%20F%23/badge.svg) ![Part 2 - F#](./workflows/Part%202%20-%20F%23/badge.svg) ![Part 1 - Go](./workflows/Part%201%20-%20Go/badge.svg) ![Part 2 - Go](./workflows/Part%202%20-%20Go/badge.svg) ![Part 1 - Rust](./workflows/Part%201%20-%20Rust/badge.svg) ![Part 2 - Rust](./workflows/Part%202%20-%20Rust/badge.svg) ![Part 1 - Swift](./workflows/Part%201%20-%20Swift/badge.svg) ![Part 2 - Swift](./workflows/Part%202%20-%20Swift/badge.svg) ![Part 1 - Java](./workflows/Part%201%20-%20Java/badge.svg) ![Part 2 - Java](./workflows/Part%202%20-%20Java/badge.svg) ![Part 1 - Python](./workflows/Part%201%20-%20Python/badge.svg) ![Part 2 - Python](./workflows/Part%202%20-%20Python/badge.svg) ![Part 1 - Cython](./workflows/Part%201%20-%20Cython/badge.svg) ![Part 2 - Cython](./workflows/Part%202%20-%20Cython/badge.svg) ![Part 1 - C](./workflows/Part%201%20-%20C/badge.svg) ![Part 2 - C](./workflows/Part%202%20-%20C/badge.svg) ![Part 1 - TypeScript](./workflows/Part%201%20-%20TypeScript/badge.svg) ![Part 2 - TypeScript](./workflows/Part%202%20-%20TypeScript/badge.svg) ![Benchmark](./workflows/Benchmark/badge.svg) 

# What is this?

Exchange is a playground to experiment with and compare programming languages by solving a simple problem in your language of choice and then seeing how fast you can make it run.

The problem is broken into two parts, for [Part 1](./tree/master/Part%201) the goal is to solve the basic problem using idiomatic, expressive, readable code without too much though given to performance. For [Part 2](./tree/master/Part%202) all bets are off and the goal is to make it run as fast as possible.

# Benchmarks

The solutions are benchmarked by taking the build artifacts for each language and running them 5 times over the supplied input files. The median runtime is recorded. All solutions are run on the same container instance sequentially, the results will vary depending on what resources the particular machine has at run time and will typcially be noticably slower than the results you will see on modern desktop hardware.

Some solutions are excluded from the benchmarks entirely because they take too long to run even once. Others are exluded from the benchmark with the larger file because they take too long for that particular input.

## Part 1 Performance


local variable 'i' referenced before assignment
||100K orders|trades|
-|:-:|:-:|
|C#|0:00:00.563078|3368|
|Java|0:00:00.566619|3368|
|TypeScript|0:00:00.587369|3368|
|Rust|0:00:00.748212|3368|
|F#|0:00:04.090362|3368|
|C|0:00:09.260920|3368|
|C++|0:00:19.913987|3368|
|Go|0:00:27.807100|3368|
|Cython|0:01:23.743709|3368|
|Python|0:01:36.909073|3368|


## Part 2 Performance

The slower implementations are excluded from the larger benchmark just so it runs in a reasonable time.

local variable 'i' referenced before assignment
local variable 'i' referenced before assignment
||100K orders|trades|
-|:-:|:-:|
|C|0:00:00.023166|3368|
|Rust|0:00:00.031934|3368|
|C++|0:00:00.036472|3368|
|Go|0:00:00.044031|3368|
|Cython|0:00:00.078774|3368|
|C#|0:00:00.173733|3368|
|Java|0:00:00.227131|3368|
|Python|0:00:00.271344|3368|
|TypeScript|0:00:00.365789|3368|
|F#|0:00:00.398978|3368|


||10M orders|trades|
-|:-:|:-:|
|C|0:00:02.089792|360131|
|C++|0:00:03.266822|360131|
|Rust|0:00:03.285888|360131|
|Java|0:00:04.583360|360131|
|Go|0:00:04.938826|360131|
|Cython|0:00:06.585205|360131|
|C#|0:00:09.410412|360131|
|TypeScript|0:00:18.053445|360131|
|F#|0:00:19.023390|360131|


