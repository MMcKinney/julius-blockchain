using Dates
using SHA

#structure of a block
struct Block
    data::String
    hash::String
    index::Int
    nonce::Int
    previousHash::String
    timestamp::DateTime

    function Block(data, index, nonce, previousHash, timestamp)
        hash = sha2_256(string(data, index, previousHash, timestamp))
        nonce += 1
        new(data, bytes2hex(hash), index, nonce, previousHash, timestamp)
    end
end

#add another block to the chain
function appendBlock(tailBlock::Block)
    nextIndex = tailBlock.index + 1
    return Block(string("new block data...", nextIndex), nextIndex, tailBlock.nonce, tailBlock.hash, Dates.now())
end

#mine the genesis block
Blockchain = [Block("The first block", 0, 0, "0", Dates.now())]

#limit the length of the blockchain to demonstrate functionality
maxBlocks = 13

function demoBlockchain()
    #add some blocks
    for tail = 1:maxBlocks
        append!(Blockchain, [appendBlock(Blockchain[tail])])
    end
    #print all blocks
    #todo better toString
    println("data, hash, index, nonce, previousHash, timestamp")
    for index = 1:maxBlocks
        println(Blockchain[index])
    end
end

demoBlockchain()