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
    //      formatter.locale = .current
    //      formatter.currencyCode = "usd"
    //      formatter.currencySymbol = "$"
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
//      formatter.locale = .current
//      formatter.currencyCode = "usd"
//      formatter.currencySymbol = "$"
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
}
