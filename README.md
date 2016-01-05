# Numeric Operations for Swift

This project is just a simple practice on Swift and Accelerate framework.
The swift files contain some basic function used in numeric computation. The main functionality is build upon Accelearate framework which leaverages SIMD of the CPU, which make the codes run faster than native Swift code.

# Testing
Run `make test-osx` on Mac OSX.

# References

- [DFT v.s FFT](https://forums.developer.apple.com/thread/23321)
- [vDSP Guide - DFT](https://developer.apple.com/library/ios/documentation/Performance/Conceptual/vDSP_Programming_Guide/USingDFTFunctions/USingDFTFunctions.html#//apple_ref/doc/uid/TP40005147-CH4-SW1)
    + That is why we use `vDSP_DFT_XXX` rather than `vDSP_fft_XXX`.