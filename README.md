# SHA256

A C++ SHA256 implementation.

## Build

**Minimum C++11.**

Just run `make all`. There are no dependencies.

## Example usage

### Sample program

Provide as many strings as you want. The program will hash all of them in order.

```
$ ./SHA256 "string" "string2"
473287f8298dba7163a897908958f7c0eae733e25d2e027992ea2edc9bed2fa8
b993212a26658c9077096b804cdfb92ad21cf1e199e272c44eb028e45d07b6e0
```

### As a library

```cpp
#include "SHA256.h"

//...

string s = "hello world";
SHA256 sha;
sha.update(s);
std::array<uint8_t, 32> digest = sha.digest();

std::cout << SHA256::toString(digest) << std::endl;
```

## Using tipi.build to install SHA256

`SHA256` can be easily used with the [tipi.build](https://tipi.build) dependency manager, by adding the following to a `.tipi/deps`:

```json
{
    "System-Glitch/SHA256": { }
}
```

An example to try is available in `https://github.com/tipi-deps/example-System-Glitch-SHA256` (change the target name appropriately to `linux` or `macos` or `windows`):

```bash
tipi . -t <target>
```
