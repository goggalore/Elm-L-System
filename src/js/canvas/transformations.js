import { computeCommands } from '../components/commands.js';
import { computePath } from '../components/path.js';
import { computeBounds } from '../components/bounds.js';
import { computeScale } from '../components/scale.js';

export function getTransformations(model) {
    const canvas = document.getElementById('canvasMain');

    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;

    const center = {
        x: canvas.width/2, 
        y: canvas.height/2
    };

    const maxDimension = {
        width: canvas.width * 0.65, 
        height: canvas.height * 0.85
    };

    const commands = computeCommands(model)
    const path = computePath(model, commands);
    const bounds = computeBounds(path);
    const scale = computeScale(bounds, maxDimension);

    return {
        path : path,
        bounds: bounds,
        scale: scale,
        center: center
    }
}