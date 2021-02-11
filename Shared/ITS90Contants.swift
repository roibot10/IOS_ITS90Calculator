//
//  ITS90Constants.swift
//  ITS90Calculator
//
//  Created by ADH Media Production on 1/12/21.
//

import Foundation

enum ITS90Constants {
    
    /*
     * ABOVE ZERO
     * Used for calculating resistance based on temperature (Above zero) (cc0-cc9)
     */
    public static let AboveZeroResistance: [Double] = [
        2.78157254,
        1.64650916,
        -0.1371439,
        -0.00649767,
        -0.00234444,
        0.00511868,
        0.00187982,
        -0.00204472,
        -0.00046122,
        0.00045724
    ];
    
    /*
     * Used for calculating temp based on measured resistance (Above zero) (d0-d9)
     */
    public static let AboveZeroTemperature: [Double] = [
        439.932854,
        472.41802,
        37.684494,
        7.472018,
        2.920828,
        0.005184,
        -0.963864,
        -0.188732,
        0.191203,
        0.049025
    ];
    
    /*
     * BELOW ZERO
     * Used for calculating resistance based on temperature (Below zero) (aa0 - aa12)
     */
    public static let BelowZeroResistance: [Double] = [
        -2.13534729,
        3.1832472,
        -1.80143597,
        0.71727204,
        0.50344027,
        -0.61899395,
        -0.05332322,
        0.28021362,
        0.10715224,
        -0.29302865,
        0.04459872,
        0.11868632,
        -0.05248134
    ];
    
    /*
     * Used for calculating temp based on measured resistance (Below zero) (bb0 - bb15)
     */
    public static let BelowZeroTemperature: [Double] = [
        0.183324722,
        0.240975303,
        0.209108771,
        0.190439972,
        0.142648498,
        0.077993465,
        0.012475611,
        -0.032267127,
        -0.075291522,
        -0.05647067,
        0.076201285,
        0.123893204,
        -0.029201193,
        -0.091173542,
        0.001317696,
        0.026025526,

    ];
    
    public static let KELVIN: Double = 273.15;
}
