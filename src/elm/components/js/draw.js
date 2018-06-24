import { computePath, computeBounds, computeScale } from './path.js'

function renderStill(data) {
    const canvas = document.getElementById('canvasMain');
    const context = canvas.getContext('2d');

    const center = {x: canvas.width/2, y: canvas.height/2};
    const maxDimension = {width: canvas.width * 0.8, height: canvas.height * 0.75};

    const worker = new Worker('path.js')
    const path = computePath(data);
    const bounds = computeBounds(path);
    const scale = computeScale(bounds, maxDimension);

    context.save();
    context.beginPath();
    
    context.scale(scale, scale);
    context.translate(center['x']/scale - bounds.center['x'],
                    center['y']/scale - bounds.center['y']);
    context.lineWidth = 1/scale;
    context.strokeStyle = 'black';
    
    for (var i = 0; i < path.length; i++) {
        if (path[i]['action'] === 'draw') {
            context.lineTo(path[i].x, path[i].y);
        }
        else {
            context.moveTo(path[i].x, path[i].y);
        }
    }
    context.stroke();
}