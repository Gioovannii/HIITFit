/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct TimerView: View {
    
    @State private var timeRemaining = 3 // 1 number of second for each exercise (3 for testing only)
    @Binding var timerDone: Bool // 2 Set up start exercise button passing a binding to the timerDone boolean flag that enable done button. Change value of timer done ehen timer reches zero, but this value isn't owned by timer view so it has to be a binding variable.
    let timer = Timer.publish(every: 1, on: .main, in: .common) // 3 call class method to create a timer publisher that publishes event every 1 seconds
        .autoconnect() // 4 connectable Publisher won't start firing upon subscription until call connect. Autoconnect to connect as soon text view subscribe to it 
    
    var body: some View {
        Text("\(timeRemaining)") // 5 time view display time remaining in a large round system font  surround by padding
            .font(.system(size: 90, design: .rounded))
            .padding()
            .onReceive(timer) { _ in // 6  on receive modifier subscribes to the timer publisher and updates time remaining as long value is positive
                
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    timerDone = true // 7 when timer reach 0 set timerdone to true
                }
            }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timerDone: .constant(false))
            
            .previewLayout(.sizeThatFits)
    }
}
