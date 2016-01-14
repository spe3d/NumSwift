test-osx:
	make test-complex-osx
	make test-trigonometry-osx
	make test-fft-osx
	make test-convolve-osx
	make test-fft-convolve-osx
	make test-hilbert-osx

test-complex-osx:
	cp tests/test_complex.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift tests/SwiftTest/*.swift Sources/Complex.swift -o complex_test
	echo 'Running test on Complex.'
	./complex_test
	rm complex_test tests/main.swift

test-trigonometry-osx:
	cp tests/test_trigonometry.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift tests/SwiftTest/*.swift Sources/Trigonometry.swift -o test_trigonometry
	echo 'Running test on Trigonometry.'
	./test_trigonometry
	rm test_trigonometry tests/main.swift

test-fft-osx:
	cp tests/test_fft.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/SwiftTest/*.swift tests/main.swift Sources/Utilities.swift Sources/FFT.swift -o test_fft
	echo 'Running test on FFT.'
	./test_fft
	rm test_fft tests/main.swift


test-fft-convolve-osx:
	cp tests/test_fft_convolve.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift tests/SwiftTest/*.swift Sources/Utilities.swift Sources/Convolution.swift Sources/FFT.swift -o test_fft_convolve
	echo 'Running test on FFT-Convolution.'
	./test_fft_convolve
	rm test_fft_convolve tests/main.swift

test-hilbert-osx:
	cp tests/test_hilbert.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift tests/SwiftTest/*.swift Sources/Signal/Hilbert.swift Sources/Utilities.swift Sources/FFT.swift -o test_hilbert
	echo 'Running test on Hilber Transform.'
	./test_hilbert
	rm test_hilbert tests/main.swift

test-convolve-osx:
	cp tests/test_convolve.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift tests/SwiftTest/*.swift Sources/Utilities.swift Sources/Convolution.swift -o test_convolve
	echo 'Running test on Convolution.'
	./test_convolve
	rm test_convolve tests/main.swift

performance:
	make performance-fft
	make performance-fft-convolve
	make performance-hilbert
	make performance-convolve

performance-fft:
	cp tests/performance_fft.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift tests/SwiftTest/*.swift Sources/Utilities.swift Sources/FFT.swift -o performance-fft
	./performance-fft
	rm performance-fft tests/main.swift

performance-ifft:
	cp tests/performance_ifft.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift tests/SwiftTest/*.swift Sources/Utilities.swift Sources/FFT.swift -o performance-ifft
	./performance-ifft
	rm performance-ifft tests/main.swift

performance-fft-convolve:
	cp tests/performance_fft_convolve.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift tests/SwiftTest/*.swift Sources/Utilities.swift Sources/FFT.swift -o performance-fft-convolve
	./performance-fft-convolve
	rm performance-fft-convolve tests/main.swift

performance-hilbert:
	cp tests/performance_hilbert.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift tests/SwiftTest/*.swift Sources/Utilities.swift Sources/FFT.swift Sources/Signal/Hilbert.swift -o performance_hilbert
	./performance_hilbert
	rm performance_hilbert tests/main.swift

performance-convolve:
	cp tests/performance_convolve.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift tests/SwiftTest/*.swift Sources/Convolution.swift -o performance-convolve
	./performance-convolve
	rm performance-convolve tests/main.swift
