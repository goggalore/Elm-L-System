import { computeCommands } from '../commands.js';
import { computePath } from '../path.js';
import { computeBounds } from '../bounds.js';
import { computeScale } from '../scale.js';

export function getTransformations(model) {
    const canvas = document.getElementById('canvasMain');

    canvas.width = 2000;
    canvas.height = 2000;

    const center = {
        x: canvas.width / 2,
        y: canvas.height / 2
    };

    const maxDimension = {
        width: canvas.width * 0.90,
        height: canvas.height * 0.90
    };

    const commands = computeCommands(model)
    const path = computePath(model, commands);
    const bounds = computeBounds(path);
    const scale = computeScale(bounds, maxDimension);

    return {
        path: path,
        bounds: bounds,
        scale: scale,
        center: center
    }
}