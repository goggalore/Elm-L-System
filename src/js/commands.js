export function computeCommands(model) {
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

function arrayToObject(array) {
    const result = {};

    for (let i = 0; i < array.length; i++) {
        result[array[i][0]] = array[i][1];
    }

    return result;
}