//
//  ContentView.swift
//  QR Code gen
//
//  Created by Kabir Soni  on 26/01/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct QRGenerator: View {
    
    @State private var text = ""
    
    func generateQR(text: String) -> Data? {
        let filter = CIFilter.qrCodeGenerator()
        guard let data = text.data(using: .ascii, allowLossyConversion: false) else { return nil }
        filter.message = data
        guard let ciimage = filter.outputImage else { return nil }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCIImage = ciimage.transformed(by: transform)
        let uiimage = UIImage(ciImage: scaledCIImage)
        return uiimage.pngData()!
    }
    
    var body: some View {
        
    NavigationStack {
            Form{
                Section(header: Text("").bold()){
                    TextField("Enter Text", text: $text)
                        .textFieldStyle(.plain)
                        .multilineTextAlignment(.leading)
                        
                        
                }
               
                Image(uiImage: UIImage(data: generateQR(text: text)!)!)
                    .resizable()
                    .frame(width: 250, height: 250)
                    .padding()
               
                    
            }
                    .navigationTitle("QR-Generator")
        }
        Text("Write Anything to generate QR Code").bold()
            .navigationViewStyle(StackNavigationViewStyle()) // Use for iPhone
            .navigationViewStyle(DoubleColumnNavigationViewStyle()) // Use for iPad
            
    }
}

#Preview {
    QRGenerator()
}
