this.onmessage = (e) => {
    console.log("hello from commands.js");
    const model = e.data

    if (model !== undefined) {
        this.postMessage(computeCommands(model));
    }

    this.close();
} 

// converts a 2-dimensional array to an object with the
// first two entries of each index as key-value pairs.

function arrayToObject(array) {
    const result = {};

    for (let i = 0; i < array.length; i++) {
        result[array[i][0]] = array[i][1]
    }

    return result;
}

function computeCommands(model) {
    const rules = arrayToObject(model.rules);
    const maxLength = 200000;

    let result = model.axiom.split('');

    for (let i = 0; i < model.iterations; i++) {
        if (result.length > maxLength) {
            break;
        }

        result = result.map((char) => {
            if (rules[char] === undefined) {
                return char;
            }
            
            return rules[char];
        }).join('').split('');
    }

    return result;
}