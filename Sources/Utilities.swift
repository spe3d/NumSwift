import Accelerate

// func normalize(x:[Double], _ minValue:Double, _ maxValue:Double) -> [Double]{
    
//     return [1.1]
// }

// func normalize(x:[Float], _ from:Float, _ to:Float) -> [Float]{
//     return [1.1]
// }

func norm(x:[Double], _ y:[Double]) -> [Double]{
    /*
    2D vector norm
    */

    var inputX = [Double](x)
    var inputY = [Double](y)
    var xSquare = [Double](count:x.count, repeatedValue:0.0)
    var ySquare = [Double](count:y.count, repeatedValue:0.0)

    vDSP_vsqD(&inputX, 1, &xSquare, 1, vDSP_Length(x.count))
    vDSP_vsqD(&inputY, 1, &ySquare, 1, vDSP_Length(y.count))

    var squareSum = [Double](count:x.count, repeatedValue:0.0)

    vDSP_vaddD(&xSquare, 1, &ySquare, 1, &squareSum, 1, vDSP_Length(x.count))

    var N = Int32(squareSum.count)
    var vectorNorm = [Double](count:squareSum.count, repeatedValue:0.0)
    vvsqrt(&vectorNorm, &squareSum, &N)

    return vectorNorm
}

func norm(x:[Float], _ y:[Float]) -> [Float]{
    /*
    2D vector norm.
    */

    var inputX = [Float](x)
    var inputY = [Float](y)
    var xSquare = [Float](count:x.count, repeatedValue:0.0)
    var ySquare = [Float](count:y.count, repeatedValue:0.0)

    vDSP_vsq(&inputX, 1, &xSquare, 1, vDSP_Length(x.count))
    vDSP_vsq(&inputY, 1, &ySquare, 1, vDSP_Length(y.count))

    var squareSum = [Float](count:x.count, repeatedValue:0.0)

    vDSP_vadd(&xSquare, 1, &ySquare, 1, &squareSum, 1, vDSP_Length(x.count))

    var N = Int32(squareSum.count)
    var vectorNorm = [Float](count:squareSum.count, repeatedValue:0.0)

    vvsqrtf(&vectorNorm, &squareSum, &N)

    return vectorNorm
}

func roundToZero(x:[Double]) -> [Double]{

    var input = [Double](x)
    var fracPart = [Double](count:x.count, repeatedValue:0.0)
    vDSP_vfracD(&input, 1, &fracPart, 1, vDSP_Length(x.count))

    var result = [Double](count:x.count, repeatedValue:0.0)
    vDSP_vsubD(&fracPart, 1, &input, 1, &result, 1, vDSP_Length(x.count))

    return result

}

func roundToZero(x:[Float]) -> [Float]{

    var input = [Float](x)
    var fracPart = [Float](count:x.count, repeatedValue:0.0)
    vDSP_vfrac(&input, 1, &fracPart, 1, vDSP_Length(x.count))

    var result = [Float](count:x.count, repeatedValue:0.0)
    vDSP_vsub(&fracPart, 1, &input, 1, &result, 1, vDSP_Length(x.count))

    return result

}

func arangeD(N:Int, start:Int = 1) -> [Double]{

    var startDouble = Double(start)
    var one = Double(1)
    var result = [Double](count:N, repeatedValue:0.0)
    vDSP_vrampD(&startDouble, &one, &result, 1, vDSP_Length(N))

    return result
}

func arange(N:Int, start:Int = 1) -> [Float] {

    var startFloat = Float(start)
    var one = Float(1)
    var result = [Float](count:N, repeatedValue:0.0)
    vDSP_vramp(&startFloat, &one, &result, 1, vDSP_Length(N))

    return result
}

func linspace(start:Double, _ end:Double, num:Int) -> [Double]{

    var startDouble = Double(start)
    var endDouble = Double(end)
    var result = [Double](count:num, repeatedValue:0.0)

    vDSP_vgenD(&startDouble, &endDouble, &result, 1, vDSP_Length(num))

    return result

}

func linspace(start:Float, _ end:Float, num:Int) -> [Float]{

    var startFloat = Float(start)
    var endFloat = Float(end)
    var result = [Float](count:num, repeatedValue:0.0)

    vDSP_vgen(&startFloat, &endFloat, &result, 1, vDSP_Length(num))

    return result
}

func mean(x:[Double]) -> Double {

    let ptr_x = UnsafePointer<Double>(x)
    var value:Double = 0.0
    vDSP_meanvD(ptr_x, 1, &value, vDSP_Length(x.count))

    return value

}

func mean(x:[Float]) -> Float {

    let ptr_x = UnsafePointer<Float>(x)
    var value:Float = 0.0
    vDSP_meanv(ptr_x, 1, &value, vDSP_Length(x.count))

    return value
}

func splitArrayIntoParts(x:[Double], _ numberOfParts: Int) -> [[Double]] {

    var parts = [[Double]]()
    let input = [Double](x)
    let samplesPerSplit = Int(round(Double(x.count)/Double(numberOfParts)))

    var startIndex:Int
    var endIndex:Int
    var slice:ArraySlice<Double>
    for i in 1..<numberOfParts {
        startIndex = (i-1)*samplesPerSplit
        endIndex = i*samplesPerSplit
        slice = input[startIndex..<endIndex]
        parts.append([Double](slice))
    }

    startIndex = (numberOfParts-1)*samplesPerSplit
    endIndex = x.count
    slice = input[startIndex..<endIndex]
    parts.append([Double](slice))

    return parts

}

func splitArrayIntoParts(x:[Float], _ numberOfParts: Int) -> [[Float]] {

    var parts = [[Float]]()
    let input = [Float](x)
    let samplesPerSplit = Int(round(Double(x.count)/Double(numberOfParts)))

    var startIndex:Int
    var endIndex:Int
    var slice:ArraySlice<Float>
    for i in 1..<numberOfParts {
        startIndex = (i-1)*samplesPerSplit
        endIndex = i*samplesPerSplit
        slice = input[startIndex..<endIndex]
        parts.append([Float](slice))
    }

    startIndex = (numberOfParts-1)*samplesPerSplit
    endIndex = x.count
    slice = input[startIndex..<endIndex]
    parts.append([Float](slice))

    return parts

}

func leastPowerOfTwo(N:Int) -> Int {
    /*
    Find the least power of two greater than `N`.
    */ 

    let log2N = Int(log2(Double(N)))
    var NPowTwo = 1 << log2N

    if NPowTwo < N {
        NPowTwo = NPowTwo << 1
    }

    return NPowTwo
}

func abs(x:[Double]) -> [Double] {

    var input = [Double](x)
    var output = [Double](count:x.count, repeatedValue:0.0)

    vDSP_vabsD(&input, 1, &output, 1, vDSP_Length(x.count))

    return output
}

func abs(x:[Float]) -> [Float] {

    var input = [Float](x)
    var output = [Float](count:x.count, repeatedValue:0.0)

    vDSP_vabs(&input, 1, &output, 1, vDSP_Length(x.count))

    return output

}

func pad(x:[Double], toLength length: Int, value:Double = 0.0) -> [Double] {

    let result:[Double]

    if length <= x.count {
        result = [Double](x)
    } else {
        result = [Double](x) + [Double](count:length - x.count, repeatedValue:value)
    }
    return result
}

func pad(x:[Float], toLength length: Int, value:Float = 0.0) -> [Float] {

    let result:[Float]

    if length <= x.count {
        result = [Float](x)
    } else {
        result = [Float](x) + [Float](count:length - x.count, repeatedValue:value)
    }
    return result
}

func allClose(x:[Double], y:[Double], tol:Double = 3e-7) -> Bool {

    var inputX = [Double](x)
    var inputY = [Double](y)
    var isClosed = false

    if x.count == y.count {

        let N = x.count

        var xMinusY = [Double](count:N, repeatedValue:0.0)
        
        // Compute x - y (vectorized)
        vDSP_vsubD(&inputY, 1, &inputX, 1, &xMinusY, 1, vDSP_Length(N))

        // Take abs value
        vDSP_vabsD(&xMinusY, 1, &xMinusY, 1, vDSP_Length(N))

        var maximum:Double = 0
        vDSP_maxvD(&xMinusY, 1, &maximum, vDSP_Length(N))

        if maximum <= tol {
            isClosed = true
        }
    }

    return isClosed

}

func allClose(x:[Float], y:[Float], tol:Float = 3e-7) -> Bool {

    var inputX = [Float](x)
    var inputY = [Float](y)
    var isClosed = false

    if x.count == y.count {

        let N = x.count

        var xMinusY = [Float](count:N, repeatedValue:0.0)
        
        // Compute x - y (vectorized)
        vDSP_vsub(&inputY, 1, &inputX, 1, &xMinusY, 1, vDSP_Length(N))

        // Take abs value
        vDSP_vabs(&xMinusY, 1, &xMinusY, 1, vDSP_Length(N))

        var maximum:Float = 0
        vDSP_maxv(&xMinusY, 1, &maximum, vDSP_Length(N))

        if maximum <= tol {
            isClosed = true
        }
    }

    return isClosed
    
}