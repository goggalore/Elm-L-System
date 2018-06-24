export function computeBounds(path) {
    let xPos = [];
    let yPos = [];
    
    for (let i = 0; i < path.length; i++) {
        xPos.push(path[i].x);
        yPos.push(path[i].y);
    }
    
    const xMax = xPos.reduce(function(a, b) {
        return Math.max(a, b);
    });
    
    const yMax = yPos.reduce(function(a, b) {
        return Math.max(a, b);
    });
    
    const xMin = xPos.reduce(function(a, b) {
        return Math.min(a, b);
    });
    
    const yMin = yPos.reduce(function(a, b) {
        return Math.min(a, b);
    });
    
    const bounds = {
        xMin: xMin,
        xMax: xMax,
        yMin: yMin,
        yMax: yMax
    };
    
    const center = {
        x: (xMin + xMax)/2,
        y: (yMin + yMax)/2
    };
    
    bounds['center'] = center;
    
    return bounds;
}