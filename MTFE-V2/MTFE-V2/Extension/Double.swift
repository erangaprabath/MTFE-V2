//
//  Double.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-20.
//

import Foundation


extension Double{
    
    /// Example of Double value convert to the Currency type with 2-6 Decimal places
        /// ```
        /// Convert 1234.56 to $1,2345.56
        ///  ```

        private var currencyFormatter2:NumberFormatter{
            let formatter = NumberFormatter()
            formatter.usesGroupingSeparator = false
            formatter.numberStyle = .currency
            formatter.locale = .current
            formatter.currencyCode = "usd"
            formatter.currencySymbol = "$"
            formatter.maximumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            return formatter
        }
            /// Example of Double value convert to the Currency type with 2 Decimal places
            /// ```
            /// Convert 1234.56 to "$1,2345.56"
            ///  ```

        func asCurrencyWith2decimal() -> String{
            let number = NSNumber(value: self)
            return currencyFormatter2.string(from: number) ?? "$0.00"
        }
/// Example of Double value convert to the Currency type with 2-6 Decimal places
    /// ```
    /// Convert 1234.56 to $1,2345.56
    /// Convert 12.3456 to $12.34556
    /// Convert 0.123456 to $0.1234556
    ///  ```

    private var currencyFormatter:NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = false
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
        /// Example of Double value convert to the Currency type with 2-6 Decimal places
        /// ```
        /// Convert 1234.56 to "$1,2345.56"
        /// Convert 12.3456 to "$12.34556"
        /// Convert 0.123456 to "$0.1234556"
        ///  ```

    func asCurrencyWith6decimal() -> String{
        let number = NSNumber(value: self)
        return currencyFormatter.string(from: number) ?? "$0.00"
    }
    
    /// Convert a Double into string representation
    /// ```
    /// Convert 1.2345 to "1.23"
    /// ```
    
    func asNumberString() -> String{
        return String(format: "%.2f",self)
    }
    
    /// Convert a Double into string representation with precentage symbol
    /// ```
    /// Convert 1.2345 to "1.23$%"
    /// ```
    func asPercentageString() -> String{
        return asNumberString() + "%"
    }
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 12345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()

        default:
            return "\(sign)\(self)"
        }
    }

}
