| Language |     Part 1    |     Part 2    | 
|:--------:|:-------------:|:-------------:|
|  C++     | [![Build Status](https://dev.azure.com/garyedwardhughes/Exchange/_apis/build/status/3?branchName=master)](https://dev.azure.com/garyedwardhughes/Exchange/_build/latest?definitionId=3&branchName=master)              | [![Build Status](https://dev.azure.com/garyedwardhughes/Exchange/_apis/build/status/12?branchName=master)](https://dev.azure.com/garyedwardhughes/Exchange/_build/latest?definitionId=12&branchName=master)              | 
|  C#      | [![Build Status](https://dev.azure.com/garyedwardhughes/Exchange/_apis/build/status/Part%201%20-%20C%23?branchName=master)](https://dev.azure.com/garyedwardhughes/Exchange/_build/latest?definitionId=4&branchName=master)              | [![Build Status](https://dev.azure.com/garyedwardhughes/Exchange/_apis/build/status/Part%202%20-%20C%23?branchName=master)](https://dev.azure.com/garyedwardhughes/Exchange/_build/latest?definitionId=6&branchName=master) | 
|  F#      | [![Build Status](https://dev.azure.com/garyedwardhughes/Exchange/_apis/build/status/Part%201%20-%20F%23?branchName=master)](https://dev.azure.com/garyedwardhughes/Exchange/_build/latest?definitionId=5&branchName=master)              | [![Build Status](https://dev.azure.com/garyedwardhughes/Exchange/_apis/build/status/Part%202%20-%20F%23?branchName=master)](https://dev.azure.com/garyedwardhughes/Exchange/_build/latest?definitionId=7&branchName=master) |
|  Go      | [![Build Status](https://dev.azure.com/garyedwardhughes/Exchange/_apis/build/status/Part%201%20-%20Go?branchName=master)](https://dev.azure.com/garyedwardhughes/Exchange/_build/latest?definitionId=8&branchName=master)              | [![Build Status](https://dev.azure.com/garyedwardhughes/Exchange/_apis/build/status/Part%202%20-%20Go?branchName=master)](https://dev.azure.com/garyedwardhughes/Exchange/_build/latest?definitionId=9&branchName=master) |
|  Rust    | [![Build Status](https://dev.azure.com/garyedwardhughes/Exchange/_apis/build/status/Part%201%20-%20Rust?branchName=master)](https://dev.azure.com/garyedwardhughes/Exchange/_build/latest?definitionId=10&branchName=master)              | [![Build Status](https://dev.azure.com/garyedwardhughes/Exchange/_apis/build/status/Part%202%20-%20Rust?branchName=master)](https://dev.azure.com/garyedwardhughes/Exchange/_build/latest?definitionId=11&branchName=master)              |
|  Swift   |  [![Build Status](https://dev.azure.com/garyedwardhughes/Exchange/_apis/build/status/Part%202%20-%20Swift?branchName=master)](https://dev.azure.com/garyedwardhughes/Exchange/_build/latest?definitionId=15&branchName=master) | [![Build Status](https://dev.azure.com/garyedwardhughes/Exchange/_apis/build/status/Part%202%20-%20Swift?branchName=master)](https://dev.azure.com/garyedwardhughes/Exchange/_build/latest?definitionId=20&branchName=master) |
| Java     | [![Build Status](https://dev.azure.com/garyedwardhughes/Exchange/_apis/build/status/Part%201%20-%20Java?branchName=master)](https://dev.azure.com/garyedwardhughes/Exchange/_build/latest?definitionId=18&branchName=master) | [![Build Status](https://dev.azure.com/garyedwardhughes/Exchange/_apis/build/status/Part%202%20-%20Java?branchName=master)](https://dev.azure.com/garyedwardhughes/Exchange/_build/latest?definitionId=19&branchName=master) |
| Shell    | NA* | NA* |
| Python   | [![Build Status](https://dev.azure.com/garyedwardhughes/Exchange/_apis/build/status/Part%201%20-%20Python?branchName=master)](https://dev.azure.com/garyedwardhughes/Exchange/_build/latest?definitionId=21&branchName=master) | [![Build Status](https://dev.azure.com/garyedwardhughes/Exchange/_apis/build/status/Part%202%20-%20Python?branchName=master)](https://dev.azure.com/garyedwardhughes/Exchange/_build/latest?definitionId=22&branchName=master) |

1. There is nothing to build for the shell variants and because these implementations are relatively slow they are not included in the benchmarks so we don't need to produce anything runnable by those pipelines.

The following benchmarks are run in Microsoft hosted Azure Pipeline agents so the performance can and will vary between runs depending on what machine they end up running on. Each group, Part 1, Part 2, etc is run on a single agent so the performance of implementations within that group can be compared with some meaning. Performance in the Azure environment is significantly worse than will be seen on modern desktop hardware.

## Part 1 Performance
[![Build Status](https://dev.azure.com/garyedwardhughes/Exchange/_apis/build/status/Part%201%20-%20Benchmark?branchName=master)](https://dev.azure.com/garyedwardhughes/Exchange/_build/latest?definitionId=13&branchName=master)

||100K orders|trades|
-|:-:|:-:|
|C#|0:00:00.586240|3368|
|Java|0:00:00.858132|3368|
|Rust|0:00:01.601338|3368|
|F#|0:00:07.634864|3368|
|Swift|0:00:10.198899|3368|
|C++|0:00:25.864191|3368|
|Go|0:00:52.484356|3368|
|python|0:02:17.607472|3368|


## Part 2 Performance
[![Build Status](https://dev.azure.com/garyedwardhughes/Exchange/_apis/build/status/Part%202%20-%20Benchmark?branchName=master)](https://dev.azure.com/garyedwardhughes/Exchange/_build/latest?definitionId=14&branchName=master)

||100K orders|trades|
-|:-:|:-:|
|Rust|0:00:00.050065|3368|
|C++|0:00:00.057156|3368|
|Go|0:00:00.065436|3368|
|C#|0:00:00.143846|3368|
|Java|0:00:00.321508|3368|
|F#|0:00:00.347197|3368|
|Swift|0:00:01.795755|3368|


||10M orders|trades|
-|:-:|:-:|
|Rust|0:00:05.718752|360131|
|C++|0:00:06.084085|360131|
|Go|0:00:09.046801|360131|
|Java|0:00:12.285566|360131|
|C#|0:00:14.123299|360131|
|F#|0:00:28.795695|360131|


