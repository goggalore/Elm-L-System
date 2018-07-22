export function computeScale(bounds, maxDimension) {
    let scale = 1;

    const dimension = {
        width: bounds.xMax - bounds.xMin,
        height: bounds.yMax - bounds.yMin
    };

    if (maxDimension.width/dimension.width <= maxDimension.height/dimension.height) {
        scale = maxDimension.width / dimension.width;
    }
    else {
        scale = maxDimension.height / dimension.height;
    }

    return scale;
}