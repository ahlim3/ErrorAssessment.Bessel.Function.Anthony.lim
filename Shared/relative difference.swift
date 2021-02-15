//
//  ErrorCalculation.swift
//  ErrorAssessment.Bessel.Function.Anthony.lim
//
//  Created by Anthony Lim on 2/13/21.
//

import Foundation
func  relative_Diff(Upward: Double, Downward: Double) -> Double
{
    var upward =
    var scale = calculateFirstBessel(xValue: xValue) /* jSub0 which we know. Used for scaling the downward recursion */
    
    var jSubl = Array(repeating: 0.0, count: start + 2) /* jSubl is an array that holds the various orders of the Bessel Function */
    
    
    jSubl[start+1] = 1.0                   // start with "guess"
    jSubl[start] = 1.0                      // start with "guess"
    
    for index in (1...start).reversed(){
        
        jSubl[index-1] = ((2.0*(Double(index)))/xValue)*jSubl[index] - jSubl[index+1]
    }
    
    scale = (scale)/jSubl[0];      /* scale the result */
    
    return(jSubl[order]*(scale))
}
