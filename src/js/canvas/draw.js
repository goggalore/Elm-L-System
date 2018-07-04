import { getContext } from './context.js';

export function renderDrawing(transforms, options) {
    const canvas = document.getElementById('canvasMain');
    const context = getContext(canvas, transforms, options);
    const path = transforms.path;

    for (var i = 0; i < path.length; i++) {
        if (path[i]['action'] === 'lineTo') {
            context.lineTo(path[i].x, path[i].y);
        }
        else {
            context.moveTo(path[i].x, path[i].y);
        }
    }
    context.stroke();
}