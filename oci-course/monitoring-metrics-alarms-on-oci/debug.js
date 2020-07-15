const debugBuffer = []
const savepoints = {}

const debug = function (msg) {
    // using the full UTC string is a bit heavy handed perhaps; only minutes, seconds and ms would be quite enough, or just the timestamp in ms  
    debugBuffer.push(`${new Date().toUTCString()} ${msg}`)
}

const setSavepoint = function (savepoint) {
   savepoints[savepoint] = debugBuffer.length
}

// discard all logging from this savepoint onwards
const releaseSavepoint = function (savepoint) {
    // remove from debugBuffer everything from the index indicated by the savepoint
    debugBuffer.splice(savepoints[savepoint])
    // remove savepoint from savepoints collection
    savepoints[savepoint] = delete savepoints[savepoint]
 }

const spillDebugBeans = function (savepoint) {
    const buffer = debugBuffer.slice(savepoints[savepoint])
    buffer.forEach(msg => { console.warn(`DEBUG: ${msg}`) });
}// spillDebugBeans

const calculateSums = async function (sums) {
    setSavepoint("calculateSums")
    debug(`function calculateSums for ${JSON.stringify(sums)}`)
    const results = []
    try {        
        sums.forEach(sum => {
            debug(`Sum to process ${sum}`)
            const result = eval(sum)
            debug(`Result from processing ${sum} = ${result}`)
            results.push({ "sum": sum, "result": result })
        })// forEach       
    }
    catch (e) {
        // now that things have gone sideways, please report the messages that under normal conditions would be discarded
        debug(`Exception occurred ${e}`)
        spillDebugBeans("calculateSums")
        throw (e)
    }
    finally {
        releaseSavepoint("calculateSums")
    }
    return results
} //calculateSums

const calculator = async function () {
    setSavepoint("calculator")
    debug(`function calculator`)
    try {
        debug( `Sums are prepared`)
        const sums = [["3+9", "2/7"], ["8*6", "2/0", "hgah"]]
        debug( `Sums to process - call calulcateSums for both subsets ${JSON.stringify(sums)}`)
        const results1 = await calculateSums(sums[0])
        console.log(`Done processing of first bunch of sums; here are the results ${JSON.stringify(results1)}`)
        const results2 = await calculateSums(sums[1])
        console.log(`Done processing of second bunch of sums; here are the results ${JSON.stringify(results2)}`)
    }
    catch (e) {
        // now that things have gone sideways, please report the messages that under normal conditions would be discarded
        debug( `Exception occurred (and we are too lazy to do proper handling) ${e}`)
        spillDebugBeans("calculator")
        // handle exception - or not as in this case
    }
    finally {
        releaseSavepoint("Calculator")
    }
} //calculator

calculator()
