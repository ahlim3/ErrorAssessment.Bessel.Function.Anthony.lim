//
//  ContentView.swift
//  Shared
//
//  Created by Anthony Lim on 2/13/21.
//

import SwiftUI

struct ContentView: View {
   
    @State var guess = ""
    @State private var totalInput: Int? = 3
    
    private var intFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        return f
    }()
    
    var body: some View {
    
       VStack {
            HStack {
                
                TextEditor(text: $guess)

                
                Button("Calculate Bessel Functions", action: calculateBesselFunc)
                    }
            .frame(minHeight: 300, maxHeight: 1000)
            .frame(minWidth: 480, maxWidth: 1000)
            .padding()
        
        HStack{
            
            Text(verbatim: "Order:")
            .padding()
            TextField("Total", value: $totalInput, formatter: intFormatter)
        
                .padding()
            
            }
        }
        
    }
    
    func calculateBesselFunc()  {
    let jmax = totalInput ?? 0
    let xmax = 10.0                     /* max of x  */
    let xmin = 0.0                     /* min of x >0  */
    let step = 0.1                   /* delta x  */
    var order = 0
    guess = String(format: "")
        repeat{
                                                  /* order of Bessel function */
                let start = order+25                      /* used for downward algorithm */
                var x = 0.0
                var maxIndex = 0
                var up = 0.0
                var down = 0.0
                var diff = 0.0
                
                maxIndex = Int(((xmax-xmin)/step))+1
                
                for index in (0...maxIndex)
                    {
                        x = Double(index)*step + xmin
                        up = calculateDownwardRecursion(xValue: x, order: order, start: start)
                        down = calculateUpwardRecursion(xValue: x, order: order)
                        diff = abs(up - down)/(abs(up)+abs(down))
                        if (x==0.1){
                        guess += String(format: "J%d(x)\nx = %f, Downward, %7.5e, Upward, %7.5e, Relative difference, %7.5e\n", order, x, up, down, diff)
                        }
                        if (x==1.0){
                        guess += String(format: "x = %f, Downward, %7.5e, Upward, %7.5e, Relative difference, %7.5e\n", x, up, down, diff)
                        }
                        if (x==10.0){
                        guess += String(format: "x = %f, Downward, %7.5e, Upward, %7.5e, Relative difference, %7.5e\n", x, up, down, diff)
                        }
                    }
            if (up < 1){
                guess += String(format:"J%d Upward recurrsion converges and stable \n", order)
            }
            else{
                guess += String(format:"J%d Upward recurrsion doees not converges nor stable \n", order)
            }
            
            if (down < 1){guess += String(format:"J%d Downward recurrsion converges and stable \n", order)
                
            }
            else{
                guess += String(format:"J%d Downward recurrsion doees not converges nor stable \n", order)
            }
        order = order + 1

        }
        while order < jmax + 1
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

