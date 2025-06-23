//
//  Math.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/6/20.
//

import Foundation

struct Math {
    static func power(_ base: Double, _ exponent: Int) -> Double {
        return (0..<exponent).reduce(1, { result, _ in result * base })
    }

    static func quickPower(_ base: Double, _ exponent: Int) -> Double {
        if exponent == 0 { return 1 }
        let half = power(base, exponent / 2)
        if exponent % 2 == 0 {
            return half * half
        } else {
            return half * half * base
        }
    }
    
    
    // Trigonometry
    
    // y = 1/(sin(x))
    static func csc(_ x: Double) -> Double {
        return 1 / sin(x)
    }
    
    static func dfCsc(_ x: Double) -> Double {
        let sine = sin(x)
        return -cos(x) / (sine * sine)
    }
    
    static func intCsc(_ x: Double) -> Double {
        return log(tan(0.5 * x))
    }
    
    //
    static func sec(_ x: Double) -> Double {
        return 1 / cos(x)
    }
    
    // y = tan(x)
//    static func tangent(_ x: Double) -> Double {
//        
//    }
    
    //
    static func cotan(_ x: Double) -> Double {
        return 1 / tan(x)
    }
    
    // y = sin(ax)
    static func scaledSine(_ x: Double, a: Double = 2) -> Double {
        return sin(a * x)
    }
    
    static func dfScaledSine(_ x: Double, a: Double = 2) -> Double {
        return a * cos(a * x)
    }
    
    static func intScaledSine(_ x: Double, a: Double = 2) -> Double {
        return -cos(a * x) / a
    }
    
    // y = cos(ax)
    static func scaledCosine(_ x: Double, a: Double = 2) -> Double {
        return cos(a * x)
    }
    
    static func dfScaledCosine(_ x: Double, a: Double = 2) -> Double {
        return -a * sin(a * x)
    }
    
    static func intScaledCosine(_ x: Double, a: Double = 2) -> Double {
        return sin(a * x) / a
    }
    
    // y = tan(ax)
    static func scaledTangent(_ x: Double, a: Double = 2) -> Double {
        return tan(a * x)
    }
    
    static func dfScaledTangent(_ x: Double, a: Double = 2) -> Double {
        let cosine = cos(a * x)
        
        return a / (cosine * cosine)
    }
    
    static func intScaledTangent(_ x: Double, a: Double = 2) -> Double {
        let ln = log(cos(a * x))
        
        return -ln / a
    }
    
    // y = sin² x
    static func sineSquared(_ x: Double) -> Double {
        let sine = sin(x)
        
        return sine * sine
    }
    
    static func dfSineSquared(_ x: Double) -> Double {
        return sin(2 * x)
    }
    
    static func intSinceSquared(_ x: Double) -> Double {
        return 0.5 * x - 0.25 * sin(x * x)
    }
    
    // y = cos² x
    static func cosineSquared(_ x: Double) -> Double {
        let cosine = cos(x)
        return cosine * cosine
    }
    
    static func dfCosineSquared(_ x: Double) -> Double {
        return -sin(2 * x)
    }
    
    static func intCosineSquared(_ x: Double) -> Double {
        return 0.5 * x + 0.25 * sin(x * x)
    }
    
    // y =  sinⁿ x
    static func sinePower(_ x: Double, n: Double = 3) -> Double {
        let sine = sin(x)
        return pow(sine, n)
    }
    
    static func dfSinePower(_ x: Double, n: Double = 3) -> Double {
        let sine = sin(x)
        let cosine = cos(x)
        
        return n * pow(sine, n-1) * cosine
    }
    
    // y = 1/(sin² x)
    static func cscSquared(_ x: Double) -> Double {
        let sine = sin(x)
        return 1 / (sine * sine)
    }
    
    static func dfCscSquared(_ x: Double) -> Double {
        let sine = sin(x)
        let sine2 = sin(2 * x)
        
        return -sine2 / pow(sine, 4)
    }
    
    static func intCscSquared(_ x: Double) -> Double {
        let tangent = tan(x)
        return -1/tangent
    }
    
    // y =  1/(sinx · cosx)
    static func secCscProduct(_ x: Double) -> Double {
        return 1 / (sin(x) * cos(x))
    }
    
    static func dfSecCscProduct(_ x: Double) -> Double {
        let sineSquared = pow(sin(x), 2)
        let cosineSquared = pow(cos(x), 2)
        
        return (sineSquared - cosineSquared) / (sineSquared * cosineSquared)
    }
    
    static func intSecCscProduct(_ x: Double) -> Double {
        return log(tan(x))
    }
    
    // y = sinmx · sinnx
    static func sinesProduct(_ x: Double, m: Double = 4, n: Double = 2) -> Double {
        return sin(m * x) * sin(n * x)
    }
    
    static func dfSinesProduct(_ x: Double, m: Double = 4, n: Double = 2) -> Double {
        return n * sin(m * x) * cos(n * x) + n * sin(n * x) * cos(m * x)
    }
    
    static func intSinesProduct(_ x: Double, m: Double = 4, n: Double = 2) -> Double {
        return 0.5 * cos((m - n) * x) - 0.5 * cos((m + n) * x)
    }
    
    // y = sin² ax
    static func sineSquaredScaled(_ x: Double, a: Double = 2) -> Double {
        return pow(sin(a * x), 2)
    }
    
    static func dfSineSquaredScaled(_ x: Double, a: Double = 2) -> Double {
        return 2 * a * sin(2 * a * x)
    }
    
    static func intSineSquaredScaled(_ x: Double, a: Double = 2) -> Double {
        return 0.5 * x - 0.25 * sin(2 * a * x) / a
    }
    
    // y = cos² ax
    static func cosSquaredScaled(_ x: Double, a: Double = 2) -> Double {
        return pow(cos(a * x), 2)
    }
    
    static func dfCosSquaredScaled(_ x: Double, a: Double = 2) -> Double {
        return -2 * a * sin(2 * a * x)
    }
    
    static func intCosSquaredScaled(_ x: Double, a: Double = 2) -> Double {
        return 0.5 * x + 0.25 * sin(2 * a * x) / a
    }
    
    // Composite rational
    // y = 1/(x + a)
    static func reciprocalLinear(_ x: Double, a: Double = 2) -> Double {
        return 1 / (x + a)
    }
    
    static func dfReciprocalLinear(_ x: Double, a: Double = 2) -> Double {
        return -1 / pow((x + a), 2)
    }
    
    static func intRecriprocalLinear(_ x: Double, a: Double = 2) -> Double {
        return log(x + a)
    }
    
    // y = 1/√(a² + x²)
    static func inverseDistance(_ x: Double, a: Double = 2) -> Double {
        return 1 / sqrt((a * a + x * x))
    }
    
    static func dfInverseDistance(_ x: Double, a: Double = 2) -> Double {
        let squaredSum = a * a + x * x
        return -x / pow(squaredSum, 1.5)
    }
    
    static func intInverseDistance(_ x: Double, a: Double = 2) -> Double {
        let squaredSum = a * a + x * x
        return log(x + squaredSum)
    }
    
    // y = 1/(a ± bx)
    static func reciprocalAffine(_ x: Double, a: Double = 1, b: Double = 2) -> Double {
        let sum = a + b * x
        return 1 / sum
    }
    
    static func dfReciprocalAffine(_ x: Double, a: Double = 1, b: Double = 2) -> Double {
        // -b / (a + bx)^2
        let sumSquared = pow((a + b * x), 2)
        return -b / sumSquared
    }
    
    static func intReciprocalAffine(_ x: Double, a: Double = 1, b: Double = 2) -> Double {
        // log(a + bx) / b
        let ln = log(a + b * x)
        return ln / b
    }
    
    // y = a²/(a² + x²)³/²
    static func inverseCubeRootDist(_ x: Double, a: Double = 2) -> Double {
        let squaredSum = a*a + x*x
        let cubeRoot = pow(squaredSum, 1.5)
        return a*a / cubeRoot
    }
    
    static func dfInverseCubeRootDist(_ x: Double, a: Double = 2) -> Double {
        // -3 a^2 x / (a^2 + x^2)^(5/2)
        let root = pow(a*a + x*x, 2.5)
        return -3*a*a*x / root
    }
    
    static func intInverseCubeRootDist(_ x: Double, a: Double = 2) -> Double {
        // a / √(a^2 + x^2)
        let squaredSum = a * a + x * x
        let root = sqrt(squaredSum)
        return x / root
    }
}
