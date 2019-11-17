#include <iostream>
#include <chrono>
#include <ctime>
#include "SHA256.h"

int main(int argc, char ** argv) {

	for(int i = 1 ; i < argc ; i++) {
		SHA256 sha;
		sha.update(argv[i]);
		uint8_t * digest = sha.digest();

		std::cout << SHA256::toString(digest) << std::endl;

		delete[] digest;
	}

	return EXIT_SUCCESS;
}
