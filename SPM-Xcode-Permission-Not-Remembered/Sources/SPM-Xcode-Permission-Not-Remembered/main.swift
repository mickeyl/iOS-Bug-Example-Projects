import Foundation

let path = "/Users/mickey/Documents/testfile.txt"
let url = URL(fileURLWithPath: path)
let data = try Data(contentsOf: url)
