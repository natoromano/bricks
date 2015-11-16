import Foundation

class Programme {
    var user: String
    var id: Int
    var name: String
    var blocks: [Block]
    var root: Node
    
    init(id: Int, name: String, blocks: [Block], user: String) {
        self.id=id
        self.name=name
        self.blocks=blocks
        self.user=user
        self.root=Node()
    }
    
    init() {
        self.id=0
        self.name="Programme test"
        self.blocks=[Block]()
        self.user="Nato"
        self.root=Node()
    }
    
    class func blockswithJSON(allResults: NSArray) -> [Block] {
        // Create an empty array of Blocks to append to from this list
        var blocks = [Block]()
        // Store the results in our table data array
        if allResults.count>0 {
            // Sometimes iTunes returns a collection, not a track, so we check both for the 'name'
            for result in allResults {
                var language = result["language"] as String
                var category = result["category"] as String
                if (language=="iOS") {
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
    
    func build2(){
        var listNodes = [Node]()
        for block in self.blocks {
            var n = Block.toNode(block)
            listNodes.append(n)
            println("creation d'un nouveau node "+n.name!)
        }
        var current = listNodes.removeAtIndex(0)
        listNodes = current.add(listNodes)
        var first = current
        while (!listNodes.isEmpty) {
            while current.leftChild != nil {
                current = current.leftChild!
            }
            listNodes = current.add(listNodes)
        }
        self.root=first
    }
    
    func build(){
        var NodeList:[Node]=[]
        for block:Block in self.blocks{
            var next:Node = Block.toNode(block)
            NodeList.append(next)
        }
        if !NodeList.isEmpty{
            var first = NodeList.removeAtIndex(0)
            NodeList = first.add(NodeList)
            var current=first.next()
            
            while !NodeList.isEmpty {
                NodeList = current.add(NodeList)
                current = current.next()
            }
            self.root=first
        }
    }    
    
}