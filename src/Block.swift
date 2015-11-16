import Foundation

class Block {
    var id: Int
    var name: String
    var code: String
    var category: String
    var language: String
    
    init(id: Int, name: String, code: String, category: String, language: String) {
        self.id=id
        self.name=name
        self.code=code
        self.category=category
        self.language=language
    }
    
    class func blocksWithJSON(allResults: NSArray, cat: String) -> [Block] {
        // Create an empty array of Blocks to append to from this list
        var blocks = [Block]()
        // Store the results in our table data array
        if allResults.count>0 {
            // Sometimes iTunes returns a collection, not a track, so we check both for the 'name'
            for result in allResults {
                var language = result["language"] as String
                var category = result["category"] as String
                if (language=="iOS" && category==cat) {
                    var id = result["id"] as Int
                    var name = result["name"] as String
                    var code = result["code"] as String
                    var newBlock = Block(id: id, name: name, code: code, category: category, language: language)
                    blocks.append(newBlock)
                }
            }
        }
        return blocks
    }
    
    class func toNode(block:Block)->Node{
        switch block.code {
        case "ifTime" :
            return IfTime()
        case "ifBrightness" :
            return IfBrightness()
        case "lolo" :
            return Brightness()
        case "flashON" :
            return FlashlightON()
        case "flashOFF" :
            return FlashlightOFF()
        case "vibrate" :
            return Vibrate()
        case "wait" :
            return Wait()
        case "then" :
            return Then()
        case "else" :
            return Else()
        case "end" :
            var n = Node()
            n.name="end"
            return n
            
        default :
            println("nique ta race")
            return Node()
        }
    }
    
    func toDict() -> Dictionary<String,String> {
        var dict = [String: String]()
        dict["name"] = self.name
        dict["code"] = self.code
        dict["category"] = self.category
        dict["language"] = self.language
        return dict
    }
    
    func indent(list:[Block], j:Int)->String{
        var i = 0
        var k = 0
        while k<j {
            if(list[k].code=="then") {
                i++
            } else if (list[k].code=="end"){
                i--
            }
            k++
        }
        if list[j].code=="else" {
            i--
        }
        if list[j].code=="end" {
            i--
        }
        var indentation = ""
        for var p=0;p<i;p++ {
            indentation += "     "
        }
        return indentation
    }
    
}